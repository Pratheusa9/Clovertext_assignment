# Clovertext_assignment2

Steps :
    1. Installed docker
    2. Granted permissions to docker
    3. Created the main.nf file
    4. Created the nextflow.config file
    5. Created a InputSamples.csv
           Sample_Name,VCF_File_Path,Gender,Case_Control
           test1_data_1.vcf,/media/unicorn/9bdc830b-bdb0-4a72-8b48-19a70a15b888/CTX-Bioinformatics-Intern-Assignment/Input_data/test1_data_1.vcf,Male,Case
           test2_data_1.vcf,/media/unicorn/9bdc830b-bdb0-4a72-8b48-19a70a15b888/CTX-Bioinformatics-Intern-Assignment/Input_data/test2_data_1.vcf,Male,Control
    6. Command to run the nextflow pipeline - 
       nextflow run main.nf --input InputSamples.csv --outdir Input_data/ -with-docker
    7. Output files generated (for input files – test1_data_1.vcf and test2_data_1.vcf)
        ◦ In the current directory – report-20251001-66927178.html, timeline-20251001-66927178.html and trace-20251001-66927178.txt
        ◦ In the output directory – test1_data_1.vcf.vep.vcf, test1_data_1.vcf.vep.html, test1_data_1.vcf.vep.log, est2_data_1.vcf.vep.vcf, test2_data_1.vcf.vep.html and test2_data_1.vcf.vep.log


