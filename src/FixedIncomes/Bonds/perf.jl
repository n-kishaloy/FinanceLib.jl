println("\n\n\nPerformance of FinanceLib.FixedIncomes.Bonds functions")

import FinanceLib.FixedIncomes.Bonds.MoneyMarket as MM
import FinanceLib.FixedIncomes.Bonds as Bd

@code_warntype MM.tBillR(150,98000,100000)
@code_warntype MM.tBillD(0.048, 150, 100_000) 

@code_warntype MM.holdingPerYield(98, 95, 5) 
@code_warntype MM.effAnnYield(150, 98, 95, 5) 
@code_warntype MM.moneyMktYield(150, 98, 95, 5) 

@code_warntype MM.twrr([4,6,5.775,6.72,5.508],[1,-0.5,0.225,-0.6]) 
@code_warntype MM.twrr(1.0, [100, 112, 142.64], [0, 20.])

@code_warntype Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 

println("Coupon bond")
@code_warntype Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 

rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
@code_warntype Bd.ytmCoupleBonds(rS, 0.1)

println("Benchmarks\n")

# print("tBillR:"); @btime MM.tBillR(150,98000,100000)
