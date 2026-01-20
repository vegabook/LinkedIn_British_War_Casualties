library("xts")
library("RColorBrewer")
library(ggplot2)

load("xx.dat") # read in xx

ggg <- ggplot(xx, aes(x = year, y = num, colour = war)) + geom_point(size = 3)

ggg <- ggg + scale_y_log10(labels = scales::comma)

# start the x axis in 1740, and grid for x axis is every 25 years
ggg <- ggg + scale_x_continuous(limits = c(1740, NA), 
  breaks = seq(1740, 2020, by = 25))

# make sure x axis is continuous
ggg <- ggg + geom_line(aes(group = war))

# y axis label is "log 10 casualties"\
ggg <- ggg + ylab("log 10 casualties")

# reduce the kernel size of the density line
ggg <- ggg + geom_smooth(aes(x = year, y = num), 
  method = "loess", span = 0.4, se = FALSE, linetype = "dotted", colour = "darkgrey")

# use a minimal theme
ggg <- ggg + theme_minimal()

# create an extended Dark2 palette with 17 colors
dark2_extended <- colorRampPalette(brewer.pal(8, "Dark2"))
my_palette <- dark2_extended(17)
ggg <- ggg + scale_colour_manual(values = my_palette)

# red 0 axis
ggg <- ggg + geom_hline(yintercept = 0, linetype = "dashed", colour = "red")

# "boomers" start here
ggg <- ggg + geom_vline(xintercept = 1955, linetype = "dashed", colour = "dodgerblue") +
  annotate("text", x = 1958, y = max(xx$num, na.rm = TRUE), 
    label = "Post-war generations\n1955+", size =5,
    angle = 0, vjust = 2, colour = "dodgerblue", hjust = 0)

# legend at the bottom, no legend title, tight spacing
ggg <- ggg + theme(legend.position = "bottom",
  legend.title = element_blank())

# title
ggg <- ggg + ggtitle("British War Casualties 1740-2026") +
  theme(plot.title = element_text(size = 18, hjust = 0))

# save the plot to images directory
ggsave("images/plotmen.png", plot = ggg, width = 10, height = 9)








