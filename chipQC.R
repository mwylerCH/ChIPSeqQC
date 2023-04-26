#!/usr/bin/env Rscript 
# QC for ChiP Seq experiments
# Wyler Michele, Glarus Switzerland, April 26th 2023

args <- commandArgs(TRUE)
BAM <- args[1]
PEAK <- args[2]


# suppress warnings
options(warn=-1)

# system('mount /media/pure/')
require(ChIPQC)
# BAM <- '/media/pure/0_TRANS/ChIPseq/V51.deDup.bam'
# BAM <- '/home/mwyler/tempCHIP/IN1.deDup.bam'

# test if file present + index
if(file.exists(BAM)){
  index <- paste0(BAM, '.bai')
  if (!file.exists(index)){
    stop(print(paste0('ERROR: ',basename(BAM), ' needs a index file *bai.')), call. = F)
  }
}else{
  stop(print(paste0('ERROR: ',basename(BAM), ' not found in folder ', dirname(BAM))), call. = F)
}

# read in Bam
if (length(args) == 1){
  # chipObj <- invisible(suppressMessages(suppressWarnings(ChIPQCsample(BAM, verboseT=FALSE))))
  log <- capture.output(
    chipObj <- ChIPQCsample(BAM, verboseT=FALSE)
  )
}else if (length(args) == 2) {
  if (!file.exists(index)) {
    stop(print('ERROR: No peak file found.'), call. = F)
  }else{
    log <- capture.output(
      chipObj <- suppressMessages(ChIPQCsample(BAM, PEAK, verboseT=FALSE))
    )
  }
}

# # get metrics 
tabellaRaw <- QCmetrics(chipObj)

# format output
tabellaRaw <- as.data.frame(tabellaRaw)
outTable <- as.data.frame(matrix(nrow = 1, ncol = nrow(tabellaRaw)+1))
colnames(outTable) <- c(rownames(tabellaRaw), 'BamName')
outTable[1,] <- c(unlist(tabellaRaw), basename(BAM))
write.table(outTable, quote = F, sep = ',', row.names = F)
