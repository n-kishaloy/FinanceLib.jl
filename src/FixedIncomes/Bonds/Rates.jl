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
`parToSpotRates(x) = Convert par rates to spot rates`

* x = RateCurve of par rates
"""
function parToSpotRates(x :: Fl.RateCurve)
  n = length(x.rate); y = Fl.RateCurve(Vector{Float64}(undef, n), x.freq)
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
spotToParRates(x::Fl.RateCurve) = Fl.RateCurve(1:length(x.rate) .|> i -> x.freq*(1-1/(1+x.rate[i]/x.freq)^i)/sum((k -> 1/(1 + x.rate[k]/x.freq)^k).(1:i)), x.freq)



end