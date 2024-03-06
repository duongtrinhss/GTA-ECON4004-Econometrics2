set more off
set linesize 240
clear all

*******************************************************************************;
***********************************PRELIMINARIES*******************************;

cd "/Users/duongtrinh/Dropbox/GTA/ECON4004/GTA-ECON4004-Econometrics2/COMPUTER LAB 5/data"
*******************************************************************************;

* Import Quarterly Data from Excel file
* first row considered as variable names
import excel "us_macro_quarterly.xlsx", sheet("Data") firstrow clear 
describe
summarize

// label var GDPC1 "Real Gross Domestic Product"
// label var JAPAN_IP "Production of Total Industry in Japan (FRED series name is JPNPROINDQISMEI)"
// label var PCECTPI "Personal Consumption Expenditures: Chain-type Price Index"
// label var CPIAUCSL "Consumer Price Index for All Urban Consumers: All Items (Quarterly Average of Monthly Values)"

display tq(1955q1)
display yq(1955,1) 

* Create a desired quarterly date, e.g. 1955q1 
display %tq tq(1955q1) //using pseudofunction tq(.)
display %tq yq(1955,1) //using function yq(.)

* Generate quarterly date variables, recursively starting from 1955q1
* By default, tq(1960q1) is defined to be 0 in Stata.
gen date1 = tq(1955q1) + _n-1
gen date2 = yq(1955,1) + _n-1
format %tq date1 date2 // express them in quarterly format, see Data Editor
list if date1 != date2 // check if both variables are identical

* Generate quarterly date variable from existing "freq" var in dataset
describe freq // note that "freq" is of daily date type (%td)
gen date3 = qofd(freq) // convert "freq" to quarterly date type
format %tq date3 // express it in quarterly format
br freq date1 date2 date3 // check results, new vars are identical 

* Declare 'us_macro_quarterly' dataset to be time-series data
tsset date1

* Line graph of two Price Index series
twoway tsline PCECTPI CPIAUCSL // create a line graph using declared time-series data
twoway line PCECTPI CPIAUCSL date1, yline(0) // equivalent graph when using standard command with datevar

*** Question 1a-i ****  
* log() is the same as ln() in Stata
gen logpce = log(PCECTPI)            
* using stata's first difference operator
gen infl = 400*D.logpce
* alternatively 
* gen infl = 400*(logpce[_n] - logpce[_n-1])


*** Question 1a-ii ****
* Plot 'infl' for defined time range				   
twoway (tsline infl if tin(1963q1,2017q4), yline(0)), title(" U.S. Inflation Rate (%)") ///
								   ytitle("") xtitle("") ///
								   tlabel(#12, labsize(vsmall)) tmtick(##4)
								   
								   
*** Question 1b-i ****
* Create Delta Infl as first difference of inflation rate
gen deltainfl = D.infl

* autocorrelation
//autocorrelations reported in column named AC
corrgram deltainfl if tin(1963q1,2017q4), lags(4)

* plot of autocorrelations with 95% confidence bands (optional)
ac deltainfl if tin(1963q1,2017q4), lags(4) 

*** Question 1b-ii ****
* Plot 'deltainfl' for defined time range
twoway (tsline deltainfl if tin(1963q1,2017q4), yline(0)), title(" Change in U.S. Inflation Rate (%)") ///
								   ytitle("") xtitle("") ///
								   tlabel(#12, labsize(vsmall)) tmtick(##4)								   
*** Question 1c-i ****
* AR(1) regression - OLS estimates
* L. takes the lag
//ldeltainfl = deltainfl[_n] - deltainfl[_n-1]
regress deltainfl L1.deltainfl if tin(1963q1,2017q4), robust

*** Question 1c-ii ****
* AR(2) regression
regress deltainfl L1.deltainfl L2.deltainfl if tin(1963q1,2017q4), robust
display e(r2_a) // Adjusted R-squared

*** Question 1c-iii ****
* Forecasting 1 period ahead deltainflation
* add the extra period2 (next quarter)
tsappend, add(1)
* estimate AR(2)
quiet regress deltainfl L.deltainfl L2.deltainfl if tin(1963q1,2017q4), r
* predict for next quarter
predict deltainflhat
list deltainflhat if tin(2017q4,2018q1)
// the last observation is the predicted inflation change

* plot change in inflation vs predicted change
twoway (tsline deltainfl) (tsline deltainflhat) if tin(1963q1,2018q1), ///
	ytitle("") xtitle("") ///
	tlabel(#8, labsize(vsmall)) tmtick(##4) ///
	legend(pos(6) cols(2)) ///
	title("Change in U.S. Inflation Rate (%) with 1-period-ahead Forecasts")
	
*** Question 1d-i ****
* ADF (augmented Dickey Fuller) on Infl
dfuller infl if tin(1963q1,2017q4), lags(2) regress

* ADF on Infl with a deterministic trend
dfuller infl if tin(1963q1,2017q4), lags(2) trend regress
// regress option to produce the regression results
// trend option to include the linear trend in AR(p) regression



