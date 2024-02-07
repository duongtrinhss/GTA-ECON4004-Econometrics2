**********************************************
* ECON4004 Econometrics 2 Lab 1
**********************************************
* Note: var = variable; yvar = dependent variable; xvar = regressor; 
* IVvar = instrumental_variable wvar* = control_variable_no. *
cd "~/GTA-ECON4004-Econometrics2/COMPUTER LAB 1/data"
use "fertility.dta", clear

*** Q(a) ***
* reg yvar xvar, r
// report Hetroskedasticity-robust standard errors
reg weeksm1 morekids, r


*** Q(e) ***
* regress xvar IVvar, r
reg morekids samesex, r

*** Q(f) ***

// reg morekids samesex, r
// predict morekids_hat
// reg weeksm1 morekids_hat, r

* ivregress 2sls yvar (xvar = IVvar), r
// report result of intrinsic interest with 2SLS estimate
ivregress 2sls weeksm1 (morekids = samesex), r 

* ivregress 2sls yvar (xvar = IV), r first
// report additional result from first-stage regression
ivregress 2sls weeksm1 (morekids = samesex), r first

* ivregress 2sls yvar (xvar = IV), r
* estat estat firststage
// report first-stage regression statistics
quiet ivregress 2sls weeksm1 (morekids = samesex), r 
estat firststage

* ivregress 2sls yvar (xvar = IV), r
* estat estat endog
// perform tests of endogeneity
quiet ivregress 2sls weeksm1 (morekids = samesex), r 
estat endog

*** Q(g) ***
* ivregress 2sls yvar wvar1 wvar2 wvark (xvar = IV), r
* estat estat firststage
// report first-stage regression statistics
ivregress 2sls weeksm1 agem1 black hispan othrace (morekids = samesex), r

* ivregress 2sls yvar wvar1 wvar2 wvark (xvar = IV), r
* estat estat firststage
// report first-stage regression statistics and test again the relevance of the instrumental variable
quiet ivregress 2sls weeksm1 agem1 black hispan othrace (morekids = samesex), r
estat firststage

* ivregress 2sls yvar wvar1 wvar2 wvark (xvar = IV), r
* estat estat endog
// perform tests of endogeneity
quiet ivregress 2sls weeksm1 agem1 black hispan othrace (morekids = samesex), r
estat endog


