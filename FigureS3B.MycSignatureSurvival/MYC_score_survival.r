library(survival)
library(survminer)
data <- read.table("HALLMARK_MYC_TARGETS_V2.scores.txt",header = F,stringsAsFactors = F)
surviv_file <-'PRAD_DFS.txt'
surviv <- as.data.frame(read.table(surviv_file, stringsAsFactors = FALSE, header = T))
patient <- read.table("PATIENT_DATA_oncoprint.tsv",header = F,stringsAsFactors = F,sep = '\t')
t.patient <- t(patient)
data[,1] <- gsub("-01A", "", data[,1])
data[,1] <- gsub("-01B", "", data[,1])
surviv[,1]<-gsub("-01","",surviv[,1])

primary <- data[which(data[,2]== "Primary-TCGA"),]
index.surv <- match(primary[,1],surviv[,1])
index <- match(primary[,1],t.patient[,1])
primary$V7<-surviv[index.surv,2]
primary$V8<-surviv[index.surv,3]

primary$V9 <- t.patient[index,2]
primary$V10 <- t.patient[index,4]

signature_score<-primary[,3]
surviv_kmeans <- kmeans(signature_score,  3)
primary$V11 <- surviv_kmeans$cluster

hist(signature_score)
cutoff<-quantile(signature_score,0.75)
cutoff
cutoff.low<-quantile(signature_score,0.75)
cutoff.low
primary$cluster[primary[,3]>cutoff]<-'High Myc (upper quartile)'
primary$cluster[primary[,3]<cutoff.low]<-'Low Myc (lower half)'
fit <- survfit(Surv(primary$V7, primary$V8) ~ primary$V10, data = primary, type=c('kaplan-meier'))
p<-ggsurvplot(fit, data = primary, font.tickslab = c(11), font.x = c(14),font.y = c(14) ,ylab='Survival Probability', xlab='Time (Months)',pval = T,conf.int = F,
              #legend.labs = c("High Myc (top 25%)", "Low Myc (the rest)"),
              legend.labs = c("The Rest (475)","Myc OverExp (24)"),
              #legend.labs = c( "The Rest (456)","Myc Amplification (41)", "Myc Deletion (2)"),
              legend = c(0.68, 0.9),pval.method = TRUE,font.legend = c(12),font.caption = c(12),
              palette = c("#070707","#FF0000") 
              #palette = c("#070707","#FF0000", "#7CFC00") 
             )
p

pdf(paste0('myc_score_surviv.DFS.overexp.pdf'),width=4,height=4) 
print(p,newpage=FALSE)
dev.off()






