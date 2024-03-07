library(tidyverse)
library(haven)

hetprobit <- read_stata("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 3/codes/hetprobit.dta")

hetprobit$est <- as.factor(hetprobit$est)

hetprobit2 <- gather(hetprobit,Metric,Value,-c("est"))

hetprobit2 %>% group_by(est,Metric) %>%
  summarise(mean = mean(Value,na.rm = TRUE)) %>%
  spread(.,est,-est) %>%
  mutate(true_value = c(NA,-.210,NA,-.190,NA,.082,NA,-.190,NA,.166,NA,NA))

homoskprobit <- read_stata("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 3/codes/homoskprobit.dta")

homoskprobit$est <- as.factor(homoskprobit$est)

homoskprobit2 <- gather(homoskprobit,Metric,Value,-c("est"))

homoskprobit2 %>% group_by(est,Metric) %>%
  summarise(mean = mean(Value)) %>%
  spread(.,est,-est) %>%
  mutate(true_value = c(NA,-.138,NA,-.153,NA,.129,NA,-.153,NA,.138,NA,NA))


hetLR <- read_stata("/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 3/codes/gm_05_100_sim.dta")

hetLR$vce <- as.factor(hetLR$vce)

hetLR <-  gather(hetLR,Metric,Value,-c("vce"))

hetLR %>% group_by(vce,Metric) %>%
  summarise(mean = mean(Value,na.rm = TRUE)) %>%
  spread(.,vce,-vce)

View(hetLR)
