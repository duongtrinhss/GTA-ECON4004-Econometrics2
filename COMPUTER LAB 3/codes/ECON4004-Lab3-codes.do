**********************************************
* ECON4004 Econometrics 2 Lab 3
**********************************************

cd "/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 3/data"

*** Question 1 ***
use "JTRAIN2.dta", clear

*Describe the data
des

*** Q(i) ***
tabulate train
count if train==1


summarize mosinex
tabstat mosinex, s(max)


*** Q(ii) ***

regress train unem74 unem75 age educ black hisp married
regress train unem74 unem75 age educ black hisp married, robust


*** Q(iii) ***

probit train unem74 unem75 age educ black hisp married
probit train unem74 unem75 age educ black hisp married, robust

*** Q(v) ***

regress unem78 train, robust
regress unem78 train


*** Q(vi) ***

probit unem78 train

*** Q(vii) ***
regress unem78 train, robust coeflegend 
display "From LPM, probability when train=0 is: " _b[_cons]
display "From LPM, probability when train=1 is: " _b[_cons]+_b[train]

probit unem78 train, coeflegend
display "From probit, probability when train=0 is: " normal(_b[_cons])
display "From probit, probability when train=1 is: " normal(_b[_cons]+_b[train])


*** Q(viii) ***

quiet regress unem78 train unem74 unem75 age educ black hisp married, robust
predict p_lpm, xb // predicted probability from LPM

probit unem78 train unem74 unem75 age educ black hisp married

quiet probit unem78 train unem74 unem75 age educ black hisp married
predict p_probit, p // predicted probability from PROBIT

corr p_lpm p_probit
summarize p_lpm p_probit

*** Q(ix) ***

probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married

quiet probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married
margins, dydx(ib0.train) // average partial effects for train with base value 0


*** Q(x) ***
quiet probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married
margins, dydx(*) // average partial effects for all regressors

*** Question 2 ***

use "happiness.dta", clear

*Describe the data
des


*** Q(i) ***

probit vhappy ib0.occattend ib0.regattend ib1994.year

quiet probit vhappy ib0.occattend ib0.regattend ib1994.year
margins, dydx(*)

regress vhappy ib0.occattend ib0.regattend ib1994.year, robust


*** Q(ii) ***

sum income unem10 educ teens

tab income, miss // table of frequencies, treat missing values like other values
tab income, miss nolabel //  display numeric codes rather than value labels

gen highinc = (income==12) if (income != .) // only generate values for nonmissing 
tab highinc, miss

quiet probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens
margins, dydx(*)


*** Q(iv) ***

quiet probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female
margins, dydx(*)

quiet probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female ib0.black#ib0.female // include interaction term
margins, dydx(*)

// quiet probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female 
// gen b_l = black*female
// quiet probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female b_l
// margins, dydx(*)


quiet probit vhappy ib0.occattend ib0.regattend ib1994.year ib0.highinc ib0.unem10 c.educ c.teens ib0.black ib0.female ib0.black#ib0.female 
testparm ib0.black ib0.female ib0.black#ib0.female
