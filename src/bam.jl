using PyCall
@pyimport pysam

const fl = "../data/bam/004_gdna_rg.bam"

samfile = pysam.AlignmentFile(fl, "rb")

for read in samfile[:fetch]("chr1", 100, 500)
    println(read)
end

