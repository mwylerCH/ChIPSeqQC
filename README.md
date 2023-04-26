# ChIPSeqQC

This repository serves as a wrapper for the [ChIPQC](https://bioconductor.org/packages/release/bioc/html/ChIPQC.html) package in Bioconductor, simplifying the processing and analysis of ChIP-seq-derived BAM files. The only requirement is the installation of the ChIPQC package. Additionally, the wrapper can accept peak files in BED format as optional input.

### Usage:
```{sh}
# installation
chmod +x ChipSeqQC/chipQC.R

# run with bam
ChipSeqQC/chipQC.R file.bam

# run with peak file
ChipSeqQC/chipQC.R file.bam peaks.bed
```

### Output

A single csv row table with the following columns:
- *Reads*: Number of reads in the bam.
- *Map%*: Share of mapped reads.
- *Filt%*: Mapped reads with a quality above 15.
- *Dup%*: Amount of duplicated reads, an indication on the library quality.
- *ReadL*: Read length.
- *FragL*: The estimated mean fragment length on each read.
- *RelCC*: Quality score of the ChIP (higher means better). Based on the comparison of the maximal cross coverage peak with the cross coverage a shift by *ReadL*.
- *SSD*: Quality score of the ChIP (higher means better). Density of positions with different pileup values.
- *Rip%*: Share of reads in peak regions (only available if peak files is submitted).
- *BamName*: Name of the analyzed bam file
