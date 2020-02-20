#Load dataset
df= read.table("~/Downloads/Places_Rated.txt", quote="\"", comment.char="")

data(df)

#Peek the dataset
head(df)

#Check the states names
states =row.names(df )
states

#Calcualte mean of each variable
apply(df , 2, mean)

#Calcualte variance of each variable
apply(df , 2, var)

# Apply principle component analysis to the dataset
# scale=True means the data are standardized first
pca_result =prcomp (df , scale =TRUE)

# Check what is contained in pca_resutls
names(df)

# Standard deviation of each principle components
pca_result$sdev

# principle component loading vectors
pca_result$rotation

# Sample mean and standard deviation of each variable
pca_result$center
pca_result$scale

# principle component score vector
pca_result$x

# Project data into first two principle components
biplot (pca_result , scale =0)

# Fancy plot
pca_result$rotation=-pca_result$rotation
pca_result$x=-pca_result$x



#{ggfortify} package let {ggplot2} know how to interpret PCA objects.
library(ggfortify)

# Plot data projected to first two PCs
plot_0=autoplot(pca_result, data = USArrests, colour = 'black')
png(file = "PCA_0.png", width=640, height=480)
plot_0+ theme_grey(base_size = 22)
dev.off()


plot_1=autoplot(pca_result, data = USArrests, colour = 'steelblue', label=TRUE, shape=FALSE)
png(file = "PCA_0_1.png", width=640, height=480)
plot_1+ theme_grey(base_size = 22)
dev.off()

# Plot data projected to first two PCs, add first two eigenvectors
plot_2=autoplot(pca_result, data = USArrests, colour = 'black',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 7)
png(file = "PCA_1.png", width=640, height=480)
plot_2+ theme_grey(base_size = 22)
dev.off()


# Calcualte variance explained by each PC
pca_var =pca_result$sdev ^2

# Calculate proportion of variance explained by each principal component
pve=pca_var/sum(pca_var)

# Scree plot
png(file = "Scree_1.png", width=640, height=480)
plot(pve , xlab=" Principal Component ", ylab=" Proportion of
Variance Explained ", ylim=c(0,1), xaxt="n" ,type='b', col="red", cex=2,
pch=20, cex.lab=1.5)
axis(1, at=c(1,2,3,4),labels=c(1,2,3,4))
dev.off()


# Cumulative Proportion plot
png(file = "Cumsum_1.png", width=640, height=480)
plot(cumsum (pve ), xlab=" Principal Component ", ylab ="
Cumulative Proportion of Variance Explained ", ylim=c(0,1) , xaxt="n",
type='b', col="blue", cex=2, pch=20, cex.lab=1.5)
axis(1, at=c(1,2,3,4),labels=c(1,2,3,4))
dev.off()

# Pairwise scatter plot
png(file = "pairwise_1.png", width=640, height=480)
pairs(USArrests, pch=20)
dev.off()



############# Un-standardized results #############
# We apply pca on un-standardized data by setting scale=FALSE
pca_unstd =prcomp (USArrests , scale =FALSE)

# Plot data projected to first two PCs, add first two eigenvectors
plot_1=autoplot(pca_unstd, data = USArrests, colour = 'black',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 7)
png(file = "PCA_2.png", width=640, height=480)
plot_1+ theme_grey(base_size = 22)
dev.off()


# Calculate proportion of variance explained by each principal component
pca_var_unstd =pca_unstd$sdev ^2
pve_unstd=pca_var_unstd/sum(pca_var_unstd)

# Scree plot
png(file = "Scree_2.png", width=640, height=480)
plot(pve_unstd , xlab=" Principal Component ", ylab=" Proportion of
Variance Explained ", ylim=c(0,1), xaxt="n" ,type='b', col="red", cex=2,
pch=20, cex.lab=1.5)
axis(1, at=c(1,2,3,4),labels=c(1,2,3,4))
dev.off()

# Cumulative Proportion plot
png(file = "Cumsum_2.png", width=640, height=480)
plot(cumsum (pve_unstd), xlab=" Principal Component ", ylab ="
Cumulative Proportion of Variance Explained ", ylim=c(0,1) , xaxt="n",
type='b', col="blue", cex=2, pch=20, cex.lab=1.5)
axis(1, at=c(1,2,3,4),labels=c(1,2,3,4))
dev.off()
