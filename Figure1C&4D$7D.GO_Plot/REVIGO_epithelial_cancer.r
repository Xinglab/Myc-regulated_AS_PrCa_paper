

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
revigo.data <- rbind(c("GO:0000498","base pairing with RNA", 0.167, 5.220,-4.706, 1.462,-9.9090,0.877,0.000),
                     c("GO:0001104","RNA polymerase II transcription cofactor activity", 0.555,-0.156,-0.295, 1.987,-1.1368,0.976,0.000),
                     c("GO:0004867","serine-type endopeptidase inhibitor activity", 0.560, 0.062, 0.010, 1.991,-1.0145,0.967,0.000),
                     c("GO:0005313","L-glutamate transmembrane transporter activity", 0.081, 0.044, 1.029, 1.176,-0.8006,0.925,0.000),
                     c("GO:1902945","metalloendopeptidase activity involved in amyloid precursor protein catabolic process", 0.670,-2.485, 0.149, 2.068,-2.0321,0.829,0.000),
                     c("GO:0050699","WW domain binding", 0.133,-0.263,-0.517, 1.380,-1.3825,0.972,0.004),
                     c("GO:0005544","calcium-dependent phospholipid binding", 0.324, 0.881,-0.738, 1.756,-1.2686,0.977,0.005),
                     c("GO:0001540","beta-amyloid binding", 0.191,-0.373,-0.291, 1.531,-0.8847,0.990,0.005),
                     c("GO:0030346","protein phosphatase 2B binding", 0.035, 0.703, 0.440, 0.845,-0.9813,0.954,0.023),
                     c("GO:0031795","G-protein coupled GABA receptor binding", 0.047, 1.293, 7.379, 0.954,-1.3825,0.853,0.023),
                     c("GO:0017166","vinculin binding", 0.058,-0.072,-0.241, 1.041,-1.3825,0.967,0.023),
                     c("GO:0032183","SUMO binding", 0.092,-0.135,-0.194, 1.230,-0.7239,0.980,0.024),
                     c("GO:0070412","R-SMAD binding", 0.133,-0.454,-0.305, 1.380,-0.6694,0.980,0.027),
                     c("GO:0070491","repressing transcription factor binding", 0.329, 0.385, 1.198, 1.763,-1.2686,0.950,0.027),
                     c("GO:0035064","methylated histone binding", 0.312,-0.177,-0.145, 1.740,-0.7128,0.972,0.029),
                     c("GO:0004709","MAP kinase kinase kinase activity", 0.133,-6.249,-1.934, 1.380,-1.9183,0.818,0.119),
                     c("GO:0015035","protein disulfide oxidoreductase activity", 0.139,-2.567,-0.936, 1.398,-0.8006,0.908,0.119),
                     c("GO:0020037","heme binding", 0.780, 2.858,-2.456, 2.134,-0.6694,0.937,0.124),
                     c("GO:0005506","iron ion binding", 0.959, 0.586,-0.681, 2.223,-1.0145,0.981,0.128),
                     c("GO:0098505","G-rich strand telomeric DNA binding", 0.046, 3.958,-3.451, 0.954,-1.3825,0.911,0.158),
                     c("GO:1990259","histone-glutamine methyltransferase activity", 0.012,-5.385,-1.910, 0.477,-1.6029,0.850,0.214),
                     c("GO:0050290","sphingomyelin phosphodiesterase D activity", 0.006,-0.733, 1.808, 0.301,-1.3825,0.864,0.216),
                     c("GO:0046981","beta-1,4-mannosylglycolipid beta-1,3-N-acetylglucosaminyltransferase activity", 0.014,-7.073,-2.389, 0.477,-1.3825,0.794,0.217),
                     c("GO:0061665","SUMO ligase activity", 0.029,-5.573,-1.894, 0.778,-0.7239,0.869,0.228),
                     c("GO:0031492","nucleosomal DNA binding", 0.168, 4.324,-3.084, 1.477,-1.1782,0.877,0.237),
                     c("GO:0046972","histone acetyltransferase activity (H4-K16 specific)", 0.052,-5.813,-1.853, 1.000,-0.8006,0.857,0.237),
                     c("GO:0089720","caspase binding", 0.035, 0.481, 0.512, 0.845,-0.7881,0.961,0.252),
                     c("GO:0008301","DNA binding, bending", 0.110, 3.969,-3.515, 1.301,-0.8006,0.910,0.252),
                     c("GO:0030306","ADP-ribosylation factor binding", 0.046, 0.445, 0.525, 0.954,-0.8006,0.957,0.256),
                     c("GO:0008432","JUN kinase binding", 0.040, 0.206, 0.366, 0.903,-0.6694,0.960,0.259),
                     c("GO:0043531","ADP binding", 0.196, 2.495,-1.999, 1.544,-1.1782,0.933,0.260),
                     c("GO:0001069","regulatory region RNA binding", 0.006, 4.156,-3.872, 0.301,-9.9090,0.900,0.267),
                     c("GO:0033204","ribonuclease P RNA binding", 0.006, 4.069,-3.789, 0.301,-9.9090,0.902,0.267),
                     c("GO:0005540","hyaluronic acid binding", 0.127, 0.704,-0.711, 1.362,-0.8006,0.984,0.276),
                     c("GO:0099510","calcium ion binding involved in regulation of cytosolic calcium ion concentration", 4.114, 1.314,-1.373, 2.853,-0.7325,0.981,0.277),
                     c("GO:0030627","pre-mRNA 5'-splice site binding", 0.012, 4.183,-3.908, 0.477,-1.9183,0.887,0.279),
                     c("GO:0042835","BRE binding", 0.012, 4.261,-3.991, 0.477,-9.9090,0.898,0.279),
                     c("GO:0061752","telomeric repeat-containing RNA binding", 0.012, 4.665,-4.184, 0.477,-9.9090,0.898,0.279),
                     c("GO:0098808","mRNA cap binding", 0.012, 4.842,-4.272, 0.477,-1.1483,0.898,0.279),
                     c("GO:0071949","FAD binding", 0.110, 2.181,-1.876, 1.301,-0.6694,0.938,0.281),
                     c("GO:0035035","histone acetyltransferase binding", 0.150, 0.613, 0.587, 1.431,-0.8006,0.957,0.283),
                     c("GO:0034584","piRNA binding", 0.017, 4.256,-3.968, 0.602,-9.9090,0.895,0.287),
                     c("GO:0098851","double-stranded miRNA binding", 0.020, 5.094,-4.581, 0.602,-1.0145,0.890,0.290),
                     c("GO:0070883","pre-miRNA binding", 0.023, 4.827,-4.335, 0.699,-9.9090,0.893,0.292),
                     c("GO:0071208","histone pre-mRNA DCP binding", 0.023, 4.853,-4.334, 0.699,-9.9090,0.893,0.292),
                     c("GO:0034513","box H/ACA snoRNA binding", 0.029, 4.793,-4.306, 0.778,-2.2691,0.892,0.297),
                     c("GO:0002151","G-quadruplex RNA binding", 0.040, 4.341,-4.011, 0.903,-9.9090,0.890,0.304),
                     c("GO:1990247","N6-methyladenosine-containing RNA binding", 0.040, 4.362,-4.063, 0.903,-9.9090,0.890,0.304),
                     c("GO:0008312","7S RNA binding", 0.046, 4.373,-4.045, 0.954,-9.9090,0.889,0.307),
                     c("GO:0035197","siRNA binding", 0.046, 4.661,-4.330, 0.954,-9.9090,0.889,0.307),
                     c("GO:0070181","small ribosomal subunit rRNA binding", 0.046, 5.279,-4.748, 0.954,-0.8006,0.889,0.307),
                     c("GO:0070878","primary miRNA binding", 0.046, 5.074,-4.618, 0.954,-9.9090,0.889,0.307),
                     c("GO:0008094","DNA-dependent ATPase activity", 0.462,-2.366, 0.376, 1.908,-1.3825,0.761,0.307),
                     c("GO:0035613","RNA stem-loop binding", 0.064, 4.391,-4.049, 1.079,-9.9090,0.886,0.314),
                     c("GO:0035198","miRNA binding", 0.087, 4.787,-4.432, 1.204,-9.9090,0.884,0.321),
                     c("GO:0061777","DNA clamp activity", 2.043, 4.921,-4.202, 2.549,-0.8224,0.886,0.324),
                     c("GO:0030331","estrogen receptor binding", 0.237, 1.116, 6.720, 1.623,-1.1368,0.889,0.324),
                     c("GO:0000339","RNA cap binding", 0.098, 5.255,-4.710, 1.255,-9.9090,0.883,0.324),
                     c("GO:0070034","telomerase RNA binding", 0.098, 4.669,-4.350, 1.255,-9.8780,0.883,0.324),
                     c("GO:0017091","AU-rich element binding", 0.133, 4.798,-4.449, 1.380,-9.9090,0.881,0.332),
                     c("GO:0051117","ATPase binding", 0.445, 0.229, 0.389, 1.892,-0.8006,0.954,0.337),
                     c("GO:0043024","ribosomal small subunit binding", 0.075, 1.449, 1.748, 1.146,-0.8006,0.976,0.350),
                     c("GO:0016922","ligand-dependent nuclear receptor binding", 0.133, 1.153, 6.426, 1.380,-0.6694,0.901,0.351),
                     c("GO:0003684","damaged DNA binding", 0.381, 4.049,-3.603, 1.826,-0.7239,0.901,0.352),
                     c("GO:0003723","RNA binding", 9.262, 4.785,-4.283, 3.205,-9.9090,0.884,0.355),
                     c("GO:0019843","rRNA binding", 0.318, 5.239,-4.699, 1.748,-9.9090,0.873,0.356),
                     c("GO:0034336","misfolded RNA binding", 0.167, 5.539,-4.892, 1.462,-9.9090,0.879,0.356),
                     c("GO:0034583","21U-RNA binding", 0.167, 4.687,-4.300, 1.462,-9.9090,0.879,0.356),
                     c("GO:1904678","alpha-aminoacyl-tRNA binding", 0.167, 4.615,-4.252, 1.462,-9.9090,0.879,0.356),
                     c("GO:1990605","GU repeat RNA binding", 0.167, 4.579,-4.186, 1.462,-9.9090,0.879,0.356),
                     c("GO:0036002","pre-mRNA binding", 0.168, 5.524,-4.911, 1.477,-9.9090,0.879,0.356),
                     c("GO:0030515","snoRNA binding", 0.173, 4.985,-4.574, 1.491,-9.9090,0.878,0.357),
                     c("GO:0017020","myosin phosphatase regulator activity", 0.006, 0.055, 0.005, 0.301,-0.8847,0.976,0.358),
                     c("GO:0017069","snRNA binding", 0.208, 5.178,-4.666, 1.568,-9.9090,0.877,0.362),
                     c("GO:0019855","calcium channel inhibitor activity", 0.064, 0.121, 0.012, 1.079,-0.7239,0.976,0.364),
                     c("GO:0000993","RNA polymerase II core binding", 0.139, 1.583, 2.299, 1.398,-1.1368,0.935,0.366),
                     c("GO:0003697","single-stranded DNA binding", 0.612, 4.146,-3.722, 2.029,-0.6625,0.897,0.371),
                     c("GO:0000049","tRNA binding", 0.283, 5.134,-4.634, 1.699,-9.6059,0.879,0.372),
                     c("GO:0003725","double-stranded RNA binding", 0.364, 4.943,-4.492, 1.806,-9.9090,0.872,0.380),
                     c("GO:0047323","[3-methyl-2-oxobutanoate dehydrogenase (acetyl-transferring)] kinase activity", 0.006,-5.740,-1.930, 0.301,-0.6731,0.855,0.383),
                     c("GO:0098640","integrin binding involved in cell-matrix adhesion", 0.012, 1.268, 6.200, 0.477,-1.0643,0.895,0.385),
                     c("GO:0008199","ferric iron binding", 0.064, 0.376,-0.709, 1.079,-0.8847,0.983,0.385),
                     c("GO:0019902","phosphatase binding", 0.901, 0.560, 0.619, 2.196,-0.6889,0.951,0.396),
                     c("GO:0005525","GTP binding", 2.225, 3.039,-2.626, 2.587,-0.6583,0.919,0.397),
                     c("GO:0047322","[hydroxymethylglutaryl-CoA reductase (NADPH)] kinase activity", 0.012,-5.793,-1.947, 0.477,-0.6731,0.849,0.399),
                     c("GO:0050405","[acetyl-CoA carboxylase] kinase activity", 0.012,-6.009,-1.902, 0.477,-0.6731,0.849,0.399),
                     c("GO:0061749","forked DNA-dependent helicase activity", 0.012,-0.557, 2.182, 0.477,-0.7239,0.825,0.402),
                     c("GO:0050254","rhodopsin kinase activity", 0.017,-6.003,-1.938, 0.602,-0.6731,0.846,0.410),
                     c("GO:0004385","guanylate kinase activity", 0.075,-5.880,-1.979, 1.146,-1.0145,0.838,0.411),
                     c("GO:0004740","pyruvate dehydrogenase (acetyl-transferring) kinase activity", 0.023,-6.006,-1.951, 0.699,-0.6731,0.843,0.418),
                     c("GO:0047696","beta-adrenergic receptor kinase activity", 0.023,-5.740,-1.993, 0.699,-0.6731,0.843,0.418),
                     c("GO:0019894","kinesin binding", 0.220,-0.075,-0.283, 1.591,-1.1368,0.964,0.421),
                     c("GO:0003729","mRNA binding", 1.075, 5.027,-4.522, 2.272,-9.9090,0.846,0.425),
                     c("GO:0010844","recombination hotspot binding", 2.043, 4.504,-3.967, 2.549,-0.8224,0.886,0.428),
                     c("GO:0061776","topological DNA entrapment activity", 2.043, 4.890,-4.177, 2.549,-0.8224,0.886,0.428),
                     c("GO:0099077","histone-dependent DNA binding", 2.043, 4.639,-4.069, 2.549,-0.8224,0.886,0.428),
                     c("GO:0100060","negative regulation of SREBP signaling pathway by DNA binding", 2.043, 4.928,-4.205, 2.549,-0.8224,0.886,0.428),
                     c("GO:0001664","G-protein coupled receptor binding", 1.479, 1.171, 6.540, 2.410,-1.1368,0.883,0.433),
                     c("GO:0003727","single-stranded RNA binding", 0.445, 4.967,-4.503, 1.892,-9.7113,0.870,0.434),
                     c("GO:0004673","protein histidine kinase activity", 0.040,-6.141,-1.975, 0.903,-0.6731,0.838,0.434),
                     c("GO:0019895","kinesin-associated mitochondrial adaptor activity", 0.091,-0.034,-0.279, 1.204,-1.1368,0.960,0.436),
                     c("GO:0008135","translation factor activity, RNA binding", 0.520, 5.434,-4.833, 1.959,-9.8780,0.868,0.441),
                     c("GO:0010857","calcium-dependent protein kinase activity", 0.069,-5.812,-2.003, 1.114,-0.6731,0.833,0.451),
                     c("GO:0050321","tau-protein kinase activity", 0.069,-6.227,-1.975, 1.114,-0.6415,0.833,0.451),
                     c("GO:0043522","leucine zipper domain binding", 0.064,-0.271,-0.530, 1.079,-1.1782,0.973,0.453),
                     c("GO:0030507","spectrin binding", 0.150,-0.143,-0.131, 1.431,-0.6694,0.965,0.453),
                     c("GO:0035173","histone kinase activity", 0.098,-5.821,-1.996, 1.255,-0.6731,0.829,0.463),
                     c("GO:0070742","C2H2 zinc finger domain binding", 0.087,-0.334,-1.042, 1.204,-1.3825,0.972,0.463),
                     c("GO:0051020","GTPase binding", 1.936, 0.339, 0.493, 2.526,-0.6694,0.949,0.463),
                     c("GO:0031700","adrenomedullin receptor binding", 0.006, 1.183, 6.666, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031714","C5a anaphylatoxin chemotactic receptor binding", 0.006, 1.183, 6.663, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031768","ghrelin receptor binding", 0.006, 1.147, 7.051, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031775","lutropin-choriogonadotropic hormone receptor binding", 0.006, 1.143, 7.045, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031811","G-protein coupled nucleotide receptor binding", 0.006, 1.150, 6.977, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031855","oxytocin receptor binding", 0.006, 1.165, 7.014, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031856","parathyroid hormone receptor binding", 0.006, 1.164, 7.011, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031859","platelet activating factor receptor binding", 0.006, 1.164, 7.008, 0.301,-1.1368,0.869,0.476),
                     c("GO:0031883","taste receptor binding", 0.006, 1.179, 6.912, 0.301,-1.1368,0.869,0.476),
                     c("GO:0000975","regulatory region DNA binding", 4.559, 5.114,-4.419, 2.898,-0.8019,0.876,0.477),
                     c("GO:0101006","protein histidine phosphatase activity", 0.240,-2.557, 0.534, 1.623,-1.1368,0.831,0.477),
                     c("GO:0097472","cyclin-dependent protein kinase activity", 0.191,-6.076,-1.984, 1.531,-0.6731,0.822,0.486),
                     c("GO:0008239","dipeptidyl-peptidase activity", 0.064,-1.148, 0.837, 1.079,-1.0145,0.848,0.496),
                     c("GO:0031711","bradykinin receptor binding", 0.012, 1.190, 6.718, 0.477,-1.0145,0.864,0.496),
                     c("GO:0031716","calcitonin receptor binding", 0.012, 1.188, 6.695, 0.477,-1.1368,0.864,0.496),
                     c("GO:0031753","endothelial differentiation G-protein coupled receptor binding", 0.012, 1.188, 7.112, 0.477,-1.1368,0.864,0.496),
                     c("GO:0031762","follicle-stimulating hormone receptor binding", 0.012, 1.177, 7.119, 0.477,-1.1368,0.864,0.496),
                     c("GO:0031862","prostanoid receptor binding", 0.012, 1.187, 6.938, 0.477,-1.1368,0.864,0.496),
                     c("GO:0030375","thyroid hormone receptor coactivator activity", 0.023, 0.339,-0.037, 0.699,-0.7306,0.962,0.497),
                     c("GO:0031685","adenosine receptor binding", 0.017, 1.192, 6.713, 0.602,-1.0145,0.861,0.509),
                     c("GO:0031871","proteinase activated receptor binding", 0.017, 1.195, 7.006, 0.602,-1.1368,0.861,0.509),
                     c("GO:0031893","vasopressin receptor binding", 0.017, 1.172, 7.051, 0.602,-1.1368,0.861,0.509),
                     c("GO:0017162","aryl hydrocarbon receptor binding", 0.052, 1.130, 6.392, 1.000,-0.7239,0.886,0.510),
                     c("GO:0005178","integrin binding", 0.601, 1.359, 6.618, 2.021,-1.0643,0.867,0.515),
                     c("GO:0003677","DNA binding",14.324, 4.846,-4.332, 3.394,-0.8224,0.879,0.515),
                     c("GO:0035256","G-protein coupled glutamate receptor binding", 0.023, 1.193, 6.848, 0.699,-1.1368,0.859,0.518),
                     c("GO:0005395","eye pigment precursor transporter activity", 0.006,-0.303, 1.494, 0.301,-0.8006,0.794,0.518),
                     c("GO:0015420","cobalamin-transporting ATPase activity", 0.006,-0.299, 2.052, 0.301,-0.8006,0.794,0.518),
                     c("GO:0015439","heme-transporting ATPase activity", 0.006,-0.329, 1.988, 0.301,-0.7306,0.794,0.518),
                     c("GO:0071997","glutathione S-conjugate-transporting ATPase activity", 0.006,-0.327, 1.105, 0.301,-0.8006,0.794,0.518),
                     c("GO:1990424","protein arginine kinase activity", 0.309,-6.111,-1.939, 1.732,-0.6731,0.816,0.521),
                     c("GO:0000497","base pairing with DNA", 1.909, 4.831,-4.157, 2.520,-0.8224,0.885,0.523),
                     c("GO:0004712","protein serine/threonine/tyrosine kinase activity", 0.231,-6.321,-1.963, 1.613,-0.6415,0.820,0.529),
                     c("GO:0031849","olfactory receptor binding", 0.035, 1.221, 7.183, 0.845,-1.1368,0.856,0.531),
                     c("GO:0003690","double-stranded DNA binding", 4.293, 4.555,-4.070, 2.872,-0.8006,0.878,0.534),
                     c("GO:0031821","G-protein coupled serotonin receptor binding", 0.040, 1.200, 7.147, 0.903,-1.1368,0.854,0.536),
                     c("GO:0031745","cysteinyl leukotriene receptor binding", 0.047, 1.213, 7.349, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031761","fMet-Leu-Phe receptor binding", 0.047, 1.216, 7.333, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031767","gastric inhibitory polypeptide receptor binding", 0.047, 1.292, 7.390, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031769","glucagon receptor binding", 0.047, 1.205, 7.401, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031774","leukotriene receptor binding", 0.047, 1.203, 7.406, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031784","melatonin receptor binding", 0.047, 1.218, 7.354, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031788","motilin receptor binding", 0.047, 1.221, 7.357, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031789","G-protein coupled acetylcholine receptor binding", 0.047, 1.293, 7.379, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031876","secretin receptor binding", 0.047, 1.209, 7.072, 0.954,-1.1368,0.853,0.542),
                     c("GO:0031889","urotensin receptor binding", 0.047, 1.212, 7.061, 0.954,-1.1368,0.853,0.542),
                     c("GO:0061761","alpha-latrotoxin receptor binding", 0.047, 1.187, 7.142, 0.954,-1.1368,0.853,0.542),
                     c("GO:0050359","tropomyosin kinase activity", 0.309,-6.482,-1.916, 1.732,-0.6731,0.816,0.542),
                     c("GO:0050369","[tyrosine 3-monooxygenase] kinase activity", 0.309,-6.488,-1.922, 1.732,-0.6731,0.816,0.542),
                     c("GO:1901916","protein kinase activity involved in regulation of protein localization to cell division site involved in cytokinesis", 0.309,-5.903,-1.988, 1.732,-0.6731,0.816,0.542),
                     c("GO:0099038","ceramide-translocating ATPase activity", 0.012,-0.333, 2.204, 0.477,-0.8006,0.785,0.543),
                     c("GO:0017124","SH3 domain binding", 0.699,-0.208,-0.210, 2.086,-0.6694,0.969,0.546),
                     c("GO:0001103","RNA polymerase II repressing transcription factor binding", 0.162, 0.386, 1.191, 1.462,-0.8224,0.948,0.557),
                     c("GO:0043565","sequence-specific DNA binding", 5.639, 5.091,-4.406, 2.990,-0.8006,0.874,0.558),
                     c("GO:0051059","NF-kappaB binding", 0.168, 0.283, 0.896, 1.477,-0.8006,0.952,0.559),
                     c("GO:0034040","lipid-transporting ATPase activity", 0.017,-0.371, 1.429, 0.602,-0.8006,0.779,0.559),
                     c("GO:0008772","[isocitrate dehydrogenase (NADP+)] kinase activity", 0.309,-6.030,-1.951, 1.732,-0.6731,0.816,0.563),
                     c("GO:0019199","transmembrane receptor protein kinase activity", 0.474,-6.714,-1.846, 1.919,-0.6731,0.809,0.563),
                     c("GO:0047764","caldesmon kinase activity", 0.309,-6.027,-1.982, 1.732,-0.6731,0.816,0.563),
                     c("GO:0047848","dephospho-[reductase kinase] kinase activity", 0.309,-6.058,-1.952, 1.732,-0.6731,0.816,0.563),
                     c("GO:0050063","low-density-lipoprotein particle receptor kinase activity", 0.309,-6.030,-1.978, 1.732,-0.6731,0.816,0.563),
                     c("GO:0018025","calmodulin-lysine N-methyltransferase activity", 0.006,-5.330,-1.892, 0.301,-0.8006,0.855,0.563),
                     c("GO:0031717","cannabinoid receptor binding", 0.047, 1.196, 6.794, 0.954,-1.1368,0.853,0.567),
                     c("GO:0031806","G-protein coupled histamine receptor binding", 0.047, 1.260, 7.226, 0.954,-1.1368,0.853,0.567),
                     c("GO:0050780","dopamine receptor binding", 0.092, 1.204, 7.160, 1.230,-1.1368,0.847,0.567),
                     c("GO:0003774","motor activity", 0.780,-2.527, 0.148, 2.134,-0.8006,0.788,0.568),
                     c("GO:0031628","opioid receptor binding", 0.052, 1.202, 6.813, 1.000,-1.1368,0.852,0.571),
                     c("GO:0031701","angiotensin receptor binding", 0.064, 1.198, 6.795, 1.079,-1.0145,0.851,0.579),
                     c("GO:0004861","cyclin-dependent protein serine/threonine kinase inhibitor activity", 0.069, 0.081,-0.001, 1.114,-0.8006,0.964,0.593),
                     c("GO:0015440","peptide-transporting ATPase activity", 0.029,-0.440, 2.013, 0.778,-0.7306,0.774,0.594),
                     c("GO:0004767","sphingomyelin phosphodiesterase activity", 0.040,-1.271, 1.792, 0.903,-1.3825,0.848,0.594),
                     c("GO:1990889","H4K20me3 modified histone binding", 0.006,-0.437,-0.776, 0.301,-0.7128,0.976,0.598),
                     c("GO:0043325","phosphatidylinositol-3,4-bisphosphate binding", 0.127, 0.948,-0.899, 1.362,-0.6694,0.978,0.607),
                     c("GO:0003786","actin lateral binding", 0.832, 1.065, 1.405, 2.161,-0.8006,0.945,0.608),
                     c("GO:0061775","cohesin ATPase activity", 0.054,-1.528, 1.775, 1.000,-1.0632,0.784,0.608),
                     c("GO:0003681","bent DNA binding", 0.006, 3.515,-3.150, 0.301,-0.8224,0.911,0.609),
                     c("GO:0045027","DNA end binding", 0.006, 3.722,-3.199, 0.301,-0.8224,0.911,0.609),
                     c("GO:0045142","triplex DNA binding", 0.006, 3.622,-3.188, 0.301,-0.8224,0.911,0.609),
                     c("GO:0030374","ligand-dependent nuclear receptor transcription coactivator activity", 0.300,-0.217,-0.716, 1.724,-0.8006,0.977,0.612),
                     c("GO:0061629","RNA polymerase II sequence-specific DNA binding transcription factor binding", 0.006, 0.349, 1.085, 0.301,-0.7306,0.957,0.617),
                     c("GO:0008330","protein tyrosine/threonine phosphatase activity", 0.017,-0.426, 0.819, 0.602,-1.1368,0.856,0.617),
                     c("GO:0033676","double-stranded DNA-dependent ATPase activity", 0.006,-0.339, 0.962, 0.301,-1.0632,0.809,0.619),
                     c("GO:0033680","ATP-dependent DNA/RNA helicase activity", 0.006,-0.361, 0.977, 0.301,-1.0632,0.803,0.619),
                     c("GO:0071855","neuropeptide receptor binding", 0.168, 1.258, 7.552, 1.477,-1.1368,0.841,0.621),
                     c("GO:0031690","adrenergic receptor binding", 0.104, 1.200, 6.760, 1.279,-1.1368,0.846,0.626),
                     c("GO:0003827","alpha-1,3-mannosylglycoprotein 2-beta-N-acetylglucosaminyltransferase activity", 0.006,-6.374,-2.233, 0.301,-1.3825,0.803,0.627),
                     c("GO:0003830","beta-1,4-mannosylglycoprotein 4-beta-N-acetylglucosaminyltransferase activity", 0.006,-6.368,-2.232, 0.301,-1.3825,0.803,0.627),
                     c("GO:0008455","alpha-1,6-mannosylglycoprotein 2-beta-N-acetylglucosaminyltransferase activity", 0.006,-6.860,-2.317, 0.301,-1.3825,0.803,0.627),
                     c("GO:0008457","beta-galactosyl-N-acetylglucosaminylgalactosylglucosyl-ceramide beta-1,3-acetylglucosaminyltransferase activity", 0.006,-6.895,-2.326, 0.301,-1.3825,0.803,0.627),
                     c("GO:0047224","acetylgalactosaminyl-O-glycosyl-glycoprotein beta-1,3-N-acetylglucosaminyltransferase activity", 0.006,-6.214,-2.175, 0.301,-1.3825,0.803,0.627),
                     c("GO:0047225","acetylgalactosaminyl-O-glycosyl-glycoprotein beta-1,6-N-acetylglucosaminyltransferase activity", 0.006,-6.209,-2.171, 0.301,-1.3825,0.803,0.627),
                     c("GO:0047256","lactosylceramide 1,3-N-acetyl-beta-D-glucosaminyltransferase activity", 0.006,-6.249,-2.195, 0.301,-1.3825,0.803,0.627),
                     c("GO:0001128","RNA polymerase II transcription coactivator activity involved in preinitiation complex assembly", 0.006,-0.191,-0.305, 0.301,-0.6694,0.978,0.629),
                     c("GO:0042557","eukaryotic elongation factor-2 kinase activator activity", 0.085, 0.108,-0.014, 1.176,-0.8006,0.963,0.629),
                     c("GO:0001085","RNA polymerase II transcription factor binding", 0.659, 0.390, 1.210, 2.061,-0.7306,0.947,0.630),
                     c("GO:0017127","cholesterol transporter activity", 0.098,-0.043, 0.664, 1.255,-0.7239,0.925,0.631),
                     c("GO:0031531","thyrotropin-releasing hormone receptor binding", 0.017, 1.218, 6.985, 0.602,-1.0145,0.855,0.632),
                     c("GO:0070336","flap-structured DNA binding", 0.012, 3.815,-3.318, 0.477,-0.8019,0.907,0.637),
                     c("GO:0034057","RNA strand-exchange activity", 0.012, 4.331,-4.057, 0.477,-0.7239,0.893,0.637),
                     c("GO:0005524","ATP binding", 8.661, 3.406,-2.965, 3.176,-1.3825,0.908,0.639),
                     c("GO:0035615","clathrin adaptor activity", 0.064,-0.054,-0.113, 1.079,-0.8006,0.973,0.642),
                     c("GO:0061628","H3K27me3 modified histone binding", 0.017,-0.283,-0.393, 0.602,-0.6731,0.975,0.643),
                     c("GO:0008375","acetylglucosaminyltransferase activity", 0.283,-6.248,-2.138, 1.699,-1.1782,0.777,0.646),
                     c("GO:0001888","glucuronyl-galactosyl-proteoglycan 4-alpha-N-acetylglucosaminyltransferase activity", 0.012,-6.621,-2.279, 0.477,-1.3825,0.796,0.651),
                     c("GO:0004577","N-acetylglucosaminyldiphosphodolichol N-acetylglucosaminyltransferase activity", 0.012,-5.968,-2.068, 0.477,-1.1782,0.796,0.651),
                     c("GO:0042328","heparan sulfate N-acetylglucosaminyltransferase activity", 0.012,-6.315,-2.199, 0.477,-1.3825,0.796,0.651),
                     c("GO:0030350","iron-responsive element binding", 0.012, 4.964,-4.439, 0.477,-1.3265,0.887,0.660),
                     c("GO:1990715","mRNA CDS binding", 0.012, 4.816,-4.275, 0.477,-1.3265,0.887,0.660),
                     c("GO:0031267","small GTPase binding", 1.774, 0.659, 0.641, 2.489,-0.6694,0.945,0.661),
                     c("GO:0003918","DNA topoisomerase type II (ATP-hydrolyzing) activity", 0.017,-0.372, 1.253, 0.602,-1.0632,0.797,0.661),
                     c("GO:0015616","DNA translocase activity", 0.017,-0.358, 1.229, 0.602,-0.8847,0.797,0.661),
                     c("GO:0047498","calcium-dependent phospholipase A2 activity", 0.046,-1.510, 1.806, 0.954,-0.7239,0.852,0.661),
                     c("GO:0004100","chitin synthase activity", 0.014,-7.204,-2.421, 0.477,-1.3825,0.794,0.666),
                     c("GO:0004166","dolichyl-phosphate alpha-N-acetylglucosaminyltransferase activity", 0.014,-7.036,-2.378, 0.477,-1.3825,0.794,0.666),
                     c("GO:0008917","lipopolysaccharide N-acetylglucosaminyltransferase activity", 0.014,-6.134,-2.153, 0.477,-1.3825,0.794,0.666),
                     c("GO:0033827","high-mannose-oligosaccharide beta-1,4-N-acetylglucosaminyltransferase activity", 0.014,-6.953,-2.355, 0.477,-1.3825,0.794,0.666),
                     c("GO:0033829","O-fucosylpeptide 3-beta-N-acetylglucosaminyltransferase activity", 0.017,-7.166,-2.339, 0.602,-1.3825,0.791,0.666),
                     c("GO:0033830","Skp1-protein-hydroxyproline N-acetylglucosaminyltransferase activity", 0.014,-7.098,-2.396, 0.477,-1.3825,0.794,0.666),
                     c("GO:0047222","mannotetraose 2-alpha-N-acetylglucosaminyltransferase activity", 0.014,-6.301,-2.188, 0.477,-1.3825,0.794,0.666),
                     c("GO:0047232","galactosyl-N-acetylglucosaminylgalactosylglucosyl-ceramide beta-1,6-N-acetylglucosaminyltransferase activity", 0.014,-6.277,-2.188, 0.477,-1.3825,0.794,0.666),
                     c("GO:0047253","alpha-1,6-mannosylglycoprotein 4-beta-N-acetylglucosaminyltransferase activity", 0.014,-6.374,-2.207, 0.477,-1.3825,0.794,0.666),
                     c("GO:0047261","steroid N-acetylglucosaminyltransferase activity", 0.014,-6.365,-2.201, 0.477,-1.3825,0.794,0.666),
                     c("GO:0047269","poly(ribitol-phosphate) N-acetylglucosaminyltransferase activity", 0.014,-6.359,-2.207, 0.477,-1.3825,0.794,0.666),
                     c("GO:0050511","undecaprenyldiphospho-muramoylpentapeptide beta-N-acetylglucosaminyltransferase activity", 0.014,-6.115,-2.137, 0.477,-1.3825,0.794,0.666),
                     c("GO:0051991","UDP-N-acetyl-D-glucosamine:N-acetylmuramoyl-L-alanyl-D-glutamyl-meso-2,6-diaminopimelyl-D-alanyl-D-alanine-diphosphoundecaprenol 4-beta-N-acetylglucosaminlytransferase activity", 0.014,-6.265,-2.186, 0.477,-1.3825,0.794,0.666),
                     c("GO:0004630","phospholipase D activity", 0.040,-1.251, 1.945, 0.903,-0.8006,0.848,0.668),
                     c("GO:0033592","RNA strand annealing activity", 0.029, 4.664,-4.272, 0.778,-0.8811,0.887,0.672),
                     c("GO:0016538","cyclin-dependent protein serine/threonine kinase regulator activity", 0.173, 0.103, 0.031, 1.491,-0.8006,0.964,0.672),
                     c("GO:0008454","alpha-1,3-mannosylglycoprotein 4-beta-N-acetylglucosaminyltransferase activity", 0.017,-7.062,-2.311, 0.602,-1.3825,0.791,0.676),
                     c("GO:0045131","pre-mRNA branch point binding", 0.006, 4.256,-3.912, 0.301,-1.3825,0.892,0.678),
                     c("GO:0043139","5'-3' DNA helicase activity", 0.046,-1.331, 2.033, 0.954,-0.7239,0.811,0.685),
                     c("GO:0042379","chemokine receptor binding", 0.341, 1.207, 6.879, 1.778,-1.1368,0.834,0.688),
                     c("GO:0033549","MAP kinase phosphatase activity", 0.081,-1.384, 0.862, 1.176,-1.1368,0.843,0.689),
                     c("GO:0051880","G-quadruplex DNA binding", 0.040, 4.042,-3.492, 0.903,-0.8019,0.900,0.693),
                     c("GO:0070009","serine-type aminopeptidase activity", 0.006,-0.388, 0.875, 0.301,-0.6694,0.867,0.694),
                     c("GO:0004706","JUN kinase kinase kinase activity", 0.023,-6.084,-1.916, 0.699,-1.9183,0.832,0.695),
                     c("GO:0019198","transmembrane receptor protein phosphatase activity", 0.092,-2.608, 0.448, 1.230,-1.1368,0.834,0.696),
                     c("GO:0003829","beta-1,3-galactosyl-O-glycosyl-glycoprotein beta-1,6-N-acetylglucosaminyltransferase activity", 0.017,-6.594,-2.257, 0.602,-1.3825,0.791,0.696),
                     c("GO:0008109","N-acetyllactosaminide beta-1,6-N-acetylglucosaminyltransferase activity", 0.017,-6.799,-2.309, 0.602,-1.3825,0.791,0.696),
                     c("GO:0008532","N-acetyllactosaminide beta-1,3-N-acetylglucosaminyltransferase activity", 0.029,-7.346,-2.398, 0.778,-1.3825,0.785,0.696),
                     c("GO:0016262","protein N-acetylglucosaminyltransferase activity", 0.017,-7.374,-2.389, 0.602,-1.3825,0.791,0.696),
                     c("GO:0030144","alpha-1,6-mannosylglycoprotein 6-beta-N-acetylglucosaminyltransferase activity", 0.017,-6.418,-2.223, 0.602,-1.1782,0.791,0.696),
                     c("GO:0047223","beta-1,3-galactosyl-O-glycosyl-glycoprotein beta-1,3-N-acetylglucosaminyltransferase activity", 0.017,-6.339,-2.206, 0.602,-1.3825,0.791,0.696),
                     c("GO:0050508","glucuronosyl-N-acetylglucosaminyl-proteoglycan 4-alpha-N-acetylglucosaminyltransferase activity", 0.017,-6.147,-2.144, 0.602,-1.3825,0.791,0.696));
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
num.of.cluster=3
cluster=as.character(kmeans(one.data[,c("plot_X","plot_Y")],num.of.cluster)$cluster)
#cluster=as.character(kmeans(one.data[,"plot_X"],num.of.cluster)$cluster)
one.data$cluster <- cluster;

# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, log10_p_value, colour = cluster, size = frequency), alpha = I(0.6) ) + scale_size_area();
#p1 <- p1 + scale_colour_gradientn( colours = c("skyblue", "yellow"), limits = c( -4, 8) );
p1 <- p1 + scale_color_manual(values = c("yellow2","skyblue",'purple'));  
#p1 <- p1+ scale_color_manual(values = brewer.pal(num.of.cluster, "YlBl")); #color the dots by cluster
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

ggsave("revigo-plot_EpiCancer_shared.pdf",width=5.5, height=4, units='in')
