# DSP,Price,Speed_in_MHz,16_Bit_MACs,40_bit_ALUs,Active_mW_per_MHz

data = read.csv("data.csv")

# Plot price versus million multiply-accumulates per second
pdf(file="price_perf.pdf")
plot(data[,2], data[,3] * data[,4], xlab="Price", ylab="Speed (MMACS)")

pdf(file="power_perf.pdf")
plot(data[,6] * data[,3], data[,3] * data[,4],
     xlab="Active Power Consumption (mW)", ylab="Speed (MMACS)")
