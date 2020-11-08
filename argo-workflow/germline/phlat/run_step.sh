sample=$1
bam=$2

if [[ ! -d $sample/results ]];then
    mkdir -p $sample/results
fi

tmpdir=$sample/tmp
mkdir -p $tmpdir

phlatdir=/opt/phlat-release
datadir=$sample
indexdir=/ref-hg38/phlat-release
rsdir=$sample/results
b2url=/usr/local/bin/bowtie2
tag=$sample
fastq1="hlaPlusUnmapped_1.fastq.gz"
fastq2="hlaPlusUnmapped_2.fastq.gz"
ref_fasta=/ref-hg38/reference_genome/all_sequences.fa

#extract hla regions and unmapped reads
samtools view -h -T $ref_fasta $bam chr6:29836259-33148325 >>$tmpdir/reads.sam
samtools view -H -T $ref_fasta $bam | grep "^@SQ" | cut -f 2 | cut -f 2- -d : | grep HLA | while read chr;do

# echo "checking $chr:1-9999999"
samtools view -T $ref_fasta $bam "$chr:1-9999999" >>$tmpdir/reads.sam
done

# filter reads with flags 4 and convert to bam
samtools view -f 4 -T $ref_fasta $bam >>$tmpdir/reads.sam
samtools view -Sb -o $tmpdir/reads.bam $tmpdir/reads.sam

# Create fastq files from bam
/usr/bin/java -Xmx6g -jar /usr/picard/picard.jar SamToFastq VALIDATION_STRINGENCY=LENIENT F=$sample/hlaPlusUnmapped_1.fastq.gz F2=$sample/hlaPlusUnmapped_2.fastq.gz I=$tmpdir/reads.bam R=$ref_fasta FU=$sample/unpaired.fastq.gz

#workaround to get everything passed in appropriately
echo "python -O ${phlatdir}/dist/PHLAT.py -1 ${datadir}/${fastq1} -2 ${datadir}/${fastq2} -index $indexdir -b2url $b2url -orientation "--fr" -tag $tag -e $phlatdir -o $rsdir -tmp 0 -p 4" >$sample/run_phlat.sh

python -O ${phlatdir}/dist/PHLAT.py -1 ${datadir}/${fastq1} -2 ${datadir}/${fastq2} -index $indexdir -b2url $b2url -orientation "--fr" -tag $tag -e $phlatdir -o $rsdir -tmp 0
