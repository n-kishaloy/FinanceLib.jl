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

import Dates

"""
`yearFrac(d0,d1) = Day difference (d1 - d0) in fraction of a year`

* d0 = reference date
* d1 = target date

This function is similar to its counterpart in MS Excel except it divides the day 
by 365.25 instead of more complicated rules followed in Excel.
"""
yearFrac(d0,d1) = Dates.value(d1 - d0)/365.25

"""
`invYearFrac(t0, yF) = Reverse of yearFrac with anchor Date and YearFrac to calculate final Date.`

* t0 = Date from which to calculate. 
* yF = Year Fraction as Float64. 
"""
invYearFrac(t0, yF) = t0 + Dates.Day(round(yF * 365.25))

"""
PeriodSeries = Series of Tuples with 1st value gives period value in Float64
"""
const PeriodSeries   = Vector{Tuple{Float64, Float64}}

"""
DateSeries = Series of Tuples with 1st value gives period value in Date
"""
const DateSeries  = Vector{Tuple{Dates.Date, Float64}}

dateToPeriodSeries(d0, pd) = (((x,y),) -> (yearFrac(d0, x), y)).(pd)

"""
`disFactAnnual(r) = Discount factor for 1 period = 1/(1+r)`

* r = rate for 1 period
"""
disFactAnnual(r) = 1/(1+r)

"""
`disFact(r, n) = Discount factor = 1/(1+r)^n`

* r = rate for 1 period
* n = period given as Float64
"""
disFact(r, n) = 1/(1+r)^n

"""
`xdisFact(r, d0, d1) = Discount Factor between period = 1/(1+r)^yearFrac(d0, d1)`

* r  = rate for 1 year during period (d0,d1)
* d0 = begin date 
* d1 = end date 
"""
xdisFact(r, d0, d1) = 1/(1+r)^yearFrac(d0, d1)

"""
`fwdDisFact((r0,t0), (r1,t1)) 
    = Forward rate between t0 and t1 given as Float64
    = disFact(r1,t1) / disFact(r0,t0)`

* (r0, t0) = Tuple of Rate and Time in (0,t0)
* (r1, t1) = Tuple of Rate and Time in (0,t1)
"""
fwdDisFact((r0,t0), (r1,t1)) = disFact(r1,t1) / disFact(r0,t0)


"""
`tMul(r,n) = Time Multiplier`

* r = rate of increase / time period
* n = nos of time periods
"""
tMul(r,n) = (1+r)^n

"""
`tMul(r,n,m) = Time Multiplier`

*r = rate of increase / time period
*n = nos of time periods
*m = nos of period / time period
"""
tMul(r,n,m) = (1+r/m)^(n*m)

"""
`rateGwth(f,p,n) = Rate which gives a growth over a specified period`

* f = FV
* p = PV
* n = nos of time periods
"""
rateGwth(f,p,n) = (f/p)^(1/n) - 1

"""
`periodGwth(f,p,r) = Number of time periods to increase from p to f`

* f = FV
* p = PV
* r = rate of return
"""
periodGwth(f,p,r) = log(f/p)/log(1+r)

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

"""
`fv(pv,r,n,m) = FV of a Future cash flow with multiple compounding per period`

* pv = Present cash flow
* r  = rate of return
* n  = number of periods
* m  = number of compounding per period
"""
fv(pv,r,n,m) = pv*(1+r/m)^(n*m)

"""
`fv(pv,r,n) = FV of a Future cash flow with multiple compounding per period`

* pv = Present cash flow
* r  = rate of return
* n  = number of periods
"""
fv(pv,r,n) = pv*(1+r)^n

"""
`fvc(pv,r,n) = FV of continuous expontial growth`

* pv = PV
* r = rate of return
* n = number of periods
"""
fvc(pv,r,n) = pv*exp(r*n)

"""
`effR(r,m) = effective rate of return for multiple compounding per period`

  * r = nominal rate of return in a period
  * m = number of compounding per period
"""
effR(r,m) = (1.0 + r/m)^m - 1.0

"""
`expToEffR(r) = Exp rate to effective rate`

* r = exponential rate
"""
expToEffR(r) = exp(r) - 1.0

"""
`expToNomR(r,m) = Exp rate to nominal rate`

* r = exponential rate
* m = number of compounding per period
"""
expToNomR(r,m) = (exp(r/m) - 1.0)*m

