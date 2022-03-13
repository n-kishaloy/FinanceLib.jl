"""
```
Module      : FinanceLib
Description : Implement Base modules for the FinanceLib library
Copyright   : (c) 2022 Kishaloy Neogi
License     : MIT
Maintainer  : Kishaloy Neogi
Email       : nkishaloy@yahoo.com
```
The module describes the base modules of Finance like npv,xnpv,irr,xirr,time value of money etc. 

PV is mentioned as PV,Future value as FV and Terminal value as TV

You may see the github repository at <https://github.com/n-kishaloy/FinanceLib.jl>
"""
module FinanceLib

"""
`tMul(r,n) = Time Multiplier`

* r = rate of increase / time period
* n = nos of time periods
"""
tMul(r,n) = (1+r)^n

"""
tMul(r,n,m) = Time Multiplier@

*r = rate of increase / time period
*n = nos of time periods
*m = nos of period / time period
"""
tMul(r,n,m) = (1+r/m)^(n*m)

"""
`rate(f,p,n) = Rate which gives a growth over a specified period`

* f = FV
* p = PV
* n = nos of time periods
"""
rate(f,p,n) = (f/p)^(1/n) - 1

"""
`period(f,p,r) = Number of time periods to increase from p to f`

* f = FV
* p = PV
* r = rate of return
"""
period(f,p,r) = log(f/p)/log(1+r)

"""
`pv(fv,r,n) = PV of a Future cash flow`

*fv = Future cash flow
*r  = rate of return
*n  = number of periods
"""
pv(fv,r,n) = fv/(1+r)^n

"""
`pv(fv,r,n,m) = PV of a Future cash flow with multiple compounding per period`

* fv = Future cash flow
* r  = rate of return
* n  = number of periods
* m  = number of compounding per period
"""
pv(fv,r,n,m) = pv(fv,r/m,n*m)  

"""
`pvr(fv,r,n) = PV of continuous growth`

* fv = FV
* r  = rate of return in year on year term
* n  = number of periods
"""
pvr(fv,r,n) = fv/r^n

"""
`pvc(fv,r,n) = PV of continuous expontial growth`

* fv = FV
* r  = rate of return in exponential term
* n  = number of periods
"""
pvc(fv,r,n) = fv/exp(r*n)

"""
`pvAnnuity(pmt,r,n,m) = PV of an annuity with multiple payments per period`

* pmt = payment made in each transaction
* r   = rate of return
* n   = number of periods (say, years)
* m   = number of payments per period (say, monthly where `m = 12`)
"""
pvAnnuity(pmt,r,n,m) = pmt/(r/m)*(1 - 1/(1 + r/m)^(n*m))

"""
`pvAnnuity(pmt,r,n) = PV of an annuity with single payments per period`

* pmt = payment made in each transaction
* r   = rate of return
* n   = number of periods (say, years)
"""
pvAnnuity(pmt,r,n) = pmt/r*(1 - 1/(1 + r)^n)

"""
`pvAnnuity(pmt,r) = PV of infinite payments`

* pmt = payments made at a time
* r   = rate of return between /payments/
"""
pvAnnuity(pmt,r) = pmt/r

"""
`fvAnnuity(pmt,r,n,m) = FV of an annuity with multiple payments per period`

* pmt = payment made in each transaction
* r   = rate of return
* n   = number of periods (say, years)
* m   = number of payments per period (say, monthly where *m = 12*)
"""
fvAnnuity(pmt,r,n,m) = pmt/(r/m) * ((1 + r/m)^(n*m) - 1)

"""
`fvAnnuity(pmt,r,n) = FV of an annuity with single payments per period`

* pmt = payment made in each transaction
* r   = rate of return
* n   = number of periods (say, years)
"""
fvAnnuity(pmt,r,n) = pmt/r * ((1 + r)^n - 1)

"""
`pmt(pv,r,n,m) = Payment to cover the PV of an Annuity`

* pv = PV of Annuity
* r  = rate of return
* n  = number of periods (say, years)
* m  = number of payments per period (say, monthly where m = 12)
"""
pmt(pv,r,n,m) = pv * (r/m) / (1 - 1/(1 + r/m)^(n*m))

"""
`pmt(pv,r,n,m) = Payment to cover the PV of an Annuity`

* pv = PV of Annuity
* r  = rate of return
* n  = number of periods (say, years)
"""
pmt(pv,r,n) = pv * r / (1 - 1/(1 + r)^n)

"""
`fmt(fv,r,n,m) = Payment to cover the FV of an Annuity`

* fv = FV of Annuity
* n  = number of periods (say, years)
* m  = number of payments per period (say, monthly where m = 12)
* r  = rate of return
"""
fmt(fv,r,n,m) = fv * (r/m) / ((1 + r/m)^(n*m) - 1)

"""
`fmt(fv,r,n) = Payment to cover the FV of an Annuity`

* fv = FV of Annuity
* n  = number of periods (say, years)
* r  = rate of return
"""
fmt(fv,r,n) = fv * r / ((1 + r)^n - 1)

fv(pv,r,n) = pv*(1+r)^n
fv(pv,r,n,m) = pv*(1+r/m)^(n*m)
fvc(fv,r,n) = fv*exp(r*n)

effRate(r,m) = (1.0 + r/m)^m - 1.0
effRateCont(r) = exp(r) - 1.0

function npv(r,tim,cf,t0) r += 1.0; sum(cf ./ r .^ tim) * r^t0 end
function npv(r,cf,t0) r += 1.0; sum( (((t,x),) -> x/r^t).(cf) ) * r^t0 end

import Roots

irr(tim,cf) = Roots.find_zero(r -> npv(r,tim,cf,0.0),(0.0,0.5))
irr(cf) = Roots.find_zero(r -> npv(r,cf,0.0),(0.0,0.5))

import Dates

yearFrac(d0,d1) = Dates.value(d1 - d0)/365.25

function xnpv(r,tim,cf,t0) r += 1.0; sum(cf./(t -> r^yearFrac(t0,t)).(tim)) end 
function xnpv(r,cf,t0) r += 1.0; sum((((t,x),) -> x/r^yearFrac(t0,t)).(cf)) end 

xirr(tim,cf) = Roots.find_zero(r -> xnpv(r,tim,cf,Dates.Date(2020,1,1)),(0.0,0.5))
xirr(cf) = Roots.find_zero(r -> xnpv(r,cf,Dates.Date(2020,1,1)),(0.0,0.5))




sharpe(rf,ra,sa) = (ra - rf)/sa
rBeta(rf,rm,r) = (r - rf)/(rm - rf)
betaR(rf,rm,b) = rf + b*(rm - rf)


include("Bonds/mod.jl")





end # module
