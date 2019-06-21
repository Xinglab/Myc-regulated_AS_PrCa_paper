

# A plotting R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800


# --------------------------------------------------------------------------
# If you don't have the ggplot2 package installed, uncomment the following line:
# install.packages( "ggplot2" );
library( ggplot2 );
library( RColorBrewer );
library( ggridges )
# --------------------------------------------------------------------------
# If you don't have the scales package installed, uncomment the following line:
# install.packages( "scales" );
library( scales );


# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.



revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0008312","7S RNA binding", 0.046, 2.904, 1.519, 0.954,-15,0.476,0.000),
                     c("GO:0098505","G-rich strand telomeric DNA binding", 0.046,-4.627, 0.148, 0.954,-1.8237,0.677,0.145),
                     c("GO:0003723","RNA binding", 9.262,-1.998,-0.254, 3.205,-15,0.553,0.221),
                     c("GO:0001069","regulatory region RNA binding", 0.006, 2.812,-3.685, 0.301,-15,0.525,0.248),
                     c("GO:0033204","ribonuclease P RNA binding", 0.006, 4.487,-2.304, 0.301,-15,0.525,0.248),
                     c("GO:0030627","pre-mRNA 5'-splice site binding", 0.012, 1.436, 2.578, 0.477,-2.6265,0.458,0.258),
                     c("GO:0042835","BRE binding", 0.012, 4.556, 0.773, 0.477,-15,0.509,0.258),
                     c("GO:0061752","telomeric repeat-containing RNA binding", 0.012, 4.658,-1.102, 0.477,-15,0.509,0.258),
                     c("GO:0034584","piRNA binding", 0.017, 3.454,-2.629, 0.602,-15,0.500,0.264),
                     c("GO:0070883","pre-miRNA binding", 0.023, 4.285,-0.250, 0.699,-15,0.493,0.269),
                     c("GO:0071208","histone pre-mRNA DCP binding", 0.023, 1.696,-3.232, 0.699,-15,0.493,0.269),
                     c("GO:0033592","RNA strand annealing activity", 0.029, 0.297,-2.867, 0.778,-1.6943,0.473,0.273),
                     c("GO:0002151","G-quadruplex RNA binding", 0.040, 3.521, 0.391, 0.903,-15,0.479,0.279),
                     c("GO:1990247","N6-methyladenosine-containing RNA binding", 0.040, 3.491, 1.186, 0.903,-15,0.479,0.279),
                     c("GO:0003727","single-stranded RNA binding", 0.445, 0.799,-0.458, 1.892,-15,0.409,0.330),
                     c("GO:0035197","siRNA binding", 0.046, 2.100, 1.674, 0.954,-15,0.476,0.330),
                     c("GO:0070878","primary miRNA binding", 0.046, 2.698,-2.230, 0.954,-15,0.476,0.330),
                     c("GO:0035613","RNA stem-loop binding", 0.064, 3.419,-1.024, 1.079,-15,0.467,0.338),
                     c("GO:0035198","miRNA binding", 0.087, 2.829,-0.895, 1.204,-15,0.459,0.346),
                     c("GO:0000339","RNA cap binding", 0.098, 1.901,-1.969, 1.255,-15,0.455,0.350),
                     c("GO:0070034","telomerase RNA binding", 0.098, 0.732, 1.489, 1.255,-15,0.455,0.350),
                     c("GO:0017091","AU-rich element binding", 0.133, 1.156,-2.000, 1.380,-15,0.447,0.359),
                     c("GO:0000498","base pairing with RNA", 0.167,-0.153,-0.548, 1.462,-15,0.440,0.366),
                     c("GO:0034336","misfolded RNA binding", 0.167, 0.268,-1.770, 1.462,-15,0.440,0.366),
                     c("GO:0034583","21U-RNA binding", 0.167, 2.165, 0.606, 1.462,-15,0.440,0.366),
                     c("GO:1904678","alpha-aminoacyl-tRNA binding", 0.167,-0.160,-1.203, 1.462,-15,0.440,0.366),
                     c("GO:1990605","GU repeat RNA binding", 0.167, 0.564,-1.308, 1.462,-15,0.440,0.366),
                     c("GO:0036002","pre-mRNA binding", 0.168, 0.031, 0.687, 1.477,-15,0.440,0.366),
                     c("GO:0030515","snoRNA binding", 0.173,-0.064, 0.086, 1.491,-15,0.439,0.367),
                     c("GO:0017069","snRNA binding", 0.208, 0.562, 0.837, 1.568,-15,0.433,0.373),
                     c("GO:0000049","tRNA binding", 0.283, 1.259, 0.623, 1.699,-15,0.447,0.383),
                     c("GO:0019843","rRNA binding", 0.318, 1.965,-0.853, 1.748,-15,0.420,0.387),
                     c("GO:0003725","double-stranded RNA binding", 0.364, 1.991,-0.109, 1.806,-15,0.416,0.391),
                     c("GO:0003729","mRNA binding", 1.075, 1.406,-0.739, 2.272,-15,0.379,0.434),
                     c("GO:0008135","translation factor activity, RNA binding", 0.520, 1.216,-0.059, 1.959,-15,0.404,0.441),
                     c("GO:0034057","RNA strand-exchange activity", 0.012, 0.422,-3.332, 0.477,-1.3459,0.495,0.650),
                     c("GO:0045131","pre-mRNA branch point binding", 0.006, 2.023, 2.819, 0.301,-1.8237,0.473,0.678));