"""
`nominalRate(r,m) = nominal rate of return for multiple compounding per period`

  * r = effective rate of return in a period
  * m = number of compounding per period
"""
nomR(r,m) = ((1.0 + r)^(1.0/m) - 1.0)*m

"""
`expR(r) = real rate of return for continuous exponential compounding`

  * r = effective rate of return in a period 
"""
expR(r) = log(1.0 + r) 

"""
`expR(r,m) = real rate of return for continuous exponential compounding`

  * m = number of compounding per period
  * r = nominal rate of return in a period
"""
expR(r,m) = m*log(1.0 + r/m)

"""
`npv(r,tim,cf,t0) = NPV of cash flows against time given in periods`

* r   = rate of return across the periods
* tim = vector of time of cash flows given as Float64
* cf  = vector of corresponding cash flows
* t0  = time period at which the NPV is sought. Essentially, NPV(ti - t0)
"""
function npv(r,tim,cf,t0) r += 1.0; sum(cf ./ r .^ tim) * r^t0 end

"""
`npv(r,cf,t0) = NPV of cash flows against time given in periods`

* r   = rate of return across the periods
* cf  = vector of tuple of (time in Float64, cash flows)
* t0  = time period at which the NPV is sought. Essentially, NPV(ti - t0)
"""
function npv(r,cf,t0) r += 1.0; sum( (((t,x),) -> x/r^t).(cf) ) * r^t0 end

"""
`npv(tr::PeriodSeries,cf,t0) = NPV of cash flows with rate given by period`

* tr  = vector of Tuple (time in Float64, rate between periods @ rate / period)
* cf  = vector of corresponding cash flows
* t0  = time period at which the NPV is sought

Note: this function assumes that the time is given in ascending order, thus between 2 consecutive period given in the vector tr, tr[i-1] and tr[i], the rate / period is assumed to be r[i] between period t[i-1] to t[i], essentially f(i-1,i) = tr[i][2] ==> Forward rate per period. 

Also the time t0 is assumed to be **less than** 1st time period => t0 < tr[1][1]
"""
npv(tr::PeriodSeries,cf,t0) = (foldl(((y, i)-> (y+cf[i])/(1 + tr[i][2])^(tr[i][1] - tr[i-1][1])), length(tr):-1:2; init=0.0) + cf[1])/(1 + tr[1][2])^(tr[1][1] - t0)

import Roots

"""
`irr(tim,cf) = IRR of cash flow against time given in periods`

* tim = vector of time of cash flows given as Float64
* cf  = vector of corresponding cash flows
"""
irr(tim,cf) = Roots.find_zero(r -> npv(r,tim,cf,0.0),(0.0,0.5))

"""
`irr(cf) = IRR of cash flow against time given in periods`

* cf  = vector of tuple of (time in Float64, cash flows)
"""
irr(cf) = Roots.find_zero(r -> npv(r,cf,0.0),(0.0,0.5))

"""
`xnpv(r,tim,cf,t0) = NPV of cash flows against time given by Date`

* r   = rate of return across the years
* tim = vector of time of cash flows given as Date
* cf  = vector of corresponding cash flows
* t0  = Date at which the NPV is sought. 
"""
function xnpv(r,tim,cf,t0) r += 1.0; sum(cf./(t -> r^yearFrac(t0,t)).(tim)) end 

"""
`xnpv(r,cf,t0) = NPV of cash flows against time given by Date`

* r   = rate of return across the years
* cf  = vector of tuple of (time in Date, cash flows)
* t0  = Date at which the NPV is sought. 
"""
function xnpv(r,cf,t0) r += 1.0; sum((((t,x),) -> x/r^yearFrac(t0,t)).(cf)) end 

"""
`xnpv(tr::DateSeries,cf,t0) = NPV of cash flows with rate given by Date`

* tr  = vector of Tuple (time in Date, rate between Datess @ rate / year)
* cf  = vector of corresponding cash flows
* t0  = Date at which the NPV is sought

Note: this function assumes that the time is given in ascending order, thus between 2 consecutive period given in the vector tr, tr[i-1] and tr[i], the rate / period is assumed to be r[i] between period t[i-1] to t[i], essentially f(i-1,i) = tr[i][2] ==> Forward rate per period. 

Also the time t0 is assumed to be **less than** 1st time period => t0 < tr[1][1]
"""
xnpv(tr::DateSeries,cf,t0) = (foldl(((y, i)-> (y+cf[i])/(1 + tr[i][2])^yearFrac(tr[i-1][1], tr[i][1])), length(tr):-1:2; init=0.0) + cf[1])/(1 + tr[1][2])^yearFrac(t0, tr[1][1])

