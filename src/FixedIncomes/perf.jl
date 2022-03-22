println("\n\n\nPerformance of FinanceLib.FixedIncomes functions")

using Dates: Date
using FinanceLib: yearFrac

import FinanceLib as Fl

import FinanceLib.FixedIncomes as FI
import FinanceLib.FixedIncomes.MoneyMarkets as MM





println("\n\n\nPerformance of FinanceLib.FixedIncomes functions")

@code_warntype MM.tBillR(150,98000,100000)
@code_warntype MM.tBillD(0.048, 150, 100_000) 

@code_warntype MM.holdingPerYield(98, 95, 5) 
@code_warntype MM.effAnnYield(150, 98, 95, 5) 
@code_warntype MM.moneyMktYield(150, 98, 95, 5) 

@code_warntype MM.twrr([4,6,5.775,6.72,5.508],[1,-0.5,0.225,-0.6]) 
@code_warntype MM.twrr(1.0, [100, 112, 142.64], [0, 20.])



println("Benchmarks\n")



include("Bonds/perf.jl")