println("\n\n\nPerformance of FinanceLib.FixedIncomes functions")

using Dates: Date
using FinanceLib: yearFrac

import FinanceLib as Fl

import FinanceLib.FixedIncomes as FI
import FinanceLib.FixedIncomes.Rates as Rt


println("\n\n\nPerformance of FinanceLib.FixedIncomes functions")

@code_warntype Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])


println("Benchmarks\n")



include("Bonds/perf.jl")