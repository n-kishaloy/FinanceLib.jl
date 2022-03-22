println("\n\n\nPerformance of FinanceLib.FixedIncomes.Bonds functions")

import FinanceLib.FixedIncomes.Bonds as Bd

@code_warntype Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 

println("Coupon bond")
@code_warntype Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 

rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
@code_warntype Bd.ytmCoupleBonds(rS, 0.1)

println("Benchmarks\n")

