clear all
local L = 10000000
local R = 2000
local N = 10000
set seed 222


program define mkdata
        syntax, [n(integer 10000)]
        clear
        quietly set obs `n'
        generate x1    = rchi2(1)-1
        generate x2    = int(4*rbeta(5,2))
        generate x3    = rchi2(1)-1
//         generate sg    = exp(.3*(x1 -1.x2 + 2.x2 - 3.x2 + x3))
		generate sg    = 1
        generate e     = rnormal(0 , sg)
        generate xb    = .5*(1 - x1 - 1.x2 + 2.x2 - 3.x2 + x3)
        generate y     =  xb + e > 0
 
        generate m1  = normalden(xb)*(-.5)
        generate m3  = normalden(xb)*(.5)
        generate m21 = normal(.5*(-x1 + x3))       ///
                   - normal(.5*(1 -x1 + x3))
        generate m22 = normal(.5*(2-x1 + x3))     ///
                                  -normal(.5*(1 -x1 + x3))
        generate m23 = m21
end

mkdata, n(`L')
summarize m1, meanonly
local m1  = r(mean)
summarize m3, meanonly
local m3  = r(mean)
summarize m21, meanonly
local m21 = r(mean)
summarize m22, meanonly
local m22 = r(mean)
summarize m23, meanonly
local m23 = r(mean)
 
