

# A plotting R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800


# --------------------------------------------------------------------------
# If you don't have the ggplot2 package installed, uncomment the following line:
# install.packages( "ggplot2" );
library( ggplot2 );
# --------------------------------------------------------------------------
# If you don't have the scales package installed, uncomment the following line:
# install.packages( "scales" );
library( scales );


# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability","cluster");
revigo.data <- rbind(c("GO:0030295","protein kinase activator activity", 0.381,-4.223, 0.991, 1.826,-2.6008,0.868,0.000,3),
                     c("GO:0042623","ATPase activity, coupled", 1.837,-0.973,-6.704, 2.504,-1.8746,0.858,0.000,3),
                     c("GO:0045296","cadherin binding", 1.710,-4.125,-2.760, 2.473,-3.2194,0.923,0.000,-4),
                     c("GO:0036002","pre-mRNA binding", 0.168, 6.927,-1.104, 1.477,-2.6470,0.617,0.005,6),
                     c("GO:0050699","WW domain binding", 0.133,-4.712,-0.188, 1.380,-1.8005,0.949,0.031,-4),
                     c("GO:0005518","collagen binding", 0.376,-3.321, 4.267, 1.820,-1.3400,0.898,0.034,-4),
                     c("GO:0003779","actin binding", 2.375,-0.868, 7.122, 2.615,-1.8705,0.885,0.042,-4),
                     c("GO:0043531","ADP binding", 0.196,-2.411,-1.376, 1.544,-1.4561,0.835,0.110,-2),
                     c("GO:0003723","RNA binding", 9.262, 4.431,-2.775, 3.205,-2.6470,0.697,0.254,6),
                     c("GO:0001069","regulatory region RNA binding", 0.006, 4.128,-0.734, 0.301,-2.6470,0.680,0.267,6),
                     c("GO:0033204","ribonuclease P RNA binding", 0.006, 3.532,-0.230, 0.301,-2.6470,0.680,0.267,6),
                     c("GO:0030627","pre-mRNA 5'-splice site binding", 0.012, 4.483, 1.609, 0.477,-1.4561,0.669,0.279,6),
                     c("GO:0042835","BRE binding", 0.012, 4.165, 1.920, 0.477,-2.6470,0.669,0.279,6),
                     c("GO:0061752","telomeric repeat-containing RNA binding", 0.012, 4.007, 0.232, 0.477,-2.6470,0.669,0.279,6),
                     c("GO:0034584","piRNA binding", 0.017, 4.869,-1.746, 0.602,-2.6470,0.662,0.287,6),
                     c("GO:0070883","pre-miRNA binding", 0.023, 5.116, 2.243, 0.699,-2.6470,0.657,0.292,6),
                     c("GO:0071208","histone pre-mRNA DCP binding", 0.023, 4.819, 0.012, 0.699,-2.6470,0.657,0.292,6),
                     c("GO:0002151","G-quadruplex RNA binding", 0.040, 5.268, 1.083, 0.903,-2.6470,0.647,0.304,6),
                     c("GO:1990247","N6-methyladenosine-containing RNA binding", 0.040, 5.710,-2.093, 0.903,-2.6470,0.647,0.304,6),
                     c("GO:0008312","7S RNA binding", 0.046, 6.106, 1.819, 0.954,-2.6470,0.644,0.307,6),
                     c("GO:0035197","siRNA binding", 0.046, 5.876, 2.563, 0.954,-2.6470,0.644,0.307,6),
                     c("GO:0070878","primary miRNA binding", 0.046, 6.388, 2.708, 0.954,-2.6470,0.644,0.307,6),
                     c("GO:0035613","RNA stem-loop binding", 0.064, 5.629, 0.490, 1.079,-2.6470,0.638,0.314,6),
                     c("GO:0035198","miRNA binding", 0.087, 6.825, 2.040, 1.204,-2.6470,0.631,0.321,6),
                     c("GO:0000339","RNA cap binding", 0.098, 5.576,-0.770, 1.255,-2.6470,0.629,0.324,6),
                     c("GO:0070034","telomerase RNA binding", 0.098, 7.480, 1.502, 1.255,-2.6012,0.629,0.324,6),
                     c("GO:0017091","AU-rich element binding", 0.133, 6.117,-0.923, 1.380,-2.6470,0.622,0.332,6),
                     c("GO:0000498","base pairing with RNA", 0.167, 7.004, 1.417, 1.462,-2.6470,0.617,0.338,6),
                     c("GO:0034336","misfolded RNA binding", 0.167, 6.442,-1.877, 1.462,-2.6470,0.617,0.338,6),
                     c("GO:0034583","21U-RNA binding", 0.167, 7.081,-1.562, 1.462,-2.6470,0.617,0.338,6),
                     c("GO:1904678","alpha-aminoacyl-tRNA binding", 0.167, 7.327,-0.232, 1.462,-2.6470,0.617,0.338,6),
                     c("GO:1990605","GU repeat RNA binding", 0.167, 6.295,-1.456, 1.462,-2.6470,0.617,0.338,6),
                     c("GO:0003725","double-stranded RNA binding", 0.364, 6.161,-0.155, 1.806,-2.6470,0.599,0.360,6),
                     c("GO:0030515","snoRNA binding", 0.173, 7.617, 0.231, 1.491,-2.6242,0.616,0.361,6),
                     c("GO:0017069","snRNA binding", 0.208, 7.429, 0.695, 1.568,-2.6470,0.612,0.366,6),
                     c("GO:0000049","tRNA binding", 0.283, 7.479,-0.407, 1.699,-2.5197,0.628,0.376,6),
                     c("GO:0019843","rRNA binding", 0.318, 6.259, 0.966, 1.748,-2.6470,0.602,0.380,6),
                     c("GO:0060001","minus-end directed microfilament motor activity", 0.006,-0.449,-7.089, 0.301,-1.4561,0.881,0.422,-4),
                     c("GO:0070052","collagen V binding", 0.017,-3.524, 3.931, 0.602,-1.3400,0.897,0.423,-4),
                     c("GO:0003729","mRNA binding", 1.075, 6.366, 0.481, 2.272,-2.6470,0.570,0.425,6),
                     c("GO:0003727","single-stranded RNA binding", 0.445, 6.570, 0.119, 1.892,-2.5197,0.594,0.434,6),
                     c("GO:0008135","translation factor activity, RNA binding", 0.520, 6.939,-0.658, 1.959,-2.6470,0.590,0.441,6),
                     c("GO:0042624","ATPase activity, uncoupled", 0.006,-1.256,-6.440, 0.301,-1.4561,0.887,0.524,3),
                     c("GO:0030507","spectrin binding", 0.150,-0.924, 6.992, 1.431,-1.8005,0.897,0.559,-4),
                     c("GO:0003785","actin monomer binding", 0.156,-0.568, 7.242, 1.447,-1.4912,0.892,0.561,-4),
                     c("GO:0098641","cadherin binding involved in cell-cell adhesion", 0.104,-4.269,-2.418, 1.279,-3.2194,0.898,0.652,-4),
                     c("GO:0008574","ATP-dependent microtubule motor activity, plus-end-directed", 0.092,-0.713,-6.833, 1.230,-1.7781,0.852,0.656,3),
                     c("GO:0051015","actin filament binding", 0.832,-1.917, 5.999, 2.161,-1.5848,0.835,0.671,-4));
