library('gplots')
require("DMwR")

##Load color value list##
label_file<-read.table('../psi.matrix/tissue/label.stdNull.na0.05.cov10.splcing.merged_matrix.tissue.txt',header=F)

##Load PSI value matrix##
d <- read.table("../psi.matrix/tissue/stdNull.na0.05.cov10.splcing.merged_matrix.tissue.txt",header=T,sep="\t",stringsAsFactors=F)

#adding group labels
d.num <- d[,9:dim(d)[2]]
d.membered <- cbind(label_file,t(d.num))[-which(label_file[,1]==13|label_file[,1]==12),] #minus BGI dataset

color_t <- d.membered[,1]
stage<-d.membered[,2]
d.t<-as.matrix(d.membered[,c(-1,-2)])
dim(d.t)

##Assign Colors
palette(c("chocolate2", "darkorchid3", 'lightblue','deepskyblue',"darkolivegreen3","grey","darkgrey","black","darkred","pink","darkgreen","goldenrod2","goldenrod4","red","mediumorchid1","darkslategray3"))
leg_sample_tissue=c("Normal-GTEx (119)","Benign-TCGA (52)","Primary-TCGA (499)","CRPC-Beltran (34)","CRPC-Robinson (90)","CRPC-SU2C (60)","NE-SU2C (8)","NE-Beltran (15)")
leg_color_tissue=c("darkolivegreen3", "pink","chocolate2","darkred","red","mediumorchid1","darkslategray3","darkgreen")

##Missing data imputation##
d.impute<-knnImputation(d.t)

##PCA##
pca<-prcomp(d.impute)
plot(pca, main='Variance explained by PCs')
pca.pvar <- round((pca$sdev^2)*100/sum(pca$sdev^2),2)
plot(pca.pvar)

#silhouette Feb2018
library(factoextra)
library(cluster)
pdf(file="PCA12.tissue.psi.silhouette.pdf",width = 6, height = 4)
df<- as.data.frame(cbind(pca$x[,1], pca$x[,2]))
dist.df<-dist(df)
ss <- silhouette(stage, dist(df))
plot.new()
plot.window(xlim=c(-1,1), ylim=c(0,1000))
plot(ss,border=NA,,col=c(5,1,15),add=T,main='',do.clus.stat=T)
dev.off()

#pc1 loading
pc1<- pca$rotation[,1]
index <- which(pc1 < -0.02 | pc1 > 0.02)
out <- cbind(d$GeneName,pc1)
colnames(out) <- c("GeneName", "PC1")
write.table(out,file="gene_pc1.txt",quote = F,row.names = F)
write.table(out[index,],file="gene_pc1_cufoff0.02.txt",quote = F,row.names = F)
#pc2 loading
pc2<- pca$rotation[,2]
index <- which(pc2 < -0.02 | pc2 > 0.02)
out2 <- cbind(d$GeneName,pc2)
colnames(out2) <- c("GeneName", "PC2")
write.table(out2,file="gene_pc2.txt",quote = F,row.names = F)
write.table(out2[index,],file="gene_pc2_cufoff0.02.txt",quote = F,row.names = F)

# tissue #Jan/2018
library("plotrix")
pdf(file="PCA12.tissue.psi.pdf",width = 6, height = 4)
par(mar=c(2, 2, 2, 8), xpd=TRUE)
plot(pca$x[,1], pca$x[,2], col=color_t, pch=16, xlab='', ylab='',axes=F)
draw.circle(-2.2,1.5,3.4,nv=100,border=NULL,col=NA,lty=2,lwd=1.5)
draw.circle(7.5,2,3.5,nv=100,border=NULL,col=NA,lty=2,lwd=1.5)
draw.circle(2.8,-4.8,4.3,nv=100,border=NULL,col=NA,lty=2,lwd=1.5)
text(-3,5.8,'Primary',cex=1.2)
text(7.5,6.3,'Normal',cex=1.2)
text(7.5,-7.8,'Mets',cex=1.2)
#rect(-5.5,-1.5,2.5,3.7,lty=2)
axis(1,lwd=1,at=seq(round(min(pca$x[,1])),round(max(pca$x[,1])),4),tck = -0.01,line = 0,mgp=c(0, 0.1, 0))
axis(2,lwd=1,at=seq(round(min(pca$x[,2])),round(max(pca$x[,2]))+2,4),tck = -0.01,line = 0,mgp=c(0, 0.1, 0))
legend(11,7,text.width=1.2,x.intersp=0.5,y.intersp=1.5,text.font= 1,legend= leg_sample_tissue, col=leg_color_tissue, pch=c(16,16,16,16,16),cex=0.8,pt.cex=1.2, bty="n",
       title=" ",title.adj= 7)
legend(11,7,'Prostate samples',cex=0.9,bty='n',text.font=1,x.intersp = 0)
title(ylab = "PC 2 (5%)",xlab = "PC 1 (7%)", line = 1, cex.lab = 1, main='',font.lab=1)
dev.off()


