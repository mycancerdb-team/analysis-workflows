# There is a top level pipeline-dag.yaml that will maintain the dag for the entire workflow.
# Each part of the workflow will have its own workflowTemplate generated with templates for each step that is part of the relevant process folder
# Templates will be pulled into the DAG
# Environment variables and configMap
# PVCs generated as part of high level template and fed to Template templates
