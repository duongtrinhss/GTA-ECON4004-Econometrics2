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
display "From probit, probability when train=1 is: " normal(_b[_cons])
display "From probit, probability when train=0 is: " normal(_b[_cons]+_b[train])


*** Q(viii) ***
regress unem78 train unem74 unem75 age educ black hisp married, robust

quiet regress unem78 train unem74 unem75 age educ black hisp married, robust
predict p_lpm, xb // predicted probability from LPM

probit unem78 train unem74 unem75 age educ black hisp married

quiet probit unem78 train unem74 unem75 age educ black hisp married
predict p_probit, p // predicted probability from PROBIT

corr p_lpm p_probit

*** Q(ix) ***

probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married

quiet probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married
margins, dydx(ib0.train) // average partial effects for train with base value 0


*** Q(x) ***
quiet probit unem78 ib0.train ib0.unem74 ib0.unem75 c.age c.educ ib0.black ib0.hisp ib0.married
margins, dydx(*) // average partial effects for all regressors


