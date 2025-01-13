# Reading Descriptor Data
df.desc.prox <-read.table("descriptor_prox5_5.txt", header=T, sep=";") 

# Preprocessing Descriptors
df.desc.prox2 <- df.desc.prox[,-c(1,2,20,21)] 
vect.varDesc <- apply(df.desc.prox2, 2,var) 
var.sup <- which(vect.varDesc==0) 
if(length(var.sup)>0){ 
df.desc.prox2 <- df.desc.prox2[,-var.sup] 
} 
dim(df.desc.prox2) 
rownames(df.desc.prox2) <- as.character(df.desc.prox[,1])

# Scaling and Clustering
d_SIMS <- dist(scale(df.desc.prox2)) 
hc_SIMS <- hclust(d_SIMS, method="ward.D2") 
plot(hc_SIMS, hang=-1) 

# Reading Classification Information
info.PR <- read.table("data_description_protlig.csv", sep=";", header=T, row.names=2, colClasses="character") 

# Customizing Dendrogram
protList.ssCh <- toupper(gsub("_A","",hc_SIMS$labels)) 
hc_SIMS$labels <- protList.ssCh 
dend_SIMS <- as.dendrogram(hc_SIMS) 
SIMS_groups <- rev(unique(info.PR[toupper(protList.ssCh), 1])) 
prType.num <- as.numeric(gsub("PR","", info.PR[toupper(protList.ssCh), 1])) 
val_ord <- sort_levels_values(prType.num[order.dendrogram(dend_SIMS)]) 
prot_ord <- as.character(info.PR[protList.ssCh, 1])[order.dendrogram(dend_SIMS)] 
vcol <- rainbow_hcl(2)[val_ord] 
names(vcol) <- prot_ord 
labels_colors(dend_SIMS) <- vcol 
dend_SIMS <- assign_values_to_leaves_nodePar(dend_SIMS, 0.8,"lab.cex") 
par(mar = c(3, 3, 3, 7)) 

# Final visualization
plot(dend_SIMS, horiz = TRUE, nodePar = list(cex = 0.007)) 
legend("topleft", legend = SIMS_groups, fill = vcol[SIMS_groups], bty="n") 