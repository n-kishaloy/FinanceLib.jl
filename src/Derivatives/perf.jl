println("\n\n\nPerformance of FinanceLib.Derivatives functions")

import FinanceLib.Derivatives as Dv

fw = Dv.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
@code_warntype Dv.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
@code_warntype fw.FT 
@code_warntype Dv.getS0(fw) 
@code_warntype Dv.valForward(fw, 52, 1/12) 


fw = Dv.Forward_S0(r = 0.03, T = 0.25, S0 = 50)
@code_warntype Dv.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
@code_warntype fw.FT 
@code_warntype Dv.getS0(fw) 


println("Benchmanrks\n")


