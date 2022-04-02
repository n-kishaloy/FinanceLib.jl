

import FinanceLib
using BenchmarkTools

import Dates

# @code_warntype FinanceLib.tMul(0.06/12, -120.0) 
# @code_warntype FinanceLib.tMul(0.06, -10.0, 12.0) 
# @code_warntype FinanceLib.rateGwth(7.35, 8.52, 5.0) 
# @code_warntype FinanceLib.periodGwth(100.0,50.0,0.07) 

# @code_warntype FinanceLib.pv(10_000_000., 0.09, 5.0) 
# @code_warntype FinanceLib.pv(12_704_891.6109538, 0.06, 4.0, 12.0) 
# @code_warntype FinanceLib.pvc(11_735.108709918102, 0.08, 2.0) 

# @code_warntype FinanceLib.fv(6_499_313.862983453, 0.09, 5.0) 
# @code_warntype FinanceLib.fv(10_000_000.0, 0.06, 4.0, 12.0) 
# @code_warntype FinanceLib.fvc(10_000., 0.08, 2.0) 

# @code_warntype FinanceLib.pvAnnuity(1000.0, 0.12, 5.0) 
# @code_warntype FinanceLib.pvAnnuity(7.33764573879378, 0.08, 30.0, 12.0) 

# @code_warntype FinanceLib.pvAnnuity(100.0, 0.05) 

# @code_warntype FinanceLib.fvAnnuity(1000.0, 0.05, 5.0) 
# @code_warntype FinanceLib.fvAnnuity(2000.0, 0.24, 5.0, 3.0) 

# @code_warntype FinanceLib.pmt(3_604.776202345007, 0.12, 5.0) 
# @code_warntype FinanceLib.pmt(1000.0, 0.08, 30.0, 12.0) 

# @code_warntype FinanceLib.fmt(5_525.631250000007, 0.05, 5.0) 
# @code_warntype FinanceLib.fmt(54_304.2278549568, 0.24, 5.0, 3.0) 

# @code_warntype FinanceLib.pv(FinanceLib.pvAnnuity(10.0^6,.05,30.0),0.05,9.0) 

@code_warntype FinanceLib.effR(0.08, 2.0) 
@code_warntype FinanceLib.nomR(0.08, 4)

@code_warntype FinanceLib.expR(0.08) 

@code_warntype FinanceLib.expR(0.07,4)

# @code_warntype FinanceLib.npv(0.08, [0.25,6.25,3.5,4.5,1.25], 
# [-6.25,1.2,1.25,3.6,2.5], 0.45) 
# @code_warntype FinanceLib.npv(0.08, zip([0.25,6.25,3.5,4.5,1.25], 
# [-6.25,1.2,1.25,3.6,2.5]), 0.45)


# @code_warntype FinanceLib.irr([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25]) 
# @code_warntype FinanceLib.irr(zip([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25])) 

# @code_warntype FinanceLib.yearFrac(Dates.Date(2027,2,12), Dates.Date(2018,2,12)) 
# @code_warntype FinanceLib.invYearFrac(Dates.Date(2027,2,12), -8.999315537303216)

# @code_warntype FinanceLib.xnpv(0.08, [Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
#   Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
#   [-15, 5, 25, -10, 50], Dates.Date(2012,1,10) ) 

# @code_warntype FinanceLib.xnpv(0.08, zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
#   [-15, 5, 25, -10, 50.]), Dates.Date(2012,1,10) ) 

# @code_warntype FinanceLib.xirr([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
#   Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
#   [-115, 5, 25, -10, 200] ) 

# @code_warntype FinanceLib.xirr(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
#   Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
#   [-115, 5, 25, -10, 200]) ) 

# td = collect(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
#   Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
#   [-115, 5, 25, -10, 200]))

# @code_warntype FinanceLib.dateToPeriodSeries(Dates.Date(2010,05,12), td)

# td1 = FinanceLib.dateToPeriodSeries(Dates.Date(2010,05,12), td)

