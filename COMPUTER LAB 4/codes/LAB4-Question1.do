set more off
set linesize 240
clear all
*******************************************************************************;
***********************************PRELIMINARIES*******************************;
// net install grc1leg, from(http://www.stata.com/users/vwiggins) replace
// net install gr0075, from(http://www.stata-journal.com/software/sj18-4) replace
// ssc install labutil, replace
// ssc install sencode, replace
// cd "your_full_local_path_to_ado_folder"
// ssc install panelview, all
//
// use capacity.dta, clear
// gen demo2 = 0
// panelview Capacity demo2 lngdp, i(ccode) t(year) type(treat) title("Regime Type") xlabdist(3) ylabdist(10) legend(off) // type(treat) & number of treatment level = 1: same as ignoretreat


// * Testing Autocorrelation
// predict uhat2 , residuals
// forvalues j = 1/6 {
// quietly corr uhat2 L`j'.uhat2
// display "Autocorrelation at lag `j'" %6.3f r(rho)
// }

cd "~/GTA-ECON4004-Econometrics2/COMPUTER LAB 4/data"
*******************************************************************************;
* Question 1
use "Guns.dta", clear
des

help xt

* Setting data as panel
xtset stateid year

* Visualizing panel data
xtline stateid
xtline stateid, overlay
xtline stateid, overlay legend(off)

* Advanced panel Viewer (optional)
panelview vio shall, i(stateid) t(year) type(missing) mycolor(Reds) title("Guns.dta") xlabdist(1) ylabdist(1) legend(off)
panelview lvio shall, i(stateid) t(year) type(treat) xlabel(none) ylabel(none) ignoretreat

*******************************************************************************;
gen lvio = ln(vio)
gen lrob = ln(rob)
gen lmur = ln(mur)

global basevars "incarc_rate density avginc pop pb1064 pw1064 pm1029"
*******************************************************************************;
* Simple Regression
regress lvio shall
regress lvio shall, robust
reg lvio shall, vce(cluster stateid)// adjust for clustered S.E.

* Regression with controls
global basevars "incarc_rate density avginc pop pb1064 pw1064 pm1029"
reg lvio shall $basevars, vce(cluster stateid)

* State Fixed Effects Regression
reg lvio shall $basevars i.stateid, vce(cluster stateid)
outreg2 using "DummiesFEs.xls", stat(coef) noaster

xtreg lvio shall $basevars, fe vce(cluster stateid)

* State and Time Fixed Effects Regression
*** Approach 1 for creating year dummies
tab year
xtreg lvio shall $basevars i.year, fe vce(cluster stateid)

quiet xtreg lvio shall $basevars i.year, fe vce(cluster stateid)
_ms_extract_varlist i.year
test `r(varlist)'

*** Approach 2 for creating year dummies
tab year, generate(yr) 
global yvars "yr2  yr3  yr4  yr5  yr6  yr7  yr8  yr9 yr10 yr11 yr12 yr13 yr14 yr15 yr16 yr17 yr18 yr19 yr20 yr21 yr22 yr23"

// Alternatively, to break lines use delimiter
// #delimit ;
// global yr_vars "yr2  yr3  yr4  yr5  yr6  yr7  
// yr8  yr9 yr10 yr11 yr12 yr13 yr14 yr15 yr16 
// yr17 yr18 yr19 yr20 yr21 yr22 yr23 " ;
// #delimit cr

xtreg lvio shall $basevars $yrvars, fe vce(cluster stateid)
test $yrvars 

**********************************EXPERIMENT***********************************;
reg lvio shall, vce(cluster stateid)
estimates store mod1
reg lvio shall $basevars, vce(cluster stateid)
estimates store mod2
xtreg lvio shall $basevars, fe vce(cluster stateid)
estimates store mod3
xtreg lvio shall $basevars i.year, fe vce(cluster stateid)
estimates store mod4

outreg2 [mod1 mod2 mod3 mod4] using "Guns-regoutreg.xls"

reg lvio shall $basevars i.stateid, vce(cluster stateid)
areg lvio shall $basevars, vce(cluster stateid) absorb(stateid)
xtreg lvio shall $basevars, fe vce(cluster stateid)

regress lvio shall $basevars i.stateid, vce(cluster stateid)
outreg2 using "DummiesFEs.xls", stat(coef) noaster

** Approach 1
xtreg lvio shall $basevars, fe 
xtreg lvio shall, fe 

** Approach 2
regress lvio shall $basevars i.stateid

** Approach 3
egen double ybar = mean(lvio), by(stateid)
egen double xbar = mean(shall), by(stateid)
gen yd = lvio-ybar
gen xd = shall-xbar
regress yd xd, noconstant


