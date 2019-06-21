## rainfall plot for pathway RNA AS correlation analysis
## Yang Pan
## 3.2.2018
## Xiao revised on 3.26.2018


### BELOW is a new layout
library(ggplot2)
library(reshape2)
library(grid)
library(gridExtra)
library(RColorBrewer)

### for re-generating figure  
t = read.table('hallmark_plot_summary_sorted.txt',sep='\t')
exons=t$V3
GOs=t$V4
t.d=data.frame(t)

## the annotation table in the middle
library(stringr)
t.d$V7 = str_wrap(t.d$V5, width = 50)
g.mid<-ggplot(t.d,aes(x=1,y=t$V1))+geom_text(aes(label=t.d$V7, lineheight = 0.7),size=2.5,hjust = 0)+
  ggtitle("Top GO Terms")+
  ylab(NULL)+
  scale_x_continuous(expand=c(0,0),limits=c(0.94,1.065))+
  scale_y_discrete(limits=rev(t.d$V1)) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title=element_blank(),
        panel.grid=element_blank(),
        panel.background=element_blank(),
        plot.title = element_text(size = 11,hjust=0.59,vjust=0),
        plot.margin = unit(c(14.2,-30,6.5,-95), "mm")
        )

## left barplot
v.d<-as.data.frame(cbind(rev(seq.int(t.d$V4)),-log10(t.d$V4+10^-15),rep('GOterms',length(t.d$V4))))
g1 <-ggplot(v.d,aes(x=v.d$V3,y=as.numeric(as.character(v.d$V1)),size=as.numeric(as.character(v.d$V2))))+
  scale_size(range = c(0, 3))+ ggtitle("-Log10Padj")+
  geom_point(colour='gray23')+
  xlab("")+
  scale_y_continuous(expand=c(0,0.7))+
  theme(axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        axis.text.y = element_blank(), 
        axis.text.x = element_blank(), 
        axis.ticks.y = element_blank(), 
        axis.ticks.x = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),axis.line = element_blank(),
        plot.title = element_text(size = 9,vjust=0.5, hjust=0.5,angle = 90),
        plot.margin = unit(c(1,7,5.8,-10), "mm"),
        legend.title=element_blank()) +
 theme(legend.position='none')

## right barplot
g2 <- ggplot(data = t.d, aes(x = t.d$V1, y = t.d$V3+10^-15)) +xlab(NULL)+
  geom_bar(stat = "identity", colour='black',fill='white', width=0.5) + ggtitle("# Events") +
  scale_fill_brewer(palette="RdGy") +
  scale_x_discrete(limits=rev(t.d$V1)) +
  #Darts_theme +
  theme(axis.title.x = element_blank(),
        axis.text.x=element_text(color='black',angle = 30, hjust = 0.5,size=8),
        axis.title.y = element_blank(), 
        axis.text.y = element_blank(), axis.ticks.y = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(),axis.line = element_line(colour = "black",size=0.2),
        plot.title = element_text(size = 11,vjust=1,angle=0),
        plot.margin = unit(c(14.5,7,-0.5,0), "mm"),
        legend.title=element_blank()) +
  coord_flip(ylim=c(0.3,1500)) +
  theme(legend.position='none')


mat = read.table('merged.shared.50_HallmarksExonCorMatrix.txt',sep='\t', header=T,check.names = F)
mar.r=cbind(AS_events=mat[,1],mat[,ncol(mat):2])
#mat.m <- melt(mar.r)
my_palette =colorRampPalette(brewer.pal(n = 11, name="RdYlBu"))(n=29) # n must be less than 100+100+100
new_palette=c(rep(my_palette[1],5),my_palette,rep(my_palette[29],5))
library('cluster')
see<-daisy(mat,metric = "gower")
hc <- hclust(see)
ord<-hc$order


#ord<-order(mar.r$E2F_TARGETS)
mat.2<-mar.r[ord,]
mat.m <- melt(mat.2)
mat.m$AS_events <- factor(mat.m$AS_events, levels = as.character(mat.2[[1]])) # Xiao: convert to factor to keep the order
p <- ggplot(mat.m, aes(variable, rev(AS_events), fill=value)) + geom_tile() + ggtitle("Pathway-AS Correlations(n=2325)")+
  scale_fill_gradientn('Pearson\'s r',colours = rev(new_palette),na.value = 'lightgrey',limits=c(-0.6,0.6),breaks=c(-0.6,0,0.6),
                       labels=c(-0.6,0,0.6),
                       guide = guide_colorbar(frame.colour = "black", ticks.colour = "black", title.position='top',title.hjust =1,
                                              frame.linewidth=1,
                                              nbin = 10,
                                              barwidth = 1.5,
                                              barheight = 0.5, 
                                              direction = 'horizontal'))+
  scale_x_discrete(expand=c(0,0))+
  scale_y_discrete(expand = c(0, 0))+
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(), 
        axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        #axis.text.y = element_blank(),
       axis.text.y = element_text(size = 8.5,color = 'black'), axis.ticks.y = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_blank(),
        plot.title = element_text(size = 12,hjust=0,vjust=0.6),
        plot.margin = unit(c(1.6,0,6.5,0), "mm"),
        legend.text =element_text(size = 6.5,color = 'black'),
        legend.title= element_text(size=7.5,color = 'black',hjust=1),
        legend.position = "top",legend.justification="right",
        legend.margin=margin(0,0,0,0),
        legend.box.margin=margin(4.7,10,-10,-10))+
        coord_flip()
p

## combind and make the figure

gg1 <- ggplot_gtable(ggplot_build(g1))
gg2 <- ggplot_gtable(ggplot_build(g2))
gg.mid <- ggplot_gtable(ggplot_build(g.mid))
p <- ggplot_gtable(ggplot_build(p))
pdf(file='hallmarks50.pdf',width = 8, height = 8)
grid.arrange(p,gg2,gg1,gg.mid,ncol=4,widths=c(5/10,1/10,0.5/10,2/10))

dev.off()



