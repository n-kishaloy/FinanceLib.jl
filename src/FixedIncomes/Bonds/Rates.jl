"""
```
Module      : FinanceLib.FixedIncomes.Rates
Description : Implement Fixed Incomes Rates modules for the FinanceLib library
Copyright   : (c) 2022 Kishaloy Neogi
License     : MIT
Maintainer  : Kishaloy Neogi
Email       : nkishaloy@yahoo.com
```
The module describes the base modules of Fixed Incomes Rates. 


You may see the github repository at <https://github.com/n-kishaloy/FinanceLib.jl>
"""
module Rates

import FinanceLib as Fl

"""
`RateCurve : struct having rates at different periods`
* rate = Vector of rates at periods 
* freq = Frequency at which rates are represented

Thus if freq = 2, then rate[3] = rate @ 1.5 years
"""
struct RateCurve 
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

rate(rt::RateCurve, y::Float64) = rt.rate[Int64(y*rt.freq)]

function rateEst(rt::RateCurve, y::Float64)
  pt = y*rt.freq; 
  if round(pt) == pt rt.rate[Int64(pt)]
  else
    fl = floor(pt); cl = ceil(pt)
    rt.rate[Int64(fl)]*(cl - pt) + rt.rate[Int64(cl)]*(pt - fl)
  end
end


"""
`parToSpotRates(x) = Convert par rates to spot rates`

* x = RateCurve of par rates
"""
function parToSpotRates(x :: RateCurve)
  n = length(x.rate); y = RateCurve(Vector{Float64}(undef, n), x.freq)
  y.rate[1] = x.rate[1]
  for i ∈ 2:n
    xm = x.rate[i]/x.freq
    s = 1.0 - sum( (k -> xm/(1 + y.rate[k]/x.freq)^k).(1:(i-1)) )
    y.rate[i] = (((1.0 + xm) / s)^(1/i) - 1.0)*x.freq
  end
  y
end

"""
`spotToParRates(x) = Convert spot rates to par rates`

* x = RateCurve of spot rates
"""
spotToParRates(x::RateCurve) = RateCurve(1:length(x.rate) .|> i -> x.freq*(1-1/(1+x.rate[i]/x.freq)^i)/sum((k -> 1/(1 + x.rate[k]/x.freq)^k).(1:i)), x.freq)

"""
`discFactorToSpotRate(dF) = Convert Discount rate dF to Spot rate`
"""
discFactorToSpotRate(dF) = RateCurve( (i -> ((1/dF.factor[i])^(1/i) - 1)*dF.freq).(axes(dF.factor,1)), dF.freq)


end