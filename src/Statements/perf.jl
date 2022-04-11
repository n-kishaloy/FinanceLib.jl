println("\n\n\nPerformance of FinanceLib.Statements functions")

import FinanceLib.Statements as St


@code_warntype St.createCalcMaps(St.balanceSheetCalcMap)
@code_warntype St.createCalcMaps(St.profitLossCalcMap)

println(St.balanceSheetCalcItems)
println(St.balanceSheetEntries)

println(St.profitLossCalcItems)
println(St.profitLossEntries)

println(St.BsDict(St.Cash => 5.0), St.CfDict(St.ChangeInventories => 2.5))

println("Benchmarks\n")
