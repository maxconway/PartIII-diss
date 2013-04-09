FBAtimings <- read.csv("./FBAtimings.csv")
png('FBAtimings.png')
boxplot(time ~ strain, data=FBAtimings,
        range=0,
        xlab='Metabolic Model',
        ylab='time (⁻¹)'
        )
dev.off()