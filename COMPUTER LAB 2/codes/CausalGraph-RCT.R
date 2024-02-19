# Using ggdag package

library(ggdag)
library(ggplot2) # To visualize data (this package is also loaded by library(tidyverse))

## RCT setting

coord_dag <- list(
  x = c(X = 1, Y = 2),
  y = c(X = 1, Y = 1)
)

pRCT1 <- dagify(
  Y ~ X,
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

pRCT2 <- dagify(
  Y ~ X,
  coords = coord_dag,
  labels = c("Y" = "call_back",
             "X" = "black")
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
result_path <- paste0("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 2/pictures/")
png_file_path <- paste0(result_path,"RCTsetting2.png")
### Save the plot as an PNG file
png(file = png_file_path, width = 500, height = 500, res = 150)
print(pRCT2)
### Close the PNG device
dev.off()

## RCT with covariates setting

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
  labels = c("Y" = "call_back",
             "X" = "black",
             "W" = "ofjobs, yearsexp, honors, etc.")
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
result_path <- paste0("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 2/pictures/")
png_file_path <- paste0(result_path,"RCTCsetting2.png")
### Save the plot as an PNG file
png(file = png_file_path, width = 600, height = 600, res = 150)
print(pRCTC2)
### Close the PNG device
dev.off()
