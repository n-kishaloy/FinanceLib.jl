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

rateVector(x::RateCurve)= Fl.PeriodSeries((i-> (i/x.freq,x.rate[i])).(axes(x.r,1)))  

rate(rt::RateCurve, y::Float64) = rt.rate[Int64(y*rt.freq)]

"""
`parToSpotRates(x) = Convert par rates to spot rates`

* x = Vector of Tuples (period as Float64, rate as Float64)
"""
function parToSpotRates(x)
  n = length(x); y = Vector{Tuple{Float64,Float64}}(undef, n); 
  y[1]= x[1]; d = x[2][1] - x[1][1]
  for i ∈ 2:n
    s = 1.0; for k ∈ 1:(i-1) s = s - x[i][2]*d/(1+y[k][2])^x[k][1] end
    y[i] = (x[i][1], ((1 + d*x[i][2])/s)^(1/x[i][1]) - 1.0 )
  end
  y
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
    s = 1.0 - sum( (k -> xm/(1 + y.rate[k])^(k*x.freq)).(1:(i-1)) )
    y.rate[i] = ((1.0 + xm) / s)^(1/(i/x.freq)) - 1.0
  end
  y
end


end