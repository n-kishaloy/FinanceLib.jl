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

using Dates: Date
using FinanceLib: yearFrac

"""
A struct defining Forward contracts for Assets, with periods given as Double
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

"""
A struct defining Forward contracts for Assets, with periods given as Date
  ```
struct XForward
  r     # risk-free rate of return per year
  T0    # Contract start date as Date
  T     # Forward expiry date as Date
  FT    # Forward rate @ T = S0*(1+r)^T
  benf  # Dividends and other benefits - Cost of holding the asset
end
```
"""
struct XForward
  r     ::  Float64     # risk-free rate of return per year
  T0    ::  Date  # Contract start date as Date
  T     ::  Date  # Forward expiry date as Date
  FT    ::  Float64     # Forward rate @ T = S0*(1+r)^T
  benf  ::  Float64     # Dividends and other benefits - Cost of holding the asset
end

Forward_S0(;r, T, S0, benf=0.0) = Forward(r, T, (S0 - benf)*(1+r)^T, benf)

XForward_S0(;r, T0, T, S0, benf=0.0) = XForward(r, T0, T, (S0 - benf)*(1+r)^(yearFrac(T0,T)), benf)

getS0(x::Forward) = x.FT/(1 + x.r)^x.T + x.benf

getS0(x::XForward) = x.FT/(1 + x.r)^(yearFrac(x.T0,x.T)) + x.benf

valForward(x::Forward, St, t) = St - x.benf*(1+x.r)^t - x.FT*(1 + x.r)^(t - x.T)

valForward(x::XForward, St, t) = St - x.benf*(1+x.r)^yearFrac(x.T0,t) - x.FT*(1 + x.r)^yearFrac(x.T, t)



end