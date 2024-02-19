**********************************************
* ECON4004 Econometrics 2 Lab 2
**********************************************

clear all
set more off
set linesize 240

cd "/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 2/data"

*Question 2
use "Names.dta", clear

*Describing the dataset
des
*** Q(2a) ***

regress call_back black, vce(robust)
regress call_back black, robust

*Same result could be obtained using a t-test of means
ttest call_back, by(black) unequal unpaired

*** Q(2b) ***
// gen f_b = female*black
// regress call_back female, robust
// regress call_back black, robust
// regress call_back black f_b, robust
// regress call_back black female f_b, robust

*** Q(2c) ***

*Regression using only the high quality resume as a regressor
regress call_back high, vce(robust)

*Generating an interaction term for having a high quality resume and being black
gen h_b = high*black
*Regression including the interaction term
regress call_back black high h_b, vce(robust)

*Question 1
use "lead_mortality.dta", clear

*Describing the dataset
des

*Summary statistics
summarize
summarize ph, detail

*** Q(1a) ***

summarize infrate if lead == 0
summarize infrate if lead == 1
mean infrate, over(lead)

histogram infrate, normal by(lead)

*T-test of differences infant mortality, by exposure to lead pipes
ttest infrate, by(lead) unequal 

regress infrate lead, robust

*** Q(1b-i) ***
* reg yvar xvar, r

*Generating interaction of lead exposure with ph
gen lead_ph = lead*ph
*Regression of infant mortality on lead exposure, ph, and their interaction
regress infrate lead ph lead_ph, vce(robust)

*** Q(1b-ii) ***
quiet regress infrate lead ph lead_ph, vce(robust)
predict inf_hat  
separate inf_hat, by(lead)
line inf_hat0 inf_hat1 ph, sort ytitle("Infant mortality rate")    ///
								xtitle("Water pH level")           ///
                                legend(col(1) order(2 "Cities with lead pipes" 1 "Cities without lead pipes")) /// 
								xscale(range(5.5 9)) xlabel(5.5(0.5)9)							
								
*** Q(1b-iii) ***
quiet regress infrate lead ph lead_ph, vce(robust)
*Tesing the joint-significance of the coefficients of lead exposure and its interaction with ph
test lead lead_ph

* test lead = lead_ph

*** Q(1b-v) ***
* Compute median and standard deviation of pH
tabstat ph, stats(median sd)