display `m1'
display `m3'
display `m21'
display `m22'
display `m23'

postfile sims est hm1 hm1_r hm21 hm21_r hm22 hm22_r hm23 hm23_r hm3 hm3_r  ///
         rc cv using homoskprobit, replace
 
forvalues i=1/`R' {
        quietly {
                mkdata, n(`N')
                capture probit y x1 i.x2 x3, iterate(200)
                local rc = _rc
                local cv = e(converged)
                if (`rc' | `cv'==0){
                        local hm1    = .
                        local hm1_r  = .
                        local hm21   = .
                        local hm21_r = .
                        local hm22   = .
                        local hm22_r = .
                        local hm23   = .
                        local hm23_r = .
                        local hm3    = .
                        local hm3_r  = .
                }
                else {
                        margins, dydx(*) post
                        local hm1 = _b[x1]
                        test _b[x1] = `m1'
                        local hm1_r   = (r(p)<.05)
                        local hm21 = _b[1.x2]
                        test _b[1.x2] = `m21'
                        local hm21_r   = (r(p)<.05)
                        local hm22 = _b[2.x2]
                        test _b[2.x2] = `m22'
                        local hm22_r   = (r(p)<.05)
                        local hm23 = _b[3.x2]
                        test _b[3.x2] = `m23'
                        local hm23_r   = (r(p)<.05)
                        local hm3 = _b[x3]
                        test _b[x3] = `m3'
                        local hm3_r   = (r(p)<.05)
                }
                post sims (1) (`hm1') (`hm1_r') (`hm21') (`hm21_r')       ///
                          (`hm22') (`hm22_r') (`hm23') (`hm23_r') (`hm3') ///
                          (`hm3_r') (`rc') (`cv')

                capture probit y x1 i.x2 x3, vce(robust) iterate(200)
                local rc = _rc
                local cv = e(converged)
                if (`rc' | `cv'==0){
                        local hm1    = .
                        local hm1_r  = .
                        local hm21   = .
                        local hm21_r = .
                        local hm22   = .
                        local hm22_r = .
                        local hm23   = .
                        local hm23_r = .
                        local hm3    = .
                        local hm3_r  = .
                }
                else {
                        margins, dydx(*) post
                        local hm1 = _b[x1]
                        test _b[x1] = `m1'
                        local hm1_r   = (r(p)<.05)
                        local hm21 = _b[1.x2]
                        test _b[1.x2] = `m21'
                        local hm21_r   = (r(p)<.05)
                        local hm22 = _b[2.x2]
                        test _b[2.x2] = `m22'
                        local hm22_r   = (r(p)<.05)
                        local hm23 = _b[3.x2]
                        test _b[3.x2] = `m23'
                        local hm23_r   = (r(p)<.05)
                        local hm3 = _b[x3]
                        test _b[x3] = `m3'
                        local hm3_r   = (r(p)<.05)
                }
                post sims (2) (`hm1') (`hm1_r') (`hm21') (`hm21_r')       ///
                          (`hm22') (`hm22_r') (`hm23') (`hm23_r') (`hm3') ///
                          (`hm3_r') (`rc') (`cv')
 
                capture hetprobit y x1 i.x2 x3, het(x1 i.x2 x3) iterate(200)
                local rc = _rc
                local cv = e(converged)
                if (`rc' | `cv'==0) {
                        local hm1    = .
                        local hm1_r  = .
                        local hm21   = .
                        local hm21_r = .
                        local hm22   = .
                        local hm22_r = .
                        local hm23   = .
                        local hm23_r = .
                        local hm3    = .
                        local hm3_r  = .
                }
                else {
                        margins, dydx(*) post
                        local hm1 = _b[x1]
                        test _b[x1] = `m1'
                        local hm1_r   = (r(p)<.05)
                        local hm21 = _b[1.x2]
                        test _b[1.x2] = `m21'
                        local hm21_r   = (r(p)<.05)
                        local hm22 = _b[2.x2]
                        test _b[2.x2] = `m22'
                        local hm22_r   = (r(p)<.05)
                        local hm23 = _b[3.x2]
                        test _b[3.x2] = `m23'
                        local hm23_r   = (r(p)<.05)
                        local hm3 = _b[x3]
                        test _b[x3] = `m3'
                        local hm3_r   = (r(p)<.05)
                }
                post sims (3) (`hm1') (`hm1_r') (`hm21') (`hm21_r')       ///
                          (`hm22') (`hm22_r') (`hm23') (`hm23_r') (`hm3') ///
                          (`hm3_r') (`rc') (`cv')
						  
				capture regress y x1 i.x2 x3
                margins, dydx(*) post
                local hm1 = _b[x1]
                test _b[x1] = `m1'
                local hm1_r   = (r(p)<.05)
                local hm21 = _b[1.x2]
                test _b[1.x2] = `m21'
                local hm21_r   = (r(p)<.05)
                local hm22 = _b[2.x2]
                test _b[2.x2] = `m22'
                local hm22_r   = (r(p)<.05)
                local hm23 = _b[3.x2]
				test _b[3.x2] = `m23'
                local hm23_r   = (r(p)<.05)
                local hm3 = _b[x3]
                test _b[x3] = `m3'
                local hm3_r   = (r(p)<.05)
                post sims (4) (`hm1') (`hm1_r') (`hm21') (`hm21_r')       ///
                          (`hm22') (`hm22_r') (`hm23') (`hm23_r') (`hm3') ///
                          (`hm3_r') (`rc') (`cv')
						  
				capture regress y x1 i.x2 x3, vce(robust)
                margins, dydx(*) post
                local hm1 = _b[x1]
                test _b[x1] = `m1'
                local hm1_r   = (r(p)<.05)
                local hm21 = _b[1.x2]
                test _b[1.x2] = `m21'
                local hm21_r   = (r(p)<.05)
                local hm22 = _b[2.x2]
                test _b[2.x2] = `m22'
                local hm22_r   = (r(p)<.05)
                local hm23 = _b[3.x2]
				test _b[3.x2] = `m23'
                local hm23_r   = (r(p)<.05)
                local hm3 = _b[x3]
                test _b[x3] = `m3'
                local hm3_r   = (r(p)<.05)
                post sims (5) (`hm1') (`hm1_r') (`hm21') (`hm21_r')       ///
                          (`hm22') (`hm22_r') (`hm23') (`hm23_r') (`hm3') ///
                          (`hm3_r') (`rc') (`cv')
        }
        if (`i'/50) == int(`i'/50) {
        di ".                 `i'"
    }
    else {
        di _c "."
    }
}
postclose sims
use homoskprobit, clear
label define est 1 "probit" 2 "probit-robust" 3 "hetprobit" 4 "LPM" 5 "LPM-robust"
label values est est
bysort est: summarize
