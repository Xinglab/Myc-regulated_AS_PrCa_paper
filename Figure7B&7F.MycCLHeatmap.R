library(superheat)
library(RColorBrewer)
d<-read.table('overlap.MYCcor.vs.CL0.05.txt.PTCanno.txt', header=T,stringsAsFactors=F)#replace tsv between fig7B and 7F
a=do.call(rbind, strsplit(d$IncLevel1, ","))
b=do.call(rbind, strsplit(d$IncLevel2, ","))
c=data.frame(cbind(a,b))
c=data.frame(cbind(a[,1],b[,1],a[,2],b[,2],a[,3],b[,3]),stringsAsFactors = F)
d.matrix=data.matrix(c)
colnames(d.matrix)<-c('Myc +\nrep1','Myc -\nrep1','Myc +\nrep2','Myc -\nrep2','Myc +\nrep3','Myc -\nrep3')
d.matrix.z<-t(scale(t(d.matrix),center=T,scale=F))
png(filename ='heatmap.147annoPTC.rotate.png',width = 500, height = 1800)
superheat(d.matrix.z,
          # normalize variables
          scale = F,
          heat.pal = rev(brewer.pal(9, "RdBu")),
          heat.na.col = 'grey',
          # order rows/cols based on heirarchical clustering
          pretty.order.rows = F,
          row.dendrogram = F,
          pretty.order.cols = F,
          # increase size of left labels
          left.label.size = 0.5,
          bottom.label.text.size = 4,
          legend = TRUE,
          legend.height = 0.08, legend.width = 1.5, legend.text.size = 10, 
          #legend.breaks = seq(-1,1,by = 0.2),
          grid.hline = F,
          grid.vline = F,
          title = NULL)

dev.off()

