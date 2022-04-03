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
priceCouponBond(r::Fl.RateCurve{Fl.NomRate}, bd) = (bd.c/bd.freq) * sum( (i -> 1/(1+ Fl.estimR(r,i/bd.freq)/bd.freq)^i ).(1:(bd.freq*bd.T)) ) + 1/(1 + Fl.estimR(r, bd.T)/bd.freq)^(bd.T * bd.freq)

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




end