library('gplots')
require("DMwR")

Dir=''
##Load PSI value matrix##
d1 <- read.table(paste(Dir,'refinedBySample.minPSI0.05.consPSI0.05.na0.99.cov10.splcing.merged_matrix.BrCa.HALLMARK_MYC_TARGETS_V2.sorted.txt.sliced.txt',sep=''),header=T,sep="\t",stringsAsFactors=F)
d2 <- read.table(paste(Dir,"refinedBySample.minPSI0.05.consPSI0.05.na0.99.cov10.splcing.merged_matrix.LCa.HALLMARK_MYC_TARGETS_V2.sorted.txt.sliced.txt",sep=''),header=T,sep="\t",stringsAsFactors=F)
d3 <- read.table(paste(Dir,"refinedBySample.stdNull.na0.99.cov10.splcing.merged_matrix.tissue.HALLMARK_MYC_TARGETS_V2.sorted.txt.sliced.txt",sep=''),header=T,sep="\t",stringsAsFactors=F)
data <- cbind(d1,d2[,-c(1:8)],d3[,-c(1:8)])
#data <- cbind(d1,d3[,-c(1:8)])
data.num <- data[,9:dim(data)[2]]
data.impute<-knnImputation(as.matrix(data.num))

##Load color value list##
getHeader <- function(Dir, group_info_fin, sorted_score_fin, data_name ){
  group_info<-read.table(paste(Dir,group_info_fin,sep=''),header=F,stringsAsFactors = F)
  score<-read.table(paste(Dir,sorted_score_fin,sep=''),header=F,stringsAsFactors = F)
  header<-as.data.frame(t(score[,2:length(score)]))
  index<-match(header$V1,group_info$V1)
  header$V3 <- paste0(data_name,group_info$V2[index])
  return(header)
}
header1=getHeader(Dir,'GroupInfo.BrCa.txt','HALLMARK_MYC_TARGETS_V2.sorted.BrCa.txt','BrCa-')
header2=getHeader(Dir,'GroupInfo.LCa.txt','HALLMARK_MYC_TARGETS_V2.sorted.LCa.txt','LCa-')
header3=getHeader(Dir,'GroupInfo.PCa.txt','HALLMARK_MYC_TARGETS_V2.sorted.PCa.txt','PCa-')


#header1 <- read.table(paste(Dir,'head_lab.BRCA.txt.anno.txt',sep=''),header=F,stringsAsFactors = F) 
#header2 <- read.table(paste(Dir,"head_lab.LUAD.txt.anno.txt",sep=''),header=F,stringsAsFactors = F)
#header3 <- read.table(paste(Dir,"header_lab.stdNull.na0.05.cov10.splcing.merged_matrix.tissue.txt.anno.txt",sep=''),header=F,stringsAsFactors = F)
header <- rbind(header1,header2,header3)
#header <- rbind(header1,header3)

colorf <- factor(header[,3], levels=unique(header[,3]))
color = as.numeric(colorf)
tmp <- replace(color, color==1,"cornflowerblue")
tmp <- replace(tmp, color==2,"darkgoldenrod1")
tmp <- replace(tmp, color==3,"darkgoldenrod3")

tmp <- replace(tmp, color==4,"aquamarine3")
tmp <- replace(tmp, color==5,"bisque")
tmp <- replace(tmp, color==6,"bisque3")

tmp <- replace(tmp, color==7,"darkolivegreen3")
tmp <- replace(tmp, color==8,"pink")
tmp <- replace(tmp, color==9,"chocolate2")
tmp <- replace(tmp, color==10,"mediumorchid1")
tmp <- replace(tmp, color==11,"red")
tmp <- replace(tmp, color==12,"darkred")
tmp <- replace(tmp, color==13,"lightblue")
tmp <- replace(tmp, color==14,"darkgreen")
color = tmp


#Heatmap3
library("RColorBrewer")
data.matrix.z <- t(scale(t(data.impute),center=T,scale=T))

source('heatmap3.R')

my_palette =colorRampPalette((brewer.pal(n = 11, name="RdBu")))(n=299) # n must be less than 100+100+100
breaks = c(seq(-4,-0.5,length=80),seq(-0.5,0.5,length=140),seq(0.5,4,length=80))

map2color<-function(x,pal,limits=NULL){
  if(is.null(limits)) limits=range(x)
  pal[findInterval(x,seq(limits[1],limits[2],length.out=length(pal)+1), all.inside=TRUE)]
}

score_bar<- map2color(t(as.numeric(as.matrix(header$V2))),colorRampPalette(c("white", "black"))(length(color)),limits=c(min(t(as.numeric(as.matrix(header$V2)))),max(t(as.numeric(as.matrix(header$V2))))))
group_bar  <- as.matrix(as.character(color))
clab=cbind(group_bar,score_bar)

###############  save as pdf ##########
pdf("heat_rowclust_twobar.Multicancer.smallfont.pdf",width=9,height=5)
heat <- heatmap.3(data.matrix.z , na.rm = F, scale="none", dendrogram="none", margins=c(0.5,0.5),
                  symbreaks=FALSE, key=TRUE, symkey=FALSE,Rowv=T, Colv=F,breaks=breaks,
                  density.info="none", trace="none",labCol=F, labRow=F, cexRow=0.1, col = my_palette,symm=F,
                  ColSideColors=clab, ColSideColorsSize=3, KeyValueName="")


legend(x=.45,y=1.01, ncol=2,legend=c("BrCa-Normal-GTEx (218)", "BrCa-Benign-TCGA (111)","BrCa-Tumor-TCGA (116)","LCa-Normal-GTEx (351)", "LCa-Benign-TCGA (59)","LCa-Tumor-TCGA (70)","PCa-Normal-GTEx (119)","PCa-Benign-TCGA (52)","PCa-Primary-TCGA (499)","PCa-CRPC-Beltran (34)","PCa-CRPC-Robinson (90)","PCa-CRPC-SU2C (60)","PCa-NE-SU2C (8)","PCa-NE-Beltran (15)"),
       fill=c("cornflowerblue","darkgoldenrod1","darkgoldenrod3","aquamarine3","bisque","bisque3","darkolivegreen3", "pink","chocolate2","darkred","red","mediumorchid1","darkslategray3","darkgreen"),border=FALSE, bty="n", y.intersp = 0.83, cex=0.35)

dev.off()





