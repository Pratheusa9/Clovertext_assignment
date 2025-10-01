# Clovertext_assignment1

Steps :
    1. Git cloned VEP and installed VEP locally
    2. Downloaded VEP cache for GRCh37
    3. Command to run VEP
       for a in test1_data_1.vcf test2_data_1.vcf; do echo $a; perl /media/unicorn/9bdc830b-bdb0-4a72-8b48-19a70a15b888/Tools/ensembl-vep/vep --format vcf -i $a --vcf -o ${a/vcf/annotated.vcf} --cache --check_existing --offline --buffer_size 2000 --fork 4; done
    4. Create jupyter notebook -
        1. Read annotated vcf using pysam
        2. Follow the notebook for completing the tasks (each task is mentioned in a separate cell)
