# VariantCall

Linux, OSX: [![Build Status](https://travis-ci.org/zhmz90/VariantCall.jl.svg?branch=master)](https://travis-ci.org/zhmz90/VariantCall.jl)

You can star this repository to help other people find it if this package is useful to you.

### Focus
- cancer genomes in blood

### RoadMap
- massively parallal simulate NGS reads or somatic variant
- benchmark existing variant call software 
- new variant call method

### Awesome tools
- [BAMSurgeon](https://github.com/adamewing/bamsurgeon) for accurate tumor genome simulation

### Awesome insights

- [lh3](https://www.biostars.org/p/19104/)

### Simulate variant data to benchmark cfDNA somatic variant call
- just directly add mutations similar depth with gDNA errors to the cfDNA as true positive part of ground truth
- add sequence or alignment errors in gDNA to cfDNA as false positive part of ground negative

### References
- [Combining tumor genome simulation with crowdsourcing to benchmark somatic single-nucleotide-variant detection](http://www.nature.com/nmeth/journal/v12/n7/pdf/nmeth.3407.pdf)
