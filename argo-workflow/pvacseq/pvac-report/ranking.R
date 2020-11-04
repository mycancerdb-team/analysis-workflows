## two required arguments:
## 1) input all_epitopes.tsv file from pvactools
## 2) output file - ranked list
## 3) (optional) estimated VAF of the founding clone

##assign mutations to a "Classification" based on their favorability
getTier <- function(mutation, vaf.clonal){

    anchor_residue_pass = TRUE
    anchors=c(1,2,nchar(mutation$MT.Epitope.Seq)-1,nchar(mutation$MT.Epitope.Seq))
    if(mutation$Mutation.Position %in% anchors){
        if(is.na(mutation$Median.WT.Score)){
            anchor_residue_pass = FALSE
        } else {
            if( mutation$Median.WT.Score < 1000){
                anchor_residue_pass = FALSE
            }
        }
    }

    #writing these out as explicitly as possible for ease of understanding
    if(mutation$Median.MT.Score < 500 &
       (mutation$Tumor.RNA.VAF) * mutation$Gene.Expression > 3 &
       mutation$Tumor.DNA.VAF > (vaf.clonal/2) &
       anchor_residue_pass){
        return("Pass")
    }
    #relax mt and expr
    if(mutation$Median.MT.Score < 1000 &
       (mutation$Tumor.RNA.VAF) * mutation$Gene.Expression > 1 &
       mutation$Tumor.DNA.VAF > (vaf.clonal/2) &
       anchor_residue_pass){
        return("Relaxed")
    }
    #anchor residues
    if(mutation$Median.MT.Score < 1000 &
       (mutation$Tumor.RNA.VAF) * mutation$Gene.Expression > 1 &
       mutation$Tumor.DNA.VAF > (vaf.clonal/2) &
       !anchor_residue_pass){
        return("Anchor")
    }
    #not in founding clone
    if(mutation$Median.MT.Score < 1000 &
       (mutation$Tumor.RNA.VAF) * mutation$Gene.Expression > 1 &
       mutation$Tumor.DNA.VAF < (vaf.clonal/2) &
       anchor_residue_pass){
        return("Subclonal")
    }

    #relax expression.  Include sites that have reasonable vaf but zero overall gene expression
    lowexpr=FALSE
    if(((mutation$Tumor.RNA.VAF) * mutation$Gene.Expression > 0) |
       (mutation$Gene.Expression == 0 & mutation$Tumor.RNA.Depth > 50 & mutation$Tumor.RNA.VAF  > 0.10)){
        lowexpr=TRUE
    }
    #if low expression is the only strike against it, it gets lowexpr label (multiple strikes will pass through to poor)
    if(mutation$Median.MT.Score < 1000 &
       lowexpr &
       mutation$Tumor.DNA.VAF > (vaf.clonal/2) &
       anchor_residue_pass){
        return("LowExpr")
    }

    #zero expression
    if((mutation$Gene.Expression == 0 | mutation$Tumor.RNA.VAF == 0) & !lowexpr){ #& (mutation$Tumor.RNA.Depth < 50 | mutation$Tumor.RNA.VAF < 0.10)){
        return("NoExpr")
    }

    #everything else
    return("Poor")
}


getBestMutLine <- function(b, hla_types, max_ic50=1000, vaf.clonal){
    ## #set a hard threshold of median ic50 <= 1000
    ## b = b[b$Median.MT.Score < max_ic50,]

    #order by best median score
    b = b[order(b$Median.MT.Score),]

    #get best ic50 peptide for display
    best =  b[1,]
    tier=getTier(best, vaf.clonal)

    #these counts should represent only the "good binders" with ic50 < max
    #for all sites other than tier4 slop
    hla=rep("FALSE",length(hla_types))
    anno.count = 0
    peptide.count = 0
    d = b[b$Median.MT.Score < max_ic50,]
    if(nrow(d) > 0){
        d = b[b$Median.MT.Score < max_ic50,]
        hla = hla_types %in% unique(d$HLA.Allele)
        #get a list of all unique gene/transcript/aa_change combinations
        #print(unique(d[,c("Transcript","Gene.Name","Mutation","Protein.Position")]))
        anno.count = nrow(unique(d[,c("Transcript","Gene.Name","Mutation","Protein.Position")]))
        #store a count of all unique peptides that passed
        peptide.count = length(unique(d$MT.Epitope.Seq))
    }
    hla[hla==TRUE]="X"
    hla[hla==FALSE]=""
    names(hla)=gsub("HLA-","",hla_types)

    aas = strsplit(best$Mutation,"/")
    best$aachange = paste0(aas[[1]][1],best$Protein.Position,aas[[1]][2])

    #assemble the line
    df = NULL;
    df = t(cbind(df,hla))
    df = cbind(df, data.frame(Gene=best$Gene.Name,AA.change=best$aachange,Num.Transcript=anno.count,Peptide=best$MT.Epitope.Seq,
               Pos=best$Mutation.Position,Num.Peptides=peptide.count,ic50.MT=best$Median.MT.Score, ic50.WT=best$Median.WT.Score,
               RNA.expr=best$Gene.Expression, RNA.VAF=best$Tumor.RNA.VAF, RNA.Depth=best$Tumor.RNA.Depth,
               DNA.VAF=best$Tumor.DNA.VAF, tier=tier))

    return(df)
}


