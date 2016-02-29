# ctDNASomaticVariantCall

Linux, OSX: [![Build Status](https://travis-ci.org/zhmz90/ctDNASomaticVariantCall.jl.svg?branch=master)](https://travis-ci.org/zhmz90/ctDNASomaticVariantCall.jl)

You can star this repository to help other people find it if this package is useful for you.

### Focus
- cancer genomes in blood

### Questions
- Are somatic mutations related with its context?
- What is the difference for various somatic variant callers?
- 

### New Ideas and Discoveries
- Can we tune the parameters of variant call software to fit simulated data and get better performance on read data?
- mutation calls should be made by aggregating multiple algorithms
- the importance of context-specific errors in sequencing and what about somatic mutation?
- Sharp ratio aka rist adjusted return will be helpful to ensemble variant callers based on performance of various parameters to generalize to real datasets

### RoadMap
- massively parallal simulate NGS reads or somatic variant
- benchmark existing variant call software 
- tuning parameters to see whether accuracy will improve
- new variant call method

### Awesome tools

##### Simulate somatic variants data
- [BAMSurgeon](https://github.com/adamewing/bamsurgeon) for accurate tumor genome simulation: directly adding synthetic mutations to existing reads
- [wgsim: not maintained](https://github.com/lh3/wgsim/) is a small tool for simulating sequence reads from a reference genome which only approximate sequencing error profiles. 
- adimixture of polymorphic sites between existing BAM sequence alignment files

##### Variant Caller
- [Biostars list](https://www.biostars.org/p/19104/)

- [Varscan2](http://varscan.sourceforge.net/)
- [MuTect](https://www.broadinstitute.org/cancer/cga/mutect)
- [Strelka](https://sites.google.com/site/strelkasomaticvariantcaller)
- [somatic-sniper](https://github.com/genome/somatic-sniper)
- [RAID]()
- [bcbio-nextgen](https://github.com/chapmanb/bcbio-nextgen)

### Awesome insights
- [Validating multiple cancer variant callers and prioritization in tumor-only samples](https://bcbio.wordpress.com/tag/mutect/)
- [lh3-reply on Biostar](https://www.biostars.org/p/19104/)

### Simulate variant data to benchmark cfDNA somatic variant call
- just directly add mutations similar depth with gDNA errors to the cfDNA as true positive part of ground truth
- add sequence or alignment errors in gDNA to cfDNA as false positive part of ground negative

### References
- [Combining tumor genome simulation with crowdsourcing to benchmark somatic single-nucleotide-variant detection](http://www.nature.com/nmeth/journal/v12/n7/pdf/nmeth.3407.pdf)
