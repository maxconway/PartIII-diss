FBAtimings <- read.csv("./experiments/FBAtimings.csv")
png('FBAtimings.png')
boxplot(time ~ strain, data=FBAtimings,
        range=0,
        xlab='Metabolic Model',
        ylab='time (s)'
        )
dev.off()