#sort the table in our preferred manner
sortTable <- function(x){
    #make sure the tiers sort in the expected order
    #x$tier <- factor(x$tier,factor(c("tier1","tier2","tier3","tier4")))
    x$tier <- factor(x$tier,factor(c("Pass","Relaxed","LowExpr","Anchor","Subclonal","Poor","NoExpr")))


    ## #tiers 1 and 2 get ranked by expression level and ic50 alone, with expr counting double
    ## t12 = x[x$tier %in% c("tier1","tier2"),]
    ## t12 = t12[order(t12$tier, order(t12$RNA.expr) + order(t12$ic50.MT,decreasing=T)),]

    rank.ic50=NA
    rank.ic50[order(x$ic50.MT)] = 1:nrow(x)
    rank.expr=NA
    rank.expr[order(x$RNA.expr*x$RNA.VAF,decreasing=T)] = 1:nrow(x)

    x = x[order(x$tier, (rank.expr+rank.ic50) ),]
    #tiers 3 and 4 get clonality taken into account
    return(x)
}

#return a list of all unique gene/transcript/aa_change combinations for onclick
getAllTranscripts <- function(b){
    return(unique(b[,c("Transcript","Gene.Name","Mutation","Protein.Position")]))
}



#a = read.table("pt33_full.tst.txt",sep="\t",header=T,stringsAsFactors=F)
#a = read.table("~/tmp/TUMOR.all_epitopes.tsv",sep="\t",header=T,stringsAsFactors=F)
args <- commandArgs(trailingOnly = TRUE)
a = read.table(args[1],sep="\t",header=T,stringsAsFactors=F,fill=T)

#treat NAs as non-expressed
if(length(which(is.na(a$Tumor.RNA.VAF))) > 0){
    a[is.na(a$Tumor.RNA.VAF),]$Tumor.RNA.VAF = 0
}
if(length(which(is.na(a$Tumor.RNA.Depth))) > 0){
    a[is.na(a$Tumor.RNA.Depth),]$Tumor.RNA.Depth = 0
}


## get a list of all represented hla types
hla_types = unique(a$HLA.Allele)
## get a list of unique mutations
a$key=paste(a$Chromosome,a$Start,a$Stop,a$Reference,a$Variant,sep="-")
muts = unique(a$key)

#do a crude estimate of clonal vaf/purity if none was provided
vaf.clonal=as.numeric(args[3])
if(is.na(vaf.clonal)){
    vafs = rev(sort(unique(a$Tumor.DNA.VAF)))
    vaf.clonal=vafs[vafs<0.60][1]
}

peptide_table = NULL;

for(m in muts){
    #print(m)
    b = a[a$key==m,]
    mutline = getBestMutLine(b,hla_types,500,vaf.clonal)
    #peptide_table = rbind(peptide_table, mutline, m)
    peptide_table = rbind(peptide_table, cbind(mutline, m))
}
rownames(peptide_table)=c() #clean up nonsense row names
peptide_table = sortTable(peptide_table)

#levels(peptide_table$tier)=c("tier1","tier2","tier3","tier4") #make sure it sorts correctly
#peptide_table = addRanks(peptide_table)

write.table(peptide_table,args[2],sep="\t",row.names=F,quote=F)