one.data <- data.frame(revigo.data);
names(one.data) <- revigo.names;
one.data <- one.data [(one.data$plot_X != "null" & one.data$plot_Y != "null"), ];
one.data$plot_X <- as.numeric( as.character(one.data$plot_X) );
one.data$plot_Y <- as.numeric( as.character(one.data$plot_Y) );
one.data$plot_size <- as.numeric( as.character(one.data$plot_size) );
one.data$log10_p_value <- as.numeric( as.character(one.data$log10_p_value) );
one.data$log10_p_value <- -one.data$log10_p_value
one.data$frequency <- as.numeric( as.character(one.data$frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$dispensability) );
one.data$cluster <- as.numeric( as.character(one.data$cluster) );
#head(one.data);


#k-means clustering of data
#num.of.cluster=3
#cluster=as.character(kmeans(one.data[,c("plot_X","plot_Y")],num.of.cluster)$cluster)
#cluster=as.character(kmeans(one.data[,"plot_X"],num.of.cluster)$cluster)
#one.data$cluster <- cluster;

# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, log10_p_value, colour = cluster, size = frequency), alpha = I(0.6) ) + scale_size_area();
p1 <- p1 + scale_colour_gradientn( colours = c("steelblue1", "yellow"), limits = c( -4, 8) );
#p1 <- p1 + scale_color_manual(values = brewer.pal(num.of.cluster, "YlGnBu")); 
p1 <- p1 + geom_point( aes(plot_X, log10_p_value, size = frequency), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.1) )) + scale_size_area();
p1 <- p1 + scale_size( range=c(3, 12)); #scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
ex <- one.data [ one.data$dispensability < 0.1, ]; 
ex$log10_p_value<-ex$log10_p_value-0.3
p1 <- p1+ geom_hline(yintercept=-log10(0.05), linetype='dashed', colour='grey50')
p1 <- p1 + geom_text( data = ex, aes(plot_X, log10_p_value, label = description), colour = I(alpha("black", 0.85)), size =  5);
p1 <- p1 + labs (y = "-Log10(adjusted p)", x = "Semantic space",size="Term\nfrequency (%)", 
                 col="Term semantic distance" );
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$log10_p_value) - min(one.data$log10_p_value);
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(0,max(one.data$log10_p_value)+one.y_range/3);
p1<-p1 + theme_classic() +guides(col=FALSE)+#theme(legend.position="bottom") 
  theme(axis.ticks.x=element_blank(),axis.text.x=element_blank(),axis.text.y=element_text(color = "black", size = 12),axis.title = element_text(size = 15),legend.title=element_text(size=15, color='black'),legend.text=element_text(size=12, color='black'))
# --------------------------------------------------------------------------
# Output the plot to screen

#p1;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

ggsave("revigo-plot_1_test.pdf",width=5, height=4, units='in')
