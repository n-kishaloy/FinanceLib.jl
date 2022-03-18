"""
```
Module      : FinanceLib.Derivatives.Options
Description : Implement Derivatives modules for the FinanceLib library
Copyright   : (c) 2022 Kishaloy Neogi
License     : MIT
Maintainer  : Kishaloy Neogi
Email       : nkishaloy@yahoo.com
```
The module describes the base modules of Options Derivatives. 


You may see the github repository at <https://github.com/n-kishaloy/FinanceLib.jl>
"""
module Options 

using Dates: Date
using FinanceLib: yearFrac

"""
```
Call
X     # Exercise price
price # Price of option
```
"""
struct Call
  X     :: Float64  # Exercise price
  price :: Float64  # Price of option
end

"""
```
Put
  X     # Execise price
  price # Price of option
```
"""
struct Put
  X     :: Float64  # Execise price
  price :: Float64  # Price of option
end

valuation(c :: Call; ST)  = max(0, ST - c.X)
valuation(p :: Put ; ST)  = max(0, p.X - ST)

profit(x; ST) = valuation(x; ST = ST) - x.price

breakeven(c :: Call) = c.X + c.price
breakeven(p :: Put)  = p.X - p.price

"""
```
CoveredCall = Stock - Call 
  S0    # Stock value @ S₀
  call  # Call 
``` 
"""
struct CoveredCall 
  S0    :: Float64  # Stock value @ S₀
  call  :: Call     # Call 
end 

"""
```
ProtectivePut = Stock + Put
  S0    # Stock value @ S₀
  put   # Put 
```
"""
struct ProtectivePut
  S0    :: Float64  # Stock value @ S₀
  put   :: Put      # Put 
end 

valuation(cv :: CoveredCall; ST) = min(ST, cv.call.X)
valuation(pv :: ProtectivePut; ST) = max(ST, pv.put.X)

profit(x :: CoveredCall; ST) = valuation(x, ST = ST) - x.S0 + x.call.price  
profit(x :: ProtectivePut; ST) = valuation(x, ST = ST) - x.S0 - x.put.price  

breakeven(cv :: CoveredCall) = cv.S0 - cv.call.price
breakeven(pt :: ProtectivePut) = pt.S0 + pt.put.price

end