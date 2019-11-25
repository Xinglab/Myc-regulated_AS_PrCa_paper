library(ggpubr)
score<-read.table('HALLMARK_MYC_TARGETS_V2.scores.BrCa.txt',header=F,stringsAsFactors=F)

normal <-score[which(score[,2]== "Normal-GTEx"),]
benign <-score[which(score[,2]== "Benign-TCGA"),]
tumor <- score[which(score[,2]== "Tumor-TCGA"),]
MYC_score.df <- data.frame(rbind(normal,benign,tumor),stringsAsFactors=FALSE)

pdf(file="PathwayScoreBoxplot.BrCa.pdf",width = 4, height =4)
par(mar=c(2, 2, 2, 2), xpd=TRUE)

#pdf("pathway_vs_psi.onlyTCGA.test.pdf",width=4, height=4)
ggboxplot(MYC_score.df,"V2","V3",fill="V2",palette =c("darkolivegreen3","pink","chocolate2"),
          ylab=c("Myc Pathway Score"),xlab=FALSE,
          bxp.errorbar=T,
          width = 0.7)+ 
  theme(legend.position = "none",legend.title = element_blank(),
        axis.text.x = element_text(size=12,angle = 15, hjust = 0.8),
        axis.text.y = element_text(size=11),
        axis.title.y=element_text(size=14))+
  theme(plot.margin=unit(c(0.5,0.1,0.1,0.1),"cm"))+
  scale_x_discrete(labels = c("Normal-GTEx","Benign-TCGA","Tumor-TCGA"))
  #stat_compare_means(comparisons = my_comparisons) # Add pairwise comparisons p-value
dev.off()

