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
function priceCouponBond(x :: Fl.PeriodSeries, c)
  d = x[2][1] - x[1][1]; n = length(x)
  sum( (((p, r),) -> c*d / (1+r)^p).(x) ) + 1/(1+x[n][2])^x[n][1]
end

ytmCoupleBonds(x :: Fl.PeriodSeries, c, P) = 0

include("MoneyMarket.jl")

end