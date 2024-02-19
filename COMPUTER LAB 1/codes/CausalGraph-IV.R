# Using ggdag package

library(ggdag)
library(ggplot2) # To visualize data (this package is also loaded by library(tidyverse))

## Linear Regression (LG) setting

coord_dag <- list(
  x = c(U = 1, X = 1, Y = 2),
  y = c(U = 0, X = 1, Y = 1)
)

pLG1 <- dagify(
  Y ~ X,
  Y ~ U,
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


pLG2 <- dagify(
  Y ~ X,
  Y ~ U,
  coords = coord_dag,
  labels = c("Y" = "weeksm1",
             "X" = "morekids")
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
result_path <- paste0("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 1/pictures/")
png_file_path <- paste0(result_path,"LGsetting1.png")
### Save the plot as an PNG file
png(file = png_file_path, width = 500, height = 500, res = 150)
print(pLG1)
### Close the PNG device
dev.off()

## Intrumental Variable (IV) setting

coord_dag <- list(
  x = c(Z = 0, U = 1, X = 1, Y = 2),
  y = c(Z = 1, U = 0, X = 1, Y = 1)
)

library(ggplot2)
dagify(
  Y ~ X + U,
  X ~ Z + U
) %>%
  tidy_dagitty() %>%
  dplyr::mutate(colour = ifelse(name == "U", "Unobserved", "Observed")) %>%
  dplyr::mutate(linetype = ifelse(name == "U", "dashed", "solid")) %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_edges(aes(edge_linetype = linetype), show.legend = FALSE) +
  geom_dag_point(aes(colour = colour), show.legend = FALSE) +
  geom_dag_text() +
  theme_dag()

coord_dag <- list(
  x = c(Z = 0, U = 1, X = 1, Y = 2),
  y = c(Z = 1, U = 0, X = 1, Y = 1)
)

pIV1 <- dagify(
  Y ~ X,
  X ~ Z,
  Y ~ U,
  X ~ U,
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

coord_dag <- list(
  x = c(Z = 0, U = 1, X = 1, Y = 2),
  y = c(Z = 1, U = 0, X = 1, Y = 1)
)

pIV2 <- dagify(
  Y ~ X,
  X ~ Z,
  Y ~ U,
  X ~ U,
  coords = coord_dag,
  labels = c("Y" = "weeksm1",
             "X" = "morekids",
             "Z" = "samesex")
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
result_path <- paste0("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 1/pictures/")
png_file_path <- paste0(result_path,"IVsetting1.png")
### Save the plot as an PNG file
png(file = png_file_path, width = 600, height = 400, res = 150)
print(pIV1)
### Close the PNG device
dev.off()

## Intrumental Variable (IV) with covariates setting

coord_dag <- list(
  x = c(Z = 0, U = 1, X = 1, Y = 2, W = 1),
  y = c(Z = 1, U = 0, X = 1, Y = 1, W = 2)
)

pIVC1 <- dagify(
  Y ~ X,
  X ~ Z,
  Y ~ U,
  X ~ U,
  Y ~ W,
  X ~ W,
  Z ~ W,
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


pIVC2 <- dagify(
  Y ~ X,
  X ~ Z,
  Y ~ U,
  X ~ U,
  Y ~ W,
  X ~ W,
  Z ~ W,
  W ~ ~ U,
  labels = c("Y" = "weeksm1",
             "X" = "morekids",
             "Z" = "samesex",
             "W" = "agem1, black, hispan, othrace"),
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
result_path <- paste0("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 1/pictures/")
png_file_path <- paste0(result_path,"IVCsetting1.png")
### Save the plot as an PNG file
png(file = png_file_path, width = 600, height = 600, res = 150)
print(pIVC1)
### Close the PNG device
dev.off()

## Example

dagify(m ~ x + y) %>%
  tidy_dagitty() %>%
  node_dconnected("x", "y", controlling_for = "m") %>%
  ggplot(aes(
    x = x,
    y = y,
    xend = xend,
    yend = yend,
    shape = adjusted,
    col = d_relationship
  )) +
  geom_dag_edges(end_cap = ggraph::circle(10, "mm")) +
  geom_dag_collider_edges() +
  geom_dag_point() +
  geom_dag_text(col = "white") +
  theme_dag() +
  scale_adjusted() +
  expand_plot(expand_y = expansion(c(0.2, 0.2))) +
  scale_color_viridis_d(
    name = "d-relationship",
    na.value = "grey85",
    begin = .35
  )


coord_dag <- list(
  x = c(p = 0, d = 1, m = 2, y = 3),
  y = c(p = 0, d = 0, m = 1, y = 0)
)

our_dag <- ggdag::dagify(d ~ p,
                         m ~ d,
                         y ~ d,
                         y ~ m,
                         coords = coord_dag)

ggdag::ggdag(our_dag) + theme_void()


# Using DiagrammeR package

library(DiagrammeR)

DiagrammeR::grViz("digraph flowchart {
      # node definitions with substituted label text
      node [fontname = Helvetica, shape = rectangle]
      tab1 [label = '@@1']
      tab2 [label = '@@2']
      tab3 [label = '@@3']
      tab4 [label = '@@4']

      # edge definitions with the node IDs
      tab1 -> tab2;
      tab1 -> tab3;
      tab1 -> tab4;
      }

      [1]: 'X'
      [2]: 'Y'
      [3]: 'U'
      [4]: 'Z'
      ")


DiagrammeR::grViz("
digraph {
  graph []
  node [shape = plaintext]
    X Y Z W
  edge [minlen = 2]

    W->Z
    W->X
    W->Y
    { rank = min; W }
    rank = same {Z->X->Y }
}
")


library(dagitty)
node_instrumental(dagitty("dag{ i->x->y; x<->y }"), "x", "y")
ggdag_instrumental(dagitty("dag{ i->x->y; i2->x->y; x<->y }"), "x", "y")

help(geom_dag_edges)

library(ggdag)

# Create a DAG
dag <- dagify(y ~ x1 + x2 + x3)

# Plot the DAG with straight edges
ggdag(dag) +
  geom_dag_edges(geom_edge_linetype("straight"))

