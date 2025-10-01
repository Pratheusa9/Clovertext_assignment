nextflow.enable.dsl = 2

params.input = "samples.csv"
params.outdir = "Input_data"
params.vep_cache = "/home/unicorn/.vep"

process VEP_ANNOTATION {
    label 'vep'
    container 'ensemblorg/ensembl-vep:release_115.0'
    
    input:
    tuple val(sample), path(vcf), val(gender), val(case_control)
    path outdir
    
    output:
    path("${params.outdir}/${sample}.vep.vcf"), emit: vcf
    path("${params.outdir}/${sample}.vep.html"), emit: html
    path("${params.outdir}/${sample}.log"), emit: log
    
    script:
    """
    # Create output directory if it doesn't exist
    mkdir -p ${params.outdir}
    
    echo "=== Starting VEP for $sample ===" > ${params.outdir}/${sample}.log
    echo "Input: $vcf" >> ${params.outdir}/${sample}.log
    echo "Time: \$(date)" >> ${params.outdir}/${sample}.log
    echo "Output: ${params.outdir}/${sample}.vep.vcf" >> ${params.outdir}/${sample}.log
    
    # Run VEP with output directly to the specified directory
    vep \
        -i $vcf \
        -o ${params.outdir}/${sample}.vep.vcf \
        --format vcf \
        --vcf \
        --force_overwrite \
        --cache \
        --dir_cache /vep_cache \
        --species homo_sapiens \
        --assembly GRCh37 \
        --cache_version 115 \
        --offline \
        --fork 4 \
        --buffer_size 5000 \
        --everything \
        --stats_file ${params.outdir}/${sample}.vep.html \
        2>&1 | tee -a ${params.outdir}/${sample}.log
    
    echo "=== COMPLETED: $sample at \$(date) ===" >> ${params.outdir}/${sample}.log
    """
}

workflow {
    // Create output directory at start
    def outdir = file(params.outdir)
    outdir.mkdirs()
    
    Channel.fromPath(params.input)
        | splitCsv(header: true, sep: ',')
        | map { row -> 
            tuple(
                row.Sample_Name, 
                file(row.VCF_File_Path), 
                row.Gender, 
                row.Case_Control
            ) 
          }
        | set { samples_ch }
    
    VEP_ANNOTATION(samples_ch, outdir)
    
    VEP_ANNOTATION.out.vcf
        | collect
        | view { files -> 
            """
            ===========================================
            PIPELINE COMPLETED SUCCESSFULLY!
            Generated ${files.size()} annotated VCF files
            Output directory: ${params.outdir}
            ===========================================
            """
        }
}
