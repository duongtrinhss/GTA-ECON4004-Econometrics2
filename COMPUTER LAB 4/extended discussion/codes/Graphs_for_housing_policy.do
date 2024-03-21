*******************************************************************************;
***********************************PRELIMINARIES*******************************;
cd "path_to_your_working_folder"
import excel "HousingPolicy.xlsx", sheet("Sheet1") firstrow clear

* Country variables ==== 
tab country
tab countryid

* Time variables ====
** create quarterly dates (2007q1 - 2023q3)
bysort countryid: gen quarterly_date = tq(2007q1) +_n-1 
format %tq quarterly_date
tab quarterly_date

** create corresponding years (2007 - 2023)
/*drop variable 'year' (as we have quarters) and create the new one*/
drop year 
gen year = yofd(dofq(quarterly_date)) 
/*eg. obtain year = 2009 if quarterly_date = 2009q2*/

* Key variables ====
** before/after the housing policy
gen after = 0
replace after =1 if quarterly_date > tq(2012q1)

** treated/nontreated country
gen treated = 0
replace treated = 1 if country == "England"

* Declare "HousingPolicy.xlsx" dataset to be panel data ====
xtset countryid quarterly_date

* Create graphs of housesper10k ====
** for each country
xtline housesper10k

** combine all countries in one graph and add a dashed line at 2012q1
display tq(2012q1) /*find value of 2012q1 in Stata, that is 208*/
*** Figure 1
xtline housesper10k, overlay /// 
       ylabel(#5,labsize(small)) /// 
	   xline(208, lcolor("gray")) xlabel(#17, labsize(vsmall)) tmtick(##4) ///
	   title("") ///
	   ytitle("housesper10k") xtitle("") ///
	   legend(label(1 "England") label(2 "Scotland") label(3 "N.Ireland") label(4 "Wales")) ///
	   legend(pos(6) cols(4) size(small))

** for England (treated country) and the average of others
/*compute average housesper10k for nontreated countries (Scotland, N.Ireland, Wales) 
to serve as the counterpart for treated country (England)*/
bysort quarterly_date treated: egen mean_houses = mean(housesper10k)
*** Figure 2
twoway line mean_houses quarterly_date if treated == 1, sort || ///
	   line mean_houses quarterly_date if treated == 0, sort lpattern(dash)  ///
	   ylabel(#5,labsize(small)) /// 
	   xline(208, lcolor("gray")) xlabel(#17, labsize(vsmall)) tmtick(##4) ///
	   title("") ///
	   ytitle("mean_houses") xtitle("") ///
	   legend(label(1 "Treated (England)") label(2 "Control (Others)")) ///
 	   legend(pos(6) cols(2) size(small))
	   
* Comment:
/*Please double check data for housesper10k in 2020q2 in England, Scotland, and 
N.Ireland as the figures showed a severe decline, or ensure you could expain this 
observation properly. There seems to be a paralel trend in Figure 2 but formal test
depend on your model specification.*/
