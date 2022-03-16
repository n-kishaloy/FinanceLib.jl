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

callT(;ST, X)  = max(0, ST - X)
putT(;ST, X)   = max(0, X - ST)




end