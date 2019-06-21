

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
revigo.data <- rbind(c("GO:0003777","microtubule motor activity", 0.456,-0.425,-4.150, 1.903,-2.2430,0.977,0.000,-4),
                     c("GO:0004867","serine-type endopeptidase inhibitor activity", 0.560,-0.286,-3.422, 1.991,-1.5297,0.977,0.000,-4),
                     c("GO:0051015","actin filament binding", 0.832,-0.069,-5.421, 2.161,-4.4572,0.867,0.000,-4),
                     c("GO:0003727","single-stranded RNA binding", 0.445,-5.108, 4.260, 1.892,-2.2430,0.738,0.006,6),
                     c("GO:0017124","SH3 domain binding", 0.699,-0.543,-3.475, 2.086,-1.5297,0.943,0.034,-4),
                     c("GO:0045296","cadherin binding", 1.710,-0.269,-4.740, 2.473,-2.7411,0.898,0.037,-4),
                     c("GO:0001664","G-protein coupled receptor binding", 1.479, 4.178, 2.575, 2.410,-1.5297,0.638,0.040,0),
                     c("GO:0001069","regulatory region RNA binding", 0.006,-3.985, 2.930, 0.301,-2.2430,0.796,0.285,6),
                     c("GO:0033204","ribonuclease P RNA binding", 0.006,-3.685, 2.710, 0.301,-2.2430,0.796,0.285,6),
                     c("GO:0003723","RNA binding", 9.262,-4.565, 1.393, 3.205,-2.2430,0.804,0.286,6),
                     c("GO:0042835","BRE binding", 0.012,-3.401, 3.526, 0.477,-2.2430,0.789,0.298,6),
                     c("GO:0061752","telomeric repeat-containing RNA binding", 0.012,-3.887, 3.100, 0.477,-2.2430,0.789,0.298,6),
                     c("GO:0034584","piRNA binding", 0.017,-3.812, 3.382, 0.602,-2.2430,0.784,0.307,6),
                     c("GO:0070883","pre-miRNA binding", 0.023,-3.736, 4.057, 0.699,-2.2430,0.781,0.313,6),
                     c("GO:0071208","histone pre-mRNA DCP binding", 0.023,-4.348, 3.330, 0.699,-2.2430,0.781,0.313,6),
                     c("GO:0031811","G-protein coupled nucleotide receptor binding", 0.006, 4.781, 3.161, 0.301,-1.5297,0.569,0.318,6),
                     c("GO:0002151","G-quadruplex RNA binding", 0.040,-4.240, 3.727, 0.903,-2.2430,0.774,0.326,6),
                     c("GO:1990247","N6-methyladenosine-containing RNA binding", 0.040,-3.997, 3.713, 0.903,-2.2430,0.774,0.326,6),
                     c("GO:0008312","7S RNA binding", 0.046,-4.186, 4.263, 0.954,-2.2430,0.772,0.330,6),
                     c("GO:0035197","siRNA binding", 0.046,-4.540, 3.473, 0.954,-2.2430,0.772,0.330,6),
                     c("GO:0070878","primary miRNA binding", 0.046,-4.634, 4.289, 0.954,-2.2430,0.772,0.330,6),
                     c("GO:0035613","RNA stem-loop binding", 0.064,-4.524, 3.752, 1.079,-2.2430,0.768,0.338,6),
                     c("GO:0035198","miRNA binding", 0.087,-4.543, 4.365, 1.204,-2.2430,0.764,0.346,6),
                     c("GO:0000339","RNA cap binding", 0.098,-4.660, 3.820, 1.255,-2.2430,0.762,0.350,6),
                     c("GO:0070034","telomerase RNA binding", 0.098,-5.333, 5.141, 1.255,-2.2137,0.762,0.350,6),
                     c("GO:0017091","AU-rich element binding", 0.133,-4.751, 4.036, 1.380,-2.2430,0.758,0.359,6),
                     c("GO:0000498","base pairing with RNA", 0.167,-5.480, 3.972, 1.462,-2.2430,0.754,0.366,6),
                     c("GO:0034336","misfolded RNA binding", 0.167,-5.287, 3.988, 1.462,-2.2430,0.754,0.366,6),
                     c("GO:0034583","21U-RNA binding", 0.167,-5.134, 5.040, 1.462,-2.2430,0.754,0.366,6),
                     c("GO:1904678","alpha-aminoacyl-tRNA binding", 0.167,-5.417, 3.787, 1.462,-2.2430,0.754,0.366,6),
                     c("GO:1990605","GU repeat RNA binding", 0.167,-4.908, 4.295, 1.462,-2.2430,0.754,0.366,6),
                     c("GO:0036002","pre-mRNA binding", 0.168,-5.059, 4.603, 1.477,-2.2430,0.754,0.366,6),
                     c("GO:0030515","snoRNA binding", 0.173,-5.446, 4.741, 1.491,-2.2228,0.754,0.367,6),
                     c("GO:0017069","snRNA binding", 0.208,-5.595, 5.129, 1.568,-2.2430,0.751,0.373,6),
                     c("GO:0000049","tRNA binding", 0.283,-5.494, 4.889, 1.699,-2.2430,0.763,0.383,6),
                     c("GO:0019843","rRNA binding", 0.318,-4.949, 3.906, 1.748,-2.2430,0.744,0.387,6),
                     c("GO:0003725","double-stranded RNA binding", 0.364,-5.030, 4.099, 1.806,-2.2430,0.742,0.391,6),
                     c("GO:0031492","nucleosomal DNA binding", 0.168,-4.037,-0.710, 1.477,-1.5742,0.819,0.425,6),
                     c("GO:0003729","mRNA binding", 1.075,-5.133, 4.407, 2.272,-2.2430,0.722,0.434,6),
                     c("GO:0008135","translation factor activity, RNA binding", 0.520,-5.469, 4.962, 1.959,-2.2137,0.735,0.441,6),
                     c("GO:0031700","adrenomedullin receptor binding", 0.006, 4.826, 3.298, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031714","C5a anaphylatoxin chemotactic receptor binding", 0.006, 4.905, 2.972, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031768","ghrelin receptor binding", 0.006, 4.874, 2.518, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031775","lutropin-choriogonadotropic hormone receptor binding", 0.006, 4.655, 2.639, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031821","G-protein coupled serotonin receptor binding", 0.040, 5.146, 3.683, 0.903,-1.5297,0.527,0.473,0),
                     c("GO:0031855","oxytocin receptor binding", 0.006, 4.428, 3.712, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031856","parathyroid hormone receptor binding", 0.006, 4.867, 2.799, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031859","platelet activating factor receptor binding", 0.006, 4.582, 3.518, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031883","taste receptor binding", 0.006, 4.559, 3.059, 0.301,-1.5297,0.569,0.473,0),
                     c("GO:0031711","bradykinin receptor binding", 0.012, 4.821, 3.688, 0.477,-1.3140,0.555,0.492,0),
                     c("GO:0031716","calcitonin receptor binding", 0.012, 4.957, 3.494, 0.477,-1.5297,0.555,0.492,0),
                     c("GO:0031753","endothelial differentiation G-protein coupled receptor binding", 0.012, 5.146, 3.200, 0.477,-1.5297,0.555,0.492,0),
                     c("GO:0031762","follicle-stimulating hormone receptor binding", 0.012, 5.274, 2.946, 0.477,-1.5297,0.555,0.492,0),
                     c("GO:0031862","prostanoid receptor binding", 0.012, 5.591, 3.162, 0.477,-1.5297,0.555,0.492,0),
                     c("GO:0031531","thyrotropin-releasing hormone receptor binding", 0.017, 5.570, 3.631, 0.602,-1.3140,0.546,0.504,0),
                     c("GO:0031685","adenosine receptor binding", 0.017, 5.188, 3.509, 0.602,-1.3140,0.546,0.504,0),
                     c("GO:0031871","proteinase activated receptor binding", 0.017, 5.523, 3.532, 0.602,-1.3140,0.546,0.504,0),
                     c("GO:0031893","vasopressin receptor binding", 0.017, 5.676, 3.630, 0.602,-1.5297,0.546,0.504,0),
                     c("GO:0035256","G-protein coupled glutamate receptor binding", 0.023, 5.069, 3.518, 0.699,-1.5297,0.540,0.513,0),
                     c("GO:0031849","olfactory receptor binding", 0.035, 5.241, 3.777, 0.845,-1.5297,0.531,0.526,0),
                     c("GO:0031628","opioid receptor binding", 0.052, 5.879, 4.235, 1.000,-1.5297,0.521,0.540,0),
                     c("GO:0031717","cannabinoid receptor binding", 0.047, 5.339, 4.126, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031745","cysteinyl leukotriene receptor binding", 0.047, 5.847, 4.127, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031761","fMet-Leu-Phe receptor binding", 0.047, 5.557, 4.119, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031767","gastric inhibitory polypeptide receptor binding", 0.047, 6.112, 3.408, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031769","glucagon receptor binding", 0.047, 5.829, 4.537, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031774","leukotriene receptor binding", 0.047, 5.914, 4.574, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031784","melatonin receptor binding", 0.047, 6.043, 3.938, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031788","motilin receptor binding", 0.047, 5.813, 4.254, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031789","G-protein coupled acetylcholine receptor binding", 0.047, 5.867, 4.324, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031795","G-protein coupled GABA receptor binding", 0.047, 6.044, 3.402, 0.954,-1.3140,0.523,0.545,0),
                     c("GO:0031806","G-protein coupled histamine receptor binding", 0.047, 5.350, 3.800, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031876","secretin receptor binding", 0.047, 5.715, 4.152, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0031889","urotensin receptor binding", 0.047, 5.380, 4.210, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0061761","alpha-latrotoxin receptor binding", 0.047, 6.007, 4.565, 0.954,-1.5297,0.523,0.545,0),
                     c("GO:0050780","dopamine receptor binding", 0.092, 5.962, 4.371, 1.230,-1.5297,0.507,0.571,0),
                     c("GO:0031701","angiotensin receptor binding", 0.064, 5.406, 4.024, 1.079,-1.3140,0.516,0.579,0),
                     c("GO:0003785","actin monomer binding", 0.156, 0.383,-5.498, 1.447,-2.7521,0.907,0.649,-4),
                     c("GO:0098641","cadherin binding involved in cell-cell adhesion", 0.104, 0.170,-4.382, 1.279,-2.4844,0.904,0.652,-4),
                     c("GO:0042379","chemokine receptor binding", 0.341, 5.533, 4.127, 1.778,-1.5297,0.471,0.655,0),
                     c("GO:0031690","adrenergic receptor binding", 0.104, 5.228, 3.792, 1.279,-1.5297,0.504,0.662,0),
                     c("GO:0003779","actin binding", 2.375, 0.285,-5.527, 2.615,-3.2158,0.899,0.671,-4),
                     c("GO:0071855","neuropeptide receptor binding", 0.168, 6.008, 4.498, 1.477,-1.5297,0.491,0.688,0));

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
one.data$cluster <- as.numeric( as.character(one.data$cluster) );
#head(one.data);


# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, log10_p_value, colour = cluster, size = frequency), alpha = I(0.6) ) + scale_size_area();
p1 <- p1 + scale_colour_gradientn( colours = c("steelblue1", "yellow" ), limits = c( -4, 8) );
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
p1 <- p1 + ylim(0,max(one.data$log10_p_value)+one.y_range/10);
p1<-p1 + theme_classic() +guides(col=FALSE)+#theme(legend.position="bottom") 
  theme(axis.ticks.x=element_blank(),axis.text.x=element_blank(),axis.text.y=element_text(color = "black", size = 12),axis.title = element_text(size = 15),legend.title=element_text(size=15, color='black'),legend.text=element_text(size=12, color='black'))
# --------------------------------------------------------------------------
# Output the plot to screen

#p1;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

ggsave("revigo-plot_2_test.pdf",width=5, height=4, units='in')
