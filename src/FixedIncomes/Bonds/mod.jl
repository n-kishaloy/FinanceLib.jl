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

"""
`priceCouponBond(x, c) = Price of coupon bonds`

* x = Vector of Tuples (period as Float64, spot rate as Float64)
* c = coupon rate as Float64 (c = 0.05 for coupon of 5 on 100 face value)
"""
priceCouponBond(x :: Fl.PeriodSeries, c) = sum( (((p,r),) -> c*(x[2][1] - x[1][1])/(1+r)^p).(x) ) + 1/(1+x[end][2])^x[end][1]

"""
`ytmCoupleBonds(x :: Fl.PeriodSeries, c) = YTM of Coupon Bonds`

* x = Vector of Tuples (period as Float64, spot rate as Float64)
* c = coupon rate as Float64 (c = 0.05 for coupon of 5 on 100 face value)
"""
function ytmCoupleBonds(x :: Fl.PeriodSeries, c) 
  cf =  (((t,_),) -> (t, c*(x[2][1] - x[1][1]))).(x)
  cf[end] = (cf[end][1], cf[end][2] + 1.0)
  push!(cf, (0.0, -priceCouponBond(x, c)))
  Fl.irr(cf)
end


include("Rates.jl")

end