"""
`xirr(tim,cf) = IRR of cash flow against time given in Dates`

* tim = vector of time of cash flows given as Dates
* cf  = vector of corresponding cash flows
"""
xirr(tim,cf) = Roots.find_zero(r -> xnpv(r,tim,cf,Dates.Date(2020,1,1)),(0.0,0.5))

"""
`xirr(cf) = IRR of cash flow against time given in Dates`

* cf  = vector of tuple of (time in Dates, cash flows)
"""
xirr(cf) = Roots.find_zero(r -> xnpv(r,cf,Dates.Date(2020,1,1)),(0.0,0.5))

"""
`sharpe(rf,ra,sa) = (ra - rf)/sa`

Sharpe ratio where:

* rf = risk free rate
* ra = rate of return of portfolio 'a'
* sa = std dev of portfolio 'a'
"""
sharpe(rf,ra,sa) = (ra - rf)/sa

"""
`rBeta(rf,rm,r) = (r - rf)/(rm - rf)`

Map from rate to beta given a rf and rm
"""
rBeta(rf,rm,r) = (r - rf)/(rm - rf)

"""
`betaR(rf,rm,b) = rf + b*(rm - rf)`

Map from beta to rate given a rf and rm
"""
betaR(rf,rm,b) = rf + b*(rm - rf)

abstract type RateType end

abstract type NomRate <: RateType end
abstract type EffRate <: RateType end
abstract type ExpRate <: RateType end

"""
`RateCurve{T<:RateType} : struct having rates at different periods`
* T    = Can be NomRate, EffRate or ExpRate
* rate = Vector of rates at periods 
* freq = Frequency at which rates are represented

Thus if freq = 2, then rate[3] = rate @ 1.5 years
"""
struct RateCurve{T<:RateType}
  rate :: Vector{Float64}
  freq :: Int64
end

"""
`DiscountFactor : struct having discount factor of all period`
* factor  = Vector of factor at periods 
* freq    = Frequency at which factors are represented
"""
struct DiscountFactor 
  factor  :: Vector{Float64}
  freq    :: Int64
end

"""
`estimR(rt, y) = estimate rate from a RateCurve and period through Interpolation`

* rt  = RateCurve
* y   = period for which rate is to be estimated
"""
estimR(rt::RateCurve{NomRate}, y::Float64) = estimR(rt.rate, rt.freq, y)
estimR(rt::RateCurve{EffRate}, y::Float64) = estimR(rt.rate, rt.freq, y)
estimR(rt::RateCurve{ExpRate}, y::Float64) = estimR(rt.rate, rt.freq, y)

function estimR(rx, fq, y)
  pt = y*fq; fl = unsafe_trunc(Int64, pt); f0 = Int64(fl); r0 = rx[f0]
  fl == pt ? r0 : r0 + (rx[f0+1] - r0)*(pt-fl)
end 

"""
`discFactorToNominalRate(dF) = Convert Discount rate dF to Spot rate`
"""
discFactorToNominalRate(dF) = RateCurve{NomRate}( (i -> ((1/dF.factor[i])^(1/i) - 1)*dF.freq).(axes(dF.factor,1)), dF.freq)

effR(rC::RateCurve{NomRate}) = RateCurve{EffRate}((x -> effR(x, rC.freq)).(rC.rate), rC.freq)

effR(rC::RateCurve{ExpRate}) = RateCurve{EffRate}((x -> expToEffR(x)).(rC.rate), rC.freq)

nomR(rC::RateCurve{EffRate}) = RateCurve{NomRate}((x->nomR(x,rC.freq)).(rC.rate),rC.freq)

nomR(rC::RateCurve{ExpRate}) = RateCurve{NomRate}((x->expToNomR(x,rC.freq)).(rC.rate),rC.freq)

expR(rC::RateCurve{NomRate}) = RateCurve{ExpRate}((x -> expR(x, rC.freq)).(rC.rate), rC.freq)

expR(rC::RateCurve{EffRate}) = RateCurve{ExpRate}((x -> expR(x)).(rC.rate), rC.freq)




include("FixedIncomes/mod.jl")
include("Derivatives/mod.jl")

end # module
