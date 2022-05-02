println("\n\n\nPerformance of FinanceLib.Statements functions")

import FinanceLib.Statements as St


@code_warntype St.createCalcSets(St.balanceSheetCalcMap)
@code_warntype St.createCalcSets(St.profitLossCalcMap)

println(St.balanceSheetCalcItems)
println(St.balanceSheetEntries)

println(St.profitLossCalcItems)
println(St.profitLossEntries)

println(St.BsDict(St.Cash => 5.0), St.CfDict(St.ChangeInventories => 2.5))

println("Benchmarks\n")

abra(x::T) where T <: Union{Int64, Float64} =  2x

function abra(x) 
  "Not here"
  
end

@code_warntype abra(5)

println(abra("a"))