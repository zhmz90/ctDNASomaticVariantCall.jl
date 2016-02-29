import pysam
samfile = pysam.AlignmentFile("../data/bam/004_gdna_rg.bam", "rb" )
i = 0
for pileupcolumn in samfile.pileup("chr1", 100000, 200020):
    if pileupcolumn.pos < 100000:
        continue

    print ("\ncoverage at base %s = %s" %
           (pileupcolumn.pos, pileupcolumn.n))
    for pileupread in pileupcolumn.pileups:
        if not pileupread.is_del and not pileupread.is_refskip:
            # query position is None if is_del or is_refskip is set.
            print ('\tbase in read %s %d %s %s %d' %
                  (pileupread.alignment.query_name,pileupread.query_position,pileupread.alignment.query_sequence,
                   pileupread.alignment.query_sequence[pileupread.query_position],i))
    i+=1
    if i==13804:
        break

    
print i
samfile.close()
