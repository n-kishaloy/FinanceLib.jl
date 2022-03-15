"""
```
Module      : FinanceLib.Derivatives
Description : Implement Derivatives modules for the FinanceLib library
Copyright   : (c) 2022 Kishaloy Neogi
License     : MIT
Maintainer  : Kishaloy Neogi
Email       : nkishaloy@yahoo.com
```
The module describes the base modules of Derivatives like . 


You may see the github repository at <https://github.com/n-kishaloy/FinanceLib.jl>
"""
module Derivatives

"""
```
struct Forward
  r     = risk-free rate of return per period
  T     = Forward expiry date in Double
  FT    = Forward rate @ T = S0*(1+r)^T
  benf  = Dividends and other benefits - Cost of holding the asset
end
```
"""
struct Forward
  r     :: Float64 # risk-free rate of return per period
  T     :: Float64 # Forward expiry date in Double
  FT    :: Float64 # Forward rate @ T = S0*(1+r)^T
  benf  :: Float64 # Dividends and other benefits - Cost of holding the asset
end

Forward_S0(;r, T, S0, benf=0.0) = Forward(r, T, (S0 - benf)*(1+r)^T, benf)


import Dates
import FinanceLib

"""
```
struct XForward
  r   = risk-free rate of return per year
  T   = Forward expiry date in Dates
  S0  = Asset price at start of Forward contract
  FT = Forward rate @ T = S0*(1+r)^T
  γ   = Dividends and other benefits
  θ   = Cost of holding the asset
end
```
"""
struct XForward
  r   ::  Float64     # risk-free rate of return per year
  T0  ::  Dates.Date  # Contract start date as Date
  T   ::  Dates.Date  # Forward expiry date as Date
  S0  ::  Float64     # Asset price at start of Forward contract
  FT  ::  Float64     # Forward rate @ T = S0*(1+r)^T
  γ   ::  Float64     # Dividends and other benefits
  θ   ::  Float64     # Cost of holding the asset
end

getS0(x::Forward) = x.FT/(1+x.r)^x.T + x.benf

valForward(x::Forward, St, t) = St - x.benf*(1+x.r)^t - x.FT*(1 + x.r)^(t - x.T)

valForward(x::XForward, St, t) = 0.0



end