# @code_warntype FinanceLib.irr(td1) 
# @code_warntype FinanceLib.xirr(td) 

# @code_warntype FinanceLib.xirr(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
#   Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
#   [-115, 5, 25, -10, 200]) ) 

# @code_warntype FinanceLib.npv(FinanceLib.PeriodSeries([(0.5,0.05), (1.25, 0.0575), (2, 0.0485), (3.5, 0.0625), (4.25, 0.055)]), [-150, 20, 15, 80, 100], 0.3)

# @code_warntype FinanceLib.xnpv(FinanceLib.DateSeries([(Dates.Date(2014,9,20),0.05), (Dates.Date(2015,2,1), 0.0575), (Dates.Date(2016,10,5), 0.0485), (Dates.Date(2017,12,5), 0.0625), (Dates.Date(2019,1,5), 0.055)]), [-150, 20, 15, 80, 100], Dates.Date(2014,2,15))

rC = FinanceLib.RateCurve{FinanceLib.NomRate}([0.05, 0.06, 0.07, 0.08], 2)

@code_warntype FinanceLib.rateActual(rC, 1.5) 
@code_warntype FinanceLib.rateEstimate(rC, 1.5) 
@code_warntype FinanceLib.rateEstimate(rC, 1.2) 


# println("Benchmarks")

# println("\nNPV")
# tS = collect(zip([0.25,6.25,3.5,4.5,1.25], [-6.25,1.2,1.25,3.6,2.5]))
# print("Separate Vec of tim and cf:"); @btime FinanceLib.npv(0.08, [0.25,6.25,3.5,4.5,1.25], [-6.25,1.2,1.25,3.6,2.5], 0.45) 
# print("Tuple of (tim, cf):"); @btime FinanceLib.npv(0.08, tS, 0.45)

# print("Tuple of (tim, rate), cf:"); @btime FinanceLib.npv(FinanceLib.PeriodSeries([(0.5,0.05), (1.25, 0.0575), (2, 0.0485), (3.5, 0.0625), (4.25, 0.055)]), [-150, 20, 15, 80, 100], 0.3)


# println("\nXNPV")
# tS = collect(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)], [-15, 5, 25, -10, 50.]))

# print("Separate Vec of tim and cf:"); @btime FinanceLib.xnpv(0.08, [Dates.Date(2012,2,25), Dates.Date(2012,6,28), Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)], [-15, 5, 25, -10, 50], Dates.Date(2012,1,10) ) 

# print("Tuple of (tim, cf):"); @btime FinanceLib.xnpv(0.08, tS, Dates.Date(2012,1,10) ) 

# print("Tuple of (tim, rate), cf:"); @btime FinanceLib.xnpv(FinanceLib.DateSeries([(Dates.Date(2014,9,20),0.05), (Dates.Date(2015,2,1), 0.0575), (Dates.Date(2016,10,5), 0.0485), (Dates.Date(2017,12,5), 0.0625), (Dates.Date(2019,1,5), 0.055)]), [-150, 20, 15, 80, 100], Dates.Date(2014,2,15))

# println("\nIRR")
# tS = collect(zip([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25]))

# print("Separate Vec of tim and cf:"); @btime FinanceLib.irr([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25]) 
# print("Tuple of (tim, cf):"); @btime FinanceLib.irr(tS)

# println("\nXIRR")
# tS = collect(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],[-115, 5, 25, -10, 200]))

# print("Separate Vec of tim and cf:"); @btime FinanceLib.xirr([Dates.Date(2012,2,25), Dates.Date(2012,6,28), Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)], [-115, 5, 25, -10, 200] ) 
# print("Tuple of (tim, cf):"); @btime FinanceLib.xirr(tS) 

@btime FinanceLib.rateActual(rC, 1.5) 
@btime FinanceLib.rateEstimate(rC, 1.5) 
@btime FinanceLib.rateEstimate(rC, 1.2) 


include("FixedIncomes/perf.jl")
# include("Derivatives/perf.jl")


