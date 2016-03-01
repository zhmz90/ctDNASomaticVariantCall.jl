module Run

function bam2pileup(bam_rg)
    
    ref = "/home/guo/haplox/Github/ctDNASomaticVariantCall/data/ref/hg19/ucsc.hg19.fasta"
    bed = "/home/guo/haplox/Github/ctDNASomaticVariantCall/data/Lung_Roche.bed"
    bam_rg_new = joinpath("output", string(basename(bam_rg[1:end-4]), "_new.bam"))
    pileup = joinpath("output", string(basename(bam_rg[1:end-4]), ".pileup"))
    prefix = basename(bam_rg)[1:end-4]
    
    if !isfile(bam_rg_new)
        cmd1 = `samtools view -b -u -q 1  $bam_rg`
        info(cmd1)
        success(pipeline(cmd1 ,stdout=bam_rg_new))
    end
    if !isfile(pileup)
        cmd2 = `samtools mpileup -f $ref  -l $bed $bam_rg_new`
        info(cmd2)
        success(pipeline(cmd2, stdout=pileup))
    end
    cd("output") do
        cmd1 = `perl /home/guo/haplox/Github/pileup2base/pileup2baseindel.pl -i $pileup  -prefix $prefix `
        info(cmd1)
        success(cmd1)
    end
    
end

function bams2pileups()
    bams = map(x->joinpath("data", x), readdir("data"))
    pmap(bam2pileup, bams)    
end


end
