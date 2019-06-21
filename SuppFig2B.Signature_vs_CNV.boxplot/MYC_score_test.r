data <- read.table("HALLMARK_MYC_TARGETS_V2.scores.txt.fix",header = F,stringsAsFactors = F)
patient <- read.table("PATIENT_DATA_oncoprint.tsv",header = F,stringsAsFactors = F,sep = '\t')
t.patient <- t(patient)
data[,1] <- gsub("-01A", "", data[,1])
data[,1] <- gsub("-01B", "", data[,1])

psi <- read.table("srsf3.txt",header = F,stringsAsFactors = F)
psi<-as.matrix(t(psi[,9:dim(psi)[2]]))
psi[,1] <- gsub("-01A", "", psi[,1])
index.psi <- match(data[,1],psi[,1])
data$V6<-as.numeric(psi[index.psi,2])


normal <-data[which(data[,3]== "Benign-GTEx"),]
beign <-data[which(data[,3]== "Benign-TCGA"),]
primary <- data[which(data[,3]== "Primary-TCGA"),]
CRPC1<-data[which(data[,3]== "CRPC-Beltran"),]
CRPC2<-data[which(data[,3]== "CRPC-Robinson"),]
CRPC3<-data[which(data[,3]== "CRPC-SU2C"),]
CRPC<-data[which(data[,3]== "CRPC-SU2C" | data[,3]== "CRPC-Robinson" | data[,3]== "CRPC-Robinson"),]
NE1<-data[which(data[,3]== "NE-Beltran"),]
NE2<-data[which(data[,3]== "NE-SU2C"),]
index <- match(primary[,1],t.patient[,1])

primary$V7 <- t.patient[index,2]
primary$V8 <- t.patient[index,4]
primary1 <- primary[which(primary$V7=="Amplification"),]
primary2 <- primary[which(primary$V8=="mRNA Upregulation"),]
primary3 <- primary[which(primary$V7!="Amplification" & primary$V8!="mRNA Upregulation"),]

b <- cbind(beign[,5],rep("Benign",nrow(beign))); p1 <- cbind(primary1[,5],rep("Primary1",nrow(primary1)))
p2 <- cbind(primary2[,5],rep("Primary2",nrow(primary2))); p3 <- cbind(primary3[,5],rep("Primary3",nrow(primary3)))
MYC_score.df <- data.frame(rbind(b,p3,p1,p2),stringsAsFactors=FALSE)
MYC_score.df$X1 <- as.numeric(MYC_score.df$X1)
library(ggpubr)
compare_means(X1 ~ X2,  data = MYC_score.df, method='wilcox.test')
my_comparisons <- list( c("Benign", "Primary3"), c("Primary3", "Primary1"), c("Primary3", "Primary2") )
pdf("pathway_vs_psi.SRSF3.onlyTCGA.test.pdf",width=4, height=4)
ggboxplot(MYC_score.df,"X2","X1",fill="X2",palette =c("pink","chocolate2","chocolate2","chocolate2"),
          ylab=c("Myc Pathway Score"),xlab=FALSE,
          bxp.errorbar=T,
          width = 0.7)+ 
  theme(legend.position = "right",legend.title = element_blank(),
        axis.text.x = element_text(size=11,angle = 45, hjust = 0.9),
        axis.text.y = element_text(size=11),
        axis.title.y=element_text(size=14))+
  theme(plot.margin=unit(c(0.1,-0.1,-0.1,0.1),"cm"))+
  scale_x_discrete(labels = c("Benign-TCGA","Primary-TCGA\n(NoMycAmpOE)","Primary-TCGA\n(MycAmp)", "Primary-TCGA\n(MycOE)"))+
  stat_compare_means(comparisons = my_comparisons) # Add pairwise comparisons p-value
dev.off()

pdf("pathway_vs_psi.SRSF3.pdf",width=4, height=6)
layout.matrix <- matrix(c(1, 2, 0, 0), nrow = 2, ncol = 1)
layout(mat = layout.matrix,
       heights = c(3, 5), # Heights of the two rows
       widths = c(2, 2)) # Widths of the two columns
par(mar = c(0.1, 4, 0.5, 0.1))
#par(mfrow=c(2,1),mai = c(1,0.1, 0.1, 0.1))
boxplot(tck=-1,ylim=c(0.6,0.9),las=2,ylab='Myc Pathway Score',xaxt="n",yaxt="n",normal[,5],beign[,5],primary3[,5], primary1[,5], primary2[,5], primary[,5],CRPC1[,5],CRPC2[,5],CRPC3[,5],CRPC[,5],NE1[,5],NE2[,5],
      col=c("darkolivegreen3","pink","chocolate2","chocolate2","chocolate2","chocolate2","darkred","red","mediumorchid1","violetred3","darkgreen","darkslategray3"))
axis(2, at=c(0.6,0.7,0.8,0.9),las=2 )
par(mar = c(8, 4, 0.5, 0.1))
boxplot(yaxt="n",normal[,6],beign[,6],primary3[,6], primary1[,6], primary2[,6], primary[,6],CRPC1[,6],CRPC2[,6],CRPC3[,6],CRPC[,6],NE1[,6],NE2[,6],
        las=2,ylim=c(0,0.9),ylab='SRSF3 PSI value',
        names=c("Normal-GTEx","Benign-TCGA","Primary-nonMyc","Primary-MycCNV", "Primary-MycExp","Primary-TCGA","CRPC-Beltran","CRPC-Rob","CRPC-SU2C","CRPC","NE-Beltran","NE-SU2C"),
        col=c("darkolivegreen3","pink","chocolate2","chocolate2","chocolate2","chocolate2","darkred","red","mediumorchid1","violetred3","darkgreen","darkslategray3"))
axis(2, at=c(0,0.3,0.6,0.9), las=2 )
dev.off()


pdf("pathway_vs_psi.SRSF3.onlyTCGA.pdf",width=4, height=5) #for sup figure
par(mfrow=c(1,1),mai = c(1.8,0.9, 0.1, 0.1), cex.lab=1.2, cex.axis=0.9)
boxplot(ylim=c(0.65,0.85),las=2,ylab='Myc Pathway Score',
        beign[,5],primary3[,5], primary1[,5], primary2[,5], 
        col=c("pink","chocolate2","chocolate2","chocolate2"),
        names=c("Benign-TCGA","Primary-TCGA\n(NoMycHigh)","Primary-TCGA\n(MycAmpliy)", "Primary-TCGA\n(MycOverExp)"))
dev.off()

