# DSP,Price,Speed_in_MHz,16_Bit_MACs,40_bit_ALUs,Active_mW_per_MHz

data_ad = read.csv("ad.csv")
data_ti = read.csv("ti.csv")

# Plot price versus million multiply-accumulates per second
pdf(file="price_perf.pdf")
plot(data_ad[,3] * data_ad[,4], data_ad[,2], ylab="Price", col="red",
     xlim=range(c(100, 1200)), ylim=range(c(0, 60)), xlab="Speed (MMACS)")
par(new=TRUE)
plot(data_ti[,3] * data_ti[,4], data_ti[,2], xlab="", col="blue",
     xlim=range(c(100, 1200)), ylim=range(c(0, 60)), ylab="")

pdf(file="power_perf.pdf")
plot(data_ad[,3] * data_ad[,4], data_ad[,6] * data_ad[,3], col="red",
     ylab="Active Power Consumption (mW)", xlab="Speed (MMACS)",
     ylim=range(c(0,600)), xlim=range(c(100, 1200)))
par(new=TRUE)
plot(data_ti[,3] * data_ti[,4], data_ti[,6] * data_ti[,3], col="blue",
     xlab="", ylab="", ylim=range(c(0,600)), xlim=range(c(100, 1200)))
