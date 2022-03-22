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
`parToSpotRates(x) = Convert Spot rates to Par rates`

* x = Vector of Tuples (period as Float64, rate as Float64)
"""
function parToSpotRates(x)
  n = length(x); y = Vector{Tuple{Float64,Float64}}(undef, n); 
  y[1] = x[1]; d = x[2][1] - x[1][1]
  for i ∈ 2:n
    s = 1.0; for k ∈ 1:(i-1) s = s - x[i][2]*d/(1+y[k][2])^x[k][1] end
    y[i] = (x[i][1], ((1 + d*x[i][2])/s)^(1/x[i][1]) - 1.0 )
  end
  y
end 


end