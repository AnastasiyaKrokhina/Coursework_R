# Reading the RMSD Data
file.rmsd <- read.table("rmsd_PRpairs.dat", header=FALSE) 

# Extracting Protein List
list.pdb <- unique(c(as.character(file.rmsd[,1]), as.character(file.rmsd[,1]))) 
list.pdb.simp <- gsub(".pdb", "", list.pdb) 

# Creating RMSD Matrix
# Initializes a square matrix to store RMSD values, with proteins as both rows and columns
mat.rmsd <- matrix(NA, nrow=length(list.pdb), ncol=length(list.pdb)) 
rownames(mat.rmsd) <- list.pdb.simp 
colnames(mat.rmsd) <- list.pdb.simp 

# Populating the Matrix
for(prot in list.pdb){ 
prot.simp <- gsub(".pdb", "", prot) 
sel.row <- which(as.character(file.rmsd[,1])==prot) 
list.pdb2 <- gsub(".pdb", "", as.character(file.rmsd[sel.row,2])) 
mat.rmsd[prot.simp, list.pdb2] <- file.rmsd[sel.row, 4] 
} 
require(colorspace) 
library(dendextend) 
info.PR <- read.table("data_description.csv", sep=";", header=T, row.names=2) 
info.PR[,"PR_type"] <- factor(info.PR[,"PR_type"], levels=c("PR1","PR2")) 

# Clustering Preparation
d_SIMS <- as.dist(mat.rmsd) 
hc_SIMS <- hclust(d_SIMS, method="ward.D2") 

# Customizing Dendrogram Labels
protList.ssCh <- toupper(hc_SIMS$labels) 
hc_SIMS$labels <- protList.ssCh 

# Coloring the Dendrogram
dend_SIMS <- as.dendrogram(hc_SIMS) 
SIMS_groups <- rev(levels(info.PR[protList.ssCh, 1])) 
dend_SIMS <- color_branches(dend_SIMS, k = 2, groupLabels = SIMS_groups, col = rainbow_hcl(2)[2:1]) 

# Sorting and Labeling
val_sort <- as.numeric(gsub("PR", "", info.PR[protList.ssCh, 1]))[order.dendrogram(dend_SIMS)] 
labels_colors(dend_SIMS) <- rainbow_hcl(2)[2:1][sort_levels_values(val_sort)] 
prot_sort <- as.character(info.PR[protList.ssCh, 1])[order.dendrogram(dend_SIMS)] 
labels(dend_SIMS) <- paste(prot_sort, "(", labels(dend_SIMS), ")", sep = "") 
dend_SIMS <- hang.dendrogram(dend_SIMS, hang_height = 0.1) 
dend_SIMS <- assign_values_to_leaves_nodePar(dend_SIMS, 0.8, "lab.cex") 
par(mar = c(3, 3, 3, 7)) 

# Final Plot
plot(dend_SIMS, main = "PR structure classification", horiz = TRUE, nodePar = list(cex = 0.007)) 
legend("topleft", legend = SIMS_groups, fill = rainbow_hcl(2)[2:1], bty = "n")  
