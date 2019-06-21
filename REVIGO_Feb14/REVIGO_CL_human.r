

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
revigo.data <- rbind(c("GO:0004851","uroporphyrin-III C-methyltransferase activity", 0.024, 5.214, 3.725, 0.699,-3.1943,0.361,0.000,-2),
                     c("GO:0030374","ligand-dependent nuclear receptor transcription coactivator activity", 0.300,-0.747,-4.923, 1.724,-2.3444,0.973,0.000,3),
                     c("GO:0035198","miRNA binding", 0.087,-4.938, 4.946, 1.204,-3.3678,0.872,0.000,6),
                     c("GO:0008317","gurken receptor binding", 0.185,-1.332,-2.178, 1.519,-1.9869,0.976,0.004,2),
                     c("GO:0034452","dynactin binding", 0.058,-0.868,-2.717, 1.041,-1.4706,0.979,0.024,-4),
                     c("GO:0043130","ubiquitin binding", 0.636,-1.362,-3.793, 2.045,-1.4960,0.976,0.029,2),
                     c("GO:0001784","phosphotyrosine binding", 0.202,-1.498,-2.297, 1.556,-1.4960,0.984,0.029,2),
                     c("GO:0045296","cadherin binding", 1.710,-1.033,-3.161, 2.473,-1.3450,0.976,0.036,-4),
                     c("GO:0004536","deoxyribonuclease activity", 0.428,-0.155,-3.684, 1.875,-2.0902,0.846,0.100,3),
                     c("GO:0003723","RNA binding", 9.262,-3.832, 3.481, 3.205,-3.3678,0.898,0.236,6),
                     c("GO:0016407","acetyltransferase activity", 0.584, 4.282, 0.749, 2.009,-1.4706,0.643,0.249,3),
                     c("GO:0001069","regulatory region RNA binding", 0.006,-4.055, 3.677, 0.301,-3.3678,0.890,0.257,6),
                     c("GO:0033204","ribonuclease P RNA binding", 0.006,-3.885, 4.054, 0.301,-3.3678,0.890,0.257,6),
                     c("GO:0042835","BRE binding", 0.012,-4.000, 4.102, 0.477,-3.3678,0.886,0.268,6),
                     c("GO:0061752","telomeric repeat-containing RNA binding", 0.012,-4.075, 4.133, 0.477,-3.3678,0.886,0.268,6),
                     c("GO:0071207","histone pre-mRNA stem-loop binding", 0.012,-4.227, 3.976, 0.477,-2.0902,0.875,0.268,6),
                     c("GO:0034584","piRNA binding", 0.017,-4.114, 4.287, 0.602,-3.3678,0.883,0.275,6),
                     c("GO:0070883","pre-miRNA binding", 0.023,-4.225, 4.352, 0.699,-3.3678,0.881,0.280,6),
                     c("GO:0071208","histone pre-mRNA DCP binding", 0.023,-4.302, 4.333, 0.699,-3.3678,0.881,0.280,6),
                     c("GO:0003724","RNA helicase activity", 0.393,-0.243,-4.032, 1.839,-1.4960,0.844,0.290,3),
                     c("GO:0002151","G-quadruplex RNA binding", 0.040,-4.235, 4.532, 0.903,-3.3678,0.878,0.290,6),
                     c("GO:1990247","N6-methyladenosine-containing RNA binding", 0.040,-4.298, 4.578, 0.903,-3.3678,0.878,0.290,6),
                     c("GO:0008312","7S RNA binding", 0.046,-4.336, 4.645, 0.954,-3.3678,0.877,0.293,6),
                     c("GO:0035197","siRNA binding", 0.046,-4.742, 4.612, 0.954,-3.3678,0.877,0.293,6),
                     c("GO:0070878","primary miRNA binding", 0.046,-4.346, 4.796, 0.954,-3.3678,0.877,0.293,6),
                     c("GO:0035613","RNA stem-loop binding", 0.064,-4.409, 4.527, 1.079,-3.3678,0.874,0.300,6),
                     c("GO:0000498","base pairing with RNA", 0.167,-4.523, 4.824, 1.462,-3.3678,0.866,0.321,6),
                     c("GO:0000339","RNA cap binding", 0.098,-4.531, 5.057, 1.255,-3.3678,0.871,0.324,6),
                     c("GO:0070034","telomerase RNA binding", 0.098,-4.568, 4.948, 1.255,-3.3678,0.871,0.324,6),
                     c("GO:0017091","AU-rich element binding", 0.133,-4.710, 5.112, 1.380,-3.3678,0.868,0.332,6),
                     c("GO:1904678","alpha-aminoacyl-tRNA binding", 0.167,-4.636, 4.843, 1.462,-3.3678,0.866,0.338,6),
                     c("GO:0019843","rRNA binding", 0.318,-4.572, 4.814, 1.748,-3.3678,0.861,0.356,6),
                     c("GO:0034336","misfolded RNA binding", 0.167,-4.887, 5.157, 1.462,-3.3678,0.866,0.356,6),
                     c("GO:0034583","21U-RNA binding", 0.167,-4.668, 4.949, 1.462,-3.3678,0.866,0.356,6),
                     c("GO:1990605","GU repeat RNA binding", 0.167,-4.555, 4.688, 1.462,-3.3678,0.866,0.356,6),
                     c("GO:0036002","pre-mRNA binding", 0.168,-4.824, 5.283, 1.477,-3.3678,0.866,0.356,6),
                     c("GO:0030515","snoRNA binding", 0.173,-4.989, 5.429, 1.491,-3.3184,0.866,0.357,6),
                     c("GO:0017069","snRNA binding", 0.208,-5.182, 5.518, 1.568,-3.3678,0.865,0.362,6),
                     c("GO:0000049","tRNA binding", 0.283,-5.094, 5.491, 1.699,-3.3678,0.872,0.372,6),
                     c("GO:0003725","double-stranded RNA binding", 0.364,-4.769, 5.251, 1.806,-3.3678,0.859,0.380,6),
                     c("GO:0003729","mRNA binding", 1.075,-4.760, 5.386, 2.272,-3.3678,0.848,0.425,6),
                     c("GO:0003727","single-stranded RNA binding", 0.445,-4.782, 5.305, 1.892,-3.3011,0.857,0.434,6),
                     c("GO:0008135","translation factor activity, RNA binding", 0.520,-4.712, 5.118, 1.959,-3.3678,0.856,0.441,6),
                     c("GO:0051015","actin filament binding", 0.832,-1.247,-2.910, 2.161,-1.3611,0.979,0.467,-4),
                     c("GO:0000146","microfilament motor activity", 0.127,-0.332,-3.963, 1.362,-1.4110,0.855,0.476,-4),
                     c("GO:0004164","diphthine synthase activity", 0.006, 4.770, 3.603, 0.301,-2.5047,0.408,0.524,-2),
                     c("GO:0004790","thioether S-methyltransferase activity", 0.006, 4.896, 3.503, 0.301,-3.1943,0.401,0.524,-2),
                     c("GO:0008689","3-demethylubiquinone-9 3-O-methyltransferase activity", 0.006, 4.918, 3.455, 0.301,-3.1943,0.381,0.524,-2),
                     c("GO:0010420","polyprenyldihydroxybenzoate methyltransferase activity", 0.006, 4.734, 3.598, 0.301,-3.1943,0.408,0.524,-2),
                     c("GO:0017174","glycine N-methyltransferase activity", 0.006, 4.996, 3.610, 0.301,-2.9806,0.401,0.524,-2),
                     c("GO:0030731","guanidinoacetate N-methyltransferase activity", 0.006, 4.700, 3.574, 0.301,-3.1943,0.408,0.524,-2),
                     c("GO:0030735","carnosine N-methyltransferase activity", 0.006, 4.855, 3.633, 0.301,-2.5047,0.408,0.524,-2),
                     c("GO:0030748","amine N-methyltransferase activity", 0.006, 4.564, 3.948, 0.301,-3.1943,0.408,0.524,-2),
                     c("GO:0030760","pyridine N-methyltransferase activity", 0.006, 4.667, 3.923, 0.301,-3.1943,0.408,0.524,-2),
                     c("GO:0030791","arsenite methyltransferase activity", 0.006, 4.473, 3.893, 0.301,-3.1943,0.408,0.524,-2),
                     c("GO:0030792","methylarsonite methyltransferase activity", 0.006, 4.506, 3.884, 0.301,-3.1943,0.408,0.524,-2),
                     c("GO:0004603","phenylethanolamine N-methyltransferase activity", 0.006, 4.527, 4.263, 0.301,-2.5047,0.401,0.540,-2),
                     c("GO:0046539","histamine N-methyltransferase activity", 0.006, 4.971, 3.695, 0.301,-1.9869,0.401,0.540,-2),
                     c("GO:0000773","phosphatidyl-N-methylethanolamine N-methyltransferase activity", 0.006, 4.841, 4.054, 0.301,-2.5047,0.401,0.560,-2),
                     c("GO:0004608","phosphatidylethanolamine N-methyltransferase activity", 0.006, 4.554, 4.246, 0.301,-2.5047,0.401,0.560,-2),
                     c("GO:0008112","nicotinamide N-methyltransferase activity", 0.006, 5.030, 3.621, 0.301,-2.5047,0.401,0.560,-2),
                     c("GO:0036009","protein-glutamine N-methyltransferase activity", 0.012, 5.040, 3.916, 0.477,-2.9806,0.381,0.560,-2),
                     c("GO:0080101","phosphatidyl-N-dimethylethanolamine N-methyltransferase activity", 0.006, 4.500, 4.280, 0.301,-2.5047,0.401,0.560,-2),
                     c("GO:0046547","trans-aconitate 3-methyltransferase activity", 0.024, 5.253, 3.466, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030783","[cytochrome c]-methionine S-methyltransferase activity", 0.024, 5.750, 5.054, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030769","macrocin O-methyltransferase activity", 0.024, 5.489, 4.389, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0004481","methylene-fatty-acyl-phospholipid synthase activity", 0.024, 5.335, 3.955, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030736","phenol O-methyltransferase activity", 0.024, 5.336, 3.997, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030738","tyramine N-methyltransferase activity", 0.024, 5.408, 4.097, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030739","O-demethylpuromycin O-methyltransferase activity", 0.024, 5.405, 4.056, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030741","inositol 1-methyltransferase activity", 0.024, 5.758, 4.631, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030744","luteolin O-methyltransferase activity", 0.024, 5.786, 4.662, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030749","loganate O-methyltransferase activity", 0.024, 5.667, 4.495, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030755","quercetin 3-O-methyltransferase activity", 0.024, 5.739, 4.598, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030761","8-hydroxyquercitin 8-O-methyltransferase activity", 0.024, 5.644, 4.435, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030763","isobutyraldoxime O-methyltransferase activity", 0.024, 5.655, 4.465, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030767","3-hydroxyanthranilate 4-C-methyltransferase activity", 0.024, 5.535, 4.214, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030771","N-benzoyl-4-hydroxyanthranilate 4-O-methyltransferase activity", 0.024, 5.579, 4.327, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030772","tryptophan 2-C-methyltransferase activity", 0.024, 5.566, 4.295, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030780","12-hydroxydihydrochelirubine 12-O-methyltransferase activity", 0.024, 5.912, 4.923, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030789","precorrin-3B C17-methyltransferase activity", 0.024, 5.858, 4.845, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0052706","histidine N-methyltransferase activity", 0.024, 5.302, 3.894, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030746","isoflavone 4'-O-methyltransferase activity", 0.024, 5.959, 4.329, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030790","chlorophenol O-methyltransferase activity", 0.024, 6.044, 4.529, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0046026","precorrin-4 C11-methyltransferase activity", 0.024, 5.273, 3.676, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030770","demethylmacrocin O-methyltransferase activity", 0.024, 5.615, 4.088, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030779","10-hydroxydihydrosanguinarine 10-O-methyltransferase activity", 0.024, 6.114, 4.596, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030751","licodione 2'-O-methyltransferase activity", 0.024, 5.845, 4.065, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0051742","2-methyl-6-solanyl-1,4-benzoquinone methyltransferase activity", 0.024, 6.289, 4.557, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0052705","methylhistidine N-methyltransferase activity", 0.024, 5.321, 3.766, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030787","inositol 4-methyltransferase activity", 0.024, 6.153, 4.310, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0008825","cyclopropane-fatty-acyl-phospholipid synthase activity", 0.024, 5.256, 3.619, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030737","iodophenol O-methyltransferase activity", 0.024, 5.518, 3.785, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030753","8-hydroxyfuranocoumarin 8-O-methyltransferase activity", 0.024, 5.932, 3.997, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030758","3,7-dimethylquercitin 4'-O-methyltransferase activity", 0.024, 5.736, 3.882, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030775","glucuronoxylan 4-O-methyltransferase activity", 0.024, 6.370, 4.182, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030798","trans-aconitate 2-methyltransferase activity", 0.024, 6.098, 4.075, 0.602,-3.1943,0.371,0.568,-2),
                     c("GO:0030778","columbamine O-methyltransferase activity", 0.024, 6.320, 4.005, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030795","jasmonate O-methyltransferase activity", 0.024, 6.166, 3.985, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030757","3-methylquercitin 7-O-methyltransferase activity", 0.024, 5.782, 3.788, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030732","methionine S-methyltransferase activity", 0.024, 5.574, 3.673, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030762","tetrahydrocolumbamine 2-O-methyltransferase activity", 0.024, 5.839, 3.722, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0043839","lipid A phosphate methyltransferase activity", 0.024, 5.250, 3.535, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030740","inositol 3-methyltransferase activity", 0.024, 5.478, 3.649, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030752","5-hydroxyfuranocoumarin 5-O-methyltransferase activity", 0.024, 5.921, 3.553, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030768","16-methoxy-2,3-dihydro-3-hydroxytabersonine N-methyltransferase activity", 0.024, 5.685, 3.656, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030733","fatty acid O-methyltransferase activity", 0.024, 5.464, 3.515, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030745","dimethylhistidine N-methyltransferase activity", 0.024, 6.053, 3.364, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030747","indolepyruvate C-methyltransferase activity", 0.024, 6.086, 3.340, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030750","putrescine N-methyltransferase activity", 0.024, 5.867, 3.434, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030754","apigenin 4'-O-methyltransferase activity", 0.024, 5.958, 3.379, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030756","isoorientin 3'-O-methyltransferase activity", 0.024, 5.996, 3.360, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030766","11-O-demethyl-17-O-deacetylvindoline O-methyltransferase activity", 0.024, 5.653, 3.554, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030773","6-hydroxymellein O-methyltransferase activity", 0.024, 6.393, 3.242, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030774","anthranilate N-methyltransferase activity", 0.024, 6.418, 3.233, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030781","6-O-methylnorlaudanosoline 5'-O-methyltransferase activity", 0.024, 6.328, 3.277, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030785","[ribulose-bisphosphate carboxylase]-lysine N-methyltransferase activity", 0.024, 6.299, 3.304, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030788","precorrin-2 C20-methyltransferase activity", 0.024, 6.274, 3.315, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030796","cycloartenol 24-C-methyltransferase activity", 0.024, 6.189, 3.307, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030797","24-methylenesterol C-methyltransferase activity", 0.024, 6.163, 3.318, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0035797","tellurite methyltransferase activity", 0.024, 6.122, 3.348, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030793","3'-demethylstaurosporine O-methyltransferase activity", 0.024, 6.110, 3.035, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030734","polysaccharide O-methyltransferase activity", 0.024, 5.431, 3.543, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0030759","methylquercetagetin 6-O-methyltransferase activity", 0.024, 5.779, 3.363, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0051741","2-methyl-6-phytyl-1,4-benzoquinone methyltransferase activity", 0.024, 6.353, 2.884, 0.699,-3.1943,0.371,0.568,-2),
                     c("GO:0008174","mRNA methyltransferase activity", 0.029, 5.310, 3.270, 0.778,-2.5047,0.363,0.575,-2),
                     c("GO:0016418","S-acetyltransferase activity", 0.012, 2.865, 0.886, 0.477,-1.4706,0.709,0.607,-2),
                     c("GO:0016453","C-acetyltransferase activity", 0.023, 3.004, 1.025, 0.699,-1.4706,0.698,0.638,-2),
                     c("GO:0098641","cadherin binding involved in cell-cell adhesion", 0.104,-1.062,-3.135, 1.279,-1.3974,0.977,0.652,-4),
                     c("GO:1990450","linear polyubiquitin binding", 0.006,-1.484,-3.854, 0.301,-1.3378,0.978,0.656,2),
                     c("GO:0001105","RNA polymerase II transcription coactivator activity", 0.225,-0.840,-4.987, 1.602,-1.7839,0.973,0.669,3),
                     c("GO:0045131","pre-mRNA branch point binding", 0.006,-4.341, 3.657, 0.301,-2.0902,0.880,0.678,3),
                     c("GO:0003713","transcription coactivator activity", 1.739,-0.417,-4.635, 2.480,-1.9700,0.973,0.683,3),
                     c("GO:1990276","RNA 5'-methyltransferase activity", 0.025, 6.221, 3.042, 0.602,-2.5047,0.368,0.697,-2));
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

#k-means clustering of data
#num.of.cluster=2
#cluster=kmeans(one.data[,c("plot_X","plot_Y")],2)$cluster
#cluster=as.character(kmeans(one.data[,"plot_X"],num.of.cluster)$cluster)
#one.data$cluster <- cluster;
# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below
p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, log10_p_value, colour = cluster, size = frequency), alpha = I(0.6) ) + scale_size_area();
p1 <- p1 + scale_colour_gradientn( colours = c("steelblue1", "yellow"), limits = c( -4, 8) );
#p1 <- p1 + scale_color_manual(values = brewer.pal(num.of.cluster, "Dark2"));      #color the dots by cluster
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

ggsave("revigo-plot_CL.pdf",width=5, height=4, units='in')