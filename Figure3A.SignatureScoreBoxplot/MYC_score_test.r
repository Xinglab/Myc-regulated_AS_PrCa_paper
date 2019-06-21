data <- read.table("HALLMARK_MYC_TARGETS_V2.scores.txt",header = F,stringsAsFactors = F)
patient <- read.table("PATIENT_DATA_oncoprint.tsv",header = F,stringsAsFactors = F,sep = '\t')
t.patient <- t(patient)
data[,1] <- gsub("-01A", "", data[,1])
data[,1] <- gsub("-01B", "", data[,1])

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

primary$V6 <- t.patient[index,2]
primary$V7 <- t.patient[index,4]
primary1 <- primary[which(primary$V6=="Amplification"),]
primary2 <- primary[which(primary$V7=="mRNA Upregulation"),]
primary3 <- primary[which(primary$V6!="Amplification" & primary$V7!="mRNA Upregulation"),]

b <- cbind(beign[,5],rep("Benign",nrow(beign))); p1 <- cbind(primary1[,5],rep("Primary1",nrow(primary1)))
p2 <- cbind(primary2[,5],rep("Primary2",nrow(primary2))); p3 <- cbind(primary3[,5],rep("Primary3",nrow(primary3)))
MYC_score.df <- data.frame(rbind(b,p3,p1,p2),stringsAsFactors=FALSE)
MYC_score.df$X1 <- as.numeric(MYC_score.df$X1)
library(ggpubr)
compare_means(X1 ~ X2,  data = MYC_score.df, method='wilcox.test')
my_comparisons <- list( c("Benign", "Primary3"), c("Primary3", "Primary1"), c("Primary3", "Primary2") )
pdf("pathway_vs_psi.onlyTCGA.test.pdf",width=4, height=4)
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
