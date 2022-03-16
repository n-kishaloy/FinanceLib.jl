println("\n\n\nPerformance of FinanceLib.Derivatives.Forwards functions")

import FinanceLib.Derivatives.Forwards as Fd
using Dates: Date
using FinanceLib: yearFrac

fw = Fd.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
@code_warntype Fd.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
@code_warntype fw.FT 
@code_warntype Fd.getS0(fw) 
@code_warntype Fd.valuation(fw, 52, 1/12) 


fw = Fd.Forward_S0(r = 0.03, T = 0.25, S0 = 50)
@code_warntype Fd.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
@code_warntype fw.FT 
@code_warntype Fd.getS0(fw) 

T0 = Date(2015,10,5)
T1 = Date(2016,1,8)
TX = yearFrac(T0, T1)

fw = Fd.Forward_S0(r = 0.03, T = TX, S0 = 50, benf = -1)
# println(fw)

dw = Fd.XForward_S0(r = 0.03, T0 = T0, T = T1, S0 = 50, benf = -1.0)
# println(dw)

@code_warntype Fd.getS0(dw)

TM = Date(2015, 12, 18)
TZ = yearFrac(T0, TM) 
# println(TZ)

@code_warntype Fd.valuation(fw, 55, TZ) 
@code_warntype Fd.valuation(dw, 55, TM)


println("Benchmarks\n")

println("\n\n\nPerformance of FinanceLib.Derivatives.Options functions")

import FinanceLib.Derivatives.Options as Op


println("Benchmarks\n")
