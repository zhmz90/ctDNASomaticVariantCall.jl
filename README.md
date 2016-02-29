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

###### [Empirical Bayesian Approach to High-Sensitivity Variant Calling in Circulating Tumor DNA Samples](https://www.amstat.org/meetings/jsm/2015/onlineprogram/AbstractDetails.cfm?abstractid=317363)

> The detection of circulating tumor DNA (ctDNA) in blood samples via targeted sequencing of genes of interest is a promising approach for cancer diagnosis and biomarker development. Since most tumor-associated mutations appear as very low frequency variants in the ctDNA sequencing data, a highly sensitive and specific analysis method is critical to distinguish true mutations from noise-driven, low frequency false positives. This requires accurate estimates of background error rates, which vary significantly by genomic position. We propose a hierarchical beta-binomial model which combines an estimate of substitution type-specific prior distribution for the error rate with observed variant calls in a set of normal samples to yield a full set of position-specific posterior distributions. By employing a series of spike-ins of synthetic DNA molecules containing known variants at low frequency, we showed that our analytic approach enables reliable variant detection even at very low frequencies while still controlling the false positive rate. Our approach is a promising tool for the detection, characterization, and monitoring of human tumors via ctDNA. 



###### [lh3-reply on Biostar](https://www.biostars.org/p/19104/)

> Perhaps you should read my samtools paper, where I did an experiment on finding rare differences between data from different sources but for the same individual.

> In general, my view is as long as read placement is perfect, even naive methods work sufficiently well. Complex methods only give you theoretical comfort in that case. One of hard parts is all kinds of alignment artifacts. SNVMix and another paper published in Bioinformatics last year try to resolve this by machine learning using multiple statistics that may imply alignment errors. I, however, always prefer to tackle a problem directly, if we can, rather than via machine learning. To me, the simplest yet most effective strategy is to use two distinct alignment algorithms, such as bwa and bwa-sw, which have distinct error modes. You only consider mutations shared between the two alignments. False calls will be vastly reduced. Using decoy sequence also helps around centromeres.

> Another complication is structural variations, in which I am less experienced. In some sense, false mutations caused by structural variations are still indication of something different between normal and tumor.

> In all, I think you do not need to worry about which software to use for detecting somatic mutations - anything reasonable is fine. You should pay more attention to mismapping and structural variations. My sanger colleagues from the Cancer Group would agree with me. They have published many high-profile papers.
  

### Simulate variant data to benchmark cfDNA somatic variant call
- just directly add mutations similar depth with gDNA errors to the cfDNA as true positive part of ground truth
- add sequence or alignment errors in gDNA to cfDNA as false positive part of ground negative

### References
- [Combining tumor genome simulation with crowdsourcing to benchmark somatic single-nucleotide-variant detection](http://www.nature.com/nmeth/journal/v12/n7/pdf/nmeth.3407.pdf)
