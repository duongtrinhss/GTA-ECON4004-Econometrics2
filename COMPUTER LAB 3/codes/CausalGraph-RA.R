# Using ggdag package

library(ggdag)
library(ggplot2) # To visualize data (this package is also loaded by library(tidyverse))

## Randome Assignment with covariates

coord_dag <- list(
  x = c(U = 0, W = 0, X = 1, Y = 2),
  y = c(U = 0, W = 2, X = 1, Y = 1)
)

pRCTC1 <- dagify(
  Y ~ X,
  Y ~ U,
  Y ~ W,
  W ~ ~ U,
  coords = coord_dag
) %>%
  tidy_dagitty() %>%
  dplyr::mutate(colour = ifelse(name == "U", "Unobserved", "Observed")) %>%
  dplyr::mutate(linetype = ifelse(name == "U", "dashed", "solid")) %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_point(aes(colour = colour), show.legend = FALSE) +
  geom_dag_edges(aes(edge_linetype = linetype), show.legend = FALSE,
                 end_cap = ggraph::circle(10, "mm")) +
  geom_dag_text() +
  # theme_dag() +
  theme_bw() +
  theme(
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()) +
  scale_adjusted() +
  expand_plot(expand_y = expansion(c(0.2, 0.2)))

pRCTC2 <- dagify(
  Y ~ X,
  Y ~ U,
  Y ~ W,
  W ~ ~ U,
  coords = coord_dag,
  labels = c("Y" = "unem78",
             "X" = "train",
             "W" = "unem75, unem74, educ, black, etc.")
) %>%
  tidy_dagitty() %>%
  dplyr::mutate(colour = ifelse(name == "U", "Unobserved", "Observed")) %>%
  dplyr::mutate(linetype = ifelse(name == "U", "dashed", "solid")) %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_point(aes(colour = colour), show.legend = FALSE) +
  geom_dag_edges(aes(edge_linetype = linetype), show.legend = FALSE,
                 end_cap = ggraph::circle(10, "mm")) +
  geom_dag_text() +
  geom_dag_label_repel(aes(label = label), colour = "black", show.legend = FALSE) +
  # theme_dag() +
  theme_bw() +
  theme(
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()) +
  scale_adjusted() +
  expand_plot(expand_y = expansion(c(0.2, 0.2)))

### Specify the path for the PNG file
result_path <- paste0("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 3/pictures/")
png_file_path <- paste0(result_path,"RCTCsetting1.png")
### Save the plot as an PNG file
png(file = png_file_path, width = 600, height = 600, res = 150)
print(pRCTC1)
### Close the PNG device
dev.off()