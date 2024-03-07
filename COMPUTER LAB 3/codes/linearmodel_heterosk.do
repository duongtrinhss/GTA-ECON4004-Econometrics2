clear all
local L = 10000000
local R = 2000
local N = 10000
set seed 222

** True regression parameters 

local tb1  = 0.5
local tb2  = -0.5
local tb3 = -0.5  
local tb4 = 1.0
local tb5 = -1.5
local tb6  = 0.5 

program define mkdata
        syntax, [n(integer 10000)]
        clear
        quietly set obs `n'
        generate x1    = rchi2(1)-1
        generate x2    = int(4*rbeta(5,2))
        generate x3    = rchi2(1)-1
        generate sg    = exp(.3*(x1 -1.x2 + 2.x2 - 3.x2 + x3))
        generate e     = rnormal(0 , sg)
        generate xb    = .5*(1 - x1 - 1.x2 + 2.x2 - 3.x2 + x3)
        generate y     =  xb + e
end

postfile sims rep vce b1 b2 b3 b4 b5 b6 			///
		      se_b1 se_b2 se_b3 se_b4 se_b5 se_b6	///
	              r_b1 r_b2 r_b3 r_b4 r_b5 r_b6		///
		      bias1 bias2 bias3 bias4 bias5 bias6	///
		      hatmax hatmin N rc using hetLR_sim, 	///
		      replace 
forvalues i=1/`R' {	
	mkdata, n(`N')	
	// Default regresssion and hat matrix 
	capture regress y x1 i.x2 x3
	local rc = _rc 
	local rank = e(rank)
	quietly predict double hat if e(sample), hat	
	if (!`rc') {
		local NS         = e(N)
		local b1         = _b[_cons]
		local b2         = _b[x1]
		local b3         = _b[1.x2]
		local b4         = _b[2.x2]
		local b5         = _b[3.x2]
		local b6         = _b[x3]
		local se1        = _se[_cons]
		local se2        = _se[x1]
		local se3        = _se[1.x2]
		local se4        = _se[2.x2]
		local se5        = _se[3.x2]
		local se6        = _se[x3]
		qui test _b[_cons]  == `tb1'
		local b1r  = (r(p)<.05) 
		qui test _b[x1]  == `tb2'
		local b2r  = (r(p)<.05) 
		qui test _b[1.x2] == `tb3'
		local b3r  = (r(p)<.05) 
		qui test _b[2.x2] == `tb4'
		local b4r  = (r(p)<.05) 
		qui test _b[3.x2] == `tb5'
		local b5r  = (r(p)<.05) 
		qui test _b[x3] == `tb6'
		local b6r  = (r(p)<.05) 
		local bs1        = `b1' - `tb1'
		local bs2        = `b2' - `tb2'
		local bs3        = `b3' - `tb3'
		local bs4        = `b4' - `tb4'
		local bs5        = `b5' - `tb5'
		local bs6        = `b6' - `tb6'
		summarize hat, meanonly 
		local hmx        = r(max)
		local hmn        = r(mean)
	}
	else {
		local NS   = .
		local b1   = .
		local b2   = .
		local b3   = .
		local b4   = .
		local b5   = .
		local b6   = .
		local se1  = .
		local se2  = .
		local se3  = .
		local se4  = .
		local se5  = .
		local se6  = .
		local b1r  = .
		local b2r  = .
		local b3r  = .
		local b4r  = .
		local b5r  = .
		local b6r  = .
		local bs1  = .
		local bs2  = .
		local bs3  = .
		local bs4  = .
		local bs5  = .
		local bs6  = .
		local hmx  = .
		local hmn  = .		
	}
	post sims (`i') (1) (`b1') (`b2') (`b3') (`b4') (`b5') (`b6')	///
		  (`se1') (`se2') (`se3') (`se4') (`se5') (`se6') 	///
		  (`b1r') (`b2r') (`b3r') (`b4r') (`b5r') (`b6r') 	///
		  (`bs1') (`bs2') (`bs3') (`bs4') (`bs5') (`bs6') 	///
		  (`hmx') (`hmn') (`NS') (`rc')	
		  
	capture regress y x1 i.x2 x3, vce(robust)
	local rc = _rc 
	if (!`rc') {
		local NS         = e(N)
		local b1         = _b[_cons]
		local b2         = _b[x1]
		local b3         = _b[1.x2]
		local b4         = _b[2.x2]
		local b5         = _b[3.x2]
		local b6         = _b[x3]
		local se1        = _se[_cons]
		local se2        = _se[x1]
		local se3        = _se[1.x2]
		local se4        = _se[2.x2]
		local se5        = _se[3.x2]
		local se6        = _se[x3]
		qui test _b[_cons]  == `tb1'
		local b1r  = (r(p)<.05) 
		qui test _b[x1]  == `tb2'
		local b2r  = (r(p)<.05) 
		qui test _b[1.x2] == `tb3'
		local b3r  = (r(p)<.05) 
		qui test _b[2.x2] == `tb4'
		local b4r  = (r(p)<.05) 
		qui test _b[3.x2] == `tb5'
		local b5r  = (r(p)<.05) 
		qui test _b[x3] == `tb6' 
		local bs1        = `b1' - `tb1'
		local bs2        = `b2' - `tb2'
		local bs3        = `b3' - `tb3'
		local bs4        = `b4' - `tb4'
		local bs5        = `b5' - `tb5'
		local bs6        = `b6' - `tb6'
	}
	else {
		local NS   = .
		local b1   = .
		local b2   = .
		local b3   = .
		local b4   = .
		local b5   = .
		local b6   = .
		local se1  = .
		local se2  = .
		local se3  = .
		local se4  = .
		local se5  = .
		local se6  = .
		local b1r  = .
		local b2r  = .
		local b3r  = .
		local b4r  = .
		local b5r  = .
		local b6r  = .
		local bs1  = .
		local bs2  = .
		local bs3  = .
		local bs4  = .
		local bs5  = .
		local bs6  = .
		local hmx  = .
		local hmn  = .		
	}
	post sims (`i') (2) (`b1') (`b2') (`b3') (`b4') (`b5') (`b6')	///
		  (`se1') (`se2') (`se3') (`se4') (`se5') (`se6') 	///
		  (`b1r') (`b2r') (`b3r') (`b4r') (`b5r') (`b6r') 	///
		  (`bs1') (`bs2') (`bs3') (`bs4') (`bs5') (`bs6') 	///
		  (`hmx') (`hmn') (`NS') (`rc')	
		  
	if (`i'/50) == int(`i'/50) {
		di ".                 `i'"
	}
	else {
		di _c "."
	}
}

postclose sims 

use hetLR_sim, clear 

label define estvce 1 "OLS" 2 "HC1" 
label values vce estvce 
// generate gamma = .5
