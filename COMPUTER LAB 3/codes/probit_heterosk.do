*Heteroskedasticity in Probit?

clear
set seed 222
set obs 1000000
generate x1   = rnormal()
generate x2   = int(rbeta(3,2)*3)
generate xb   = .5*(1 + x1 -1.x2 + 2.x2)
generate e    = rnormal()
generate yp   = normal(xb + e)

// Marginal effect x1
generate m1   = normalden(xb/sqrt(2))*(.5/sqrt(2))
// Treatment effect of x2 1 vs 0
generate m21  = normal(.5*(x1)/sqrt(2)) - normal(.5*(x1 + 1)/sqrt(2))
// Treatment effect of x2 2 vs 0
generate m22  = normal(.5*(x1 + 2)/sqrt(2)) - normal(.5*(x1 + 1)/sqrt(2))

help(fracreg)

fracreg probit yp x1 ib0.x2

margins, dydx(*)

summarize m*
