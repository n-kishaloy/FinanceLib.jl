println("\n\n\nPerformance of FinanceLib.FixedIncomes.Bonds functions")

import FinanceLib.FixedIncomes.Bonds as Bd
import FinanceLib.FixedIncomes.Bonds.Rates as Rt

@code_warntype Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 

println("Coupon bond")
@code_warntype Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 

rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
@code_warntype Bd.ytmCouponBond(rS, 0.1)


# @code_warntype Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])

@code_warntype Rt.parToSpotRates(Rt.RateCurve([0.05, 0.0597, 0.0691, 0.0781], 1))

@code_warntype Rt.parToSpotRates(Rt.spotToParRates(Rt.RateCurve([0.05, 0.06, 0.07, 0.08], 2))).rate[3] 



@code_warntype Bd.priceCouponBond(0.07, Bd.CouponBond(0.05, 2, 3))

@code_warntype Bd.priceCouponBond(Rt.RateCurve([0.05, 0.055, 0.06, 0.07, 0.075, 0.085],2), Bd.CouponBond(0.05, 2, 3))

@code_warntype Bd.ytmCouponBond(Bd.CouponBond(0.05, 2, 3), 0.916183660871172)

rC = Rt.RateCurve([0.05, 0.06, 0.07, 0.08], 2)

@code_warntype Rt.rate(rC, 1.5) 
@code_warntype Rt.rateEst(rC, 1.5) 
@code_warntype Rt.rateEst(rC, 1.2) 


println("Benchmarks\n")

# @btime Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 

# @btime Bd.ytmCouponBond(Bd.Bond(0.05, 2, 3), 0.916183660871172)

# @btime Bd.ytmCouponBond(rS, 0.1)

# @btime Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])

# rx = Rt.RateCurve([0.05, 0.0597, 0.0691, 0.0781], 1)

# @btime Rt.parToSpotRates(rx)

# @btime Rt.rate(rC, 1.5) 
# @btime Rt.rateEst(rC, 1.5) 
# @btime Rt.rateEst(rC, 1.2) 

