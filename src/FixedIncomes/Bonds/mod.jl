"""
```
Module      : FinanceLib.FixedIncomes.Bonds
Description : Implement Fixed Incomes modules for the FinanceLib library
Copyright   : (c) 2022 Kishaloy Neogi
License     : MIT
Maintainer  : Kishaloy Neogi
Email       : nkishaloy@yahoo.com
```
The module describes the base modules of Bonds. 


You may see the github repository at <https://github.com/n-kishaloy/FinanceLib.jl>
"""
module Bonds

import FinanceLib as Fl
import Roots

include("Rates.jl")

import FinanceLib.FixedIncomes.Bonds.Rates as Rt

"""
`CouponBond : struct defining a Coupon bond`
* c     = Coupon per period
* freq  = Frequency of coupon payment per period
* T     = Life of the Bond
"""
struct CouponBond 
  c     :: Float64
  freq  :: Int64
  T     :: Float64
end

"""
`priceCouponBond(r, bd) = Price of coupon bonds`

* r   = rate as Float64, where rate is constant
* bd  = CouponBond
"""
priceCouponBond(r::Float64, bd) = (bd.c/bd.freq) * sum( 1.0 ./ (1+r/bd.freq).^(1:(bd.freq*bd.T)) ) + 1/(1+r/bd.freq)^(bd.T * bd.freq)

"""
`priceCouponBond(r, bd) = Price of coupon bonds`

* r   = RateCurve of spot rates
* bd  = CouponBond
"""
priceCouponBond(r::Rt.RateCurve, bd) = (bd.c/bd.freq) * sum( (i -> 1/(1+ Rt.rate(r,i/bd.freq)/bd.freq)^i ).(1:(bd.freq*bd.T)) ) + 1/(1 + Rt.rate(r, bd.T)/bd.freq)^(bd.T * bd.freq)

"""
`ytmCoupleBonds(bd :: CouponBond, P) = YTM of Coupon Bonds`

* bd = CouponBond
* P = Price of CouponBond
"""
function ytmCouponBond(bd::CouponBond, P)
  cf = (i -> (i, bd.c/bd.freq)).(1:(bd.freq*bd.T))
  cf[end] = (cf[end][1], cf[end][2] + 1.0); push!(cf, (0.0, -P))
  Fl.irr(cf)*bd.freq
end

# """
# `priceCouponBond(x, c) = Price of coupon bonds`

# * x = Vector of Tuples (period as Float64, spot rate as Float64)
# * c = coupon rate as Float64 (c = 0.05 for coupon of 5 on 100 face value)
# """
# function priceCouponBond(x :: Fl.PeriodSeries, c) 
#   dc = c * (x[2][1] - x[1][1])
#   sum( (((p,r),) -> dc/(1+r)^p).(x) ) + 1/(1+x[end][2])^x[end][1]
# end

# """
# `ytmCoupleBonds(x :: Fl.PeriodSeries, c) = YTM of Coupon Bonds`

# * x = Vector of Tuples (period as Float64, spot rate as Float64)
# * c = coupon rate as Float64 (c = 0.05 for coupon of 5 on 100 face value)
# """
# function ytmCouponBond(x :: Fl.PeriodSeries, c) 
#   dc = c * (x[2][1] - x[1][1]); cf = (((t,_),) -> (t, dc)).(x)
#   cf[end] = (cf[end][1], dc + 1.0); 
#   push!(cf, (0.0, -priceCouponBond(x, c)))
#   Fl.irr(cf)
# end

end