println("\n\n\nPerformance of FinanceLib.FixedIncomes functions")

using Dates: Date
using FinanceLib: yearFrac

import FinanceLib.FixedIncomes.Rates as Rt


println("Benchmarks\n")

println("\n\n\nPerformance of FinanceLib.FixedIncomes functions")

@code_warntype Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])


include("Bonds/perf.jl")