one.data <- data.frame(revigo.data);
names(one.data) <- revigo.names;
one.data <- one.data [(one.data$plot_X != "null" & one.data$plot_Y != "null"), ];
one.data$plot_X <- -as.numeric( as.character(one.data$plot_X) );
one.data$plot_Y <- as.numeric( as.character(one.data$plot_Y) );
one.data$plot_size <- as.numeric( as.character(one.data$plot_size) );
one.data$log10_p_value <- as.numeric( as.character(one.data$log10_p_value) );
one.data$log10_p_value <- -one.data$log10_p_value
one.data$frequency <- as.numeric( as.character(one.data$frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$dispensability) );
#one.data$cluster <- as.numeric( as.character(one.data$cluster) );
#head(one.data);

#k-means clustering of data
num.of.cluster=1
cluster=as.character(kmeans(one.data[,c("plot_X","plot_Y")],num.of.cluster)$cluster)
#cluster=as.character(kmeans(one.data[,"plot_X"],num.of.cluster)$cluster)
one.data$cluster <- cluster;

# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, log10_p_value, colour = cluster, size = frequency), alpha = I(0.6) ) + scale_size_area();
#p1 <- p1 + scale_colour_gradientn( colours = c("skyblue", "yellow"), limits = c( -4, 8) );
p1 <- p1 + scale_color_manual(values = c("yellow2"));      #color the dots by cluster
p1 <- p1 + geom_point( aes(plot_X, log10_p_value, size = frequency), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.1) )) + scale_size_area();
p1 <- p1 + scale_size( range=c(3, 15)); #scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
ex <- one.data [ one.data$frequency > 1, ]; 
ex <- ex [ ex$dispensability < 0.4, ]; 
ex$log10_p_value<-ex$log10_p_value-0.3
p1 <- p1 + geom_text( data = ex, aes(plot_X, log10_p_value, label = description), colour = I(alpha("black", 0.85)), size =  5);
p1 <- p1 + labs (y = "-Log10(adjusted p)", x = "Semantic space",size="Term\nfrequency (%)", 
                 col="Term semantic distance" );
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$log10_p_value) - min(one.data$log10_p_value);
p1 <- p1 + geom_hline(yintercept=-log10(0.05), linetype="dashed", color = "grey50");
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(0,max(one.data$log10_p_value)+one.y_range/3);
p1<-p1 + theme_classic() +guides(col=FALSE)+#theme(legend.position="bottom") 
  theme(axis.ticks.x=element_blank(),axis.text.x=element_blank(),axis.text.y=element_text(color = "black", size = 12),axis.title = element_text(size = 15),legend.title=element_text(size=15, color='black'),legend.text=element_text(size=12, color='black'))
# --------------------------------------------------------------------------
# Output the plot to screen

#p1;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

ggsave("revigo-plot_BRCA_shared.pdf",width=5, height=4, units='in')
