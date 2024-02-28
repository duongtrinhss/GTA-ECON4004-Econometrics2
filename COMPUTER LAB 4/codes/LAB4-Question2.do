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

cd "~/GTA-ECON4004-Econometrics2/COMPUTER LAB 4/data"
*******************************************************************************;
* Question 2
use "income_democracy.dta", clear
des

* Setting data as panel
xtset code year

* Visualizing panel data
xtline code
xtline code, overlay
xtline code, overlay legend(off)

* Advanced panel Viewer (optional)
panelview dem_ind log_gdppc, i(country) t(year) type(missing) title("income_democracy.dta") xlabdist(1) ylabdist(3) legend(off)

*******************************************************************************;
desc
summarize
gen y1960 =(year==1960)
gen y1965 =(year==1965)
gen y1970 =(year==1970)
gen y1975 =(year==1975)
gen y1980 =(year==1980)
gen y1985 =(year==1985)
gen y1990 =(year==1990)
gen y1995 =(year==1995)
gen y2000 =(year==2000)

* using cluster standard errors
reg dem_ind log_gdppc, vce(cluster code) //using clustered standard errors
* without clustering
reg dem_ind log_gdppc, robust //without clustering
* Compare standard errors for the two regressions above!

* include fixed time effects (only)
//time fixed effects only
reg dem_ind log_gdppc y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, vce(cluster code)
quiet reg dem_ind log_gdppc y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, vce(cluster code)
test y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000

* include fixed country effects (only)
//country fixed effects only
xtreg dem_ind log_gdppc, fe vce(cluster code)

* both fixed effects 
// both country and time fixed effects
xtreg dem_ind log_gdppc y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
quiet xtreg dem_ind log_gdppc y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
test y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000

* include controls
xtreg dem_ind log_gdppc log_pop age_median y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
xtreg dem_ind log_gdppc log_pop educ age_2 age_3 age_4 age_5 y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
quiet xtreg dem_ind log_gdppc log_pop educ age_2 age_3 age_4 age_5 y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
test y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000
quiet xtreg dem_ind log_gdppc log_pop educ age_2 age_3 age_4 age_5 y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
test age_2 age_3 age_4 age_5
quiet xtreg dem_ind log_gdppc log_pop educ age_2 age_3 age_4 age_5 y1965 y1970 y1975 y1980 y1985 y1990 y1995 y2000, fe vce(cluster code)
test age_2 age_3 age_4 age_5 educ log_pop


loneway dem_ind code //intraclass correlation
