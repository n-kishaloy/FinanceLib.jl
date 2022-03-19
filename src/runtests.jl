import FinanceLib
import Dates

@testset "FinanceLib                                                  " begin

  @testset "tv" begin
    @test FinanceLib.yearFrac(Dates.Date(2027,2,12), Dates.Date(2018,2,12)) ≈ -8.999315537303216

    @test FinanceLib.disFactAnnual(0.07) == 0.9345794392523364
    @test FinanceLib.disFact(0.09, 3) == 0.7721834800610642 
    @test FinanceLib.fwdDisFact((0.07, 1), (0.09, 3)) == 0.8262363236653387


    @test FinanceLib.xdisFact(0.09, Dates.Date(2015,3,15), Dates.Date(2018,10,8)) == 0.7353328680759499

    @test FinanceLib.tMul(0.06/12, -120.0) == 0.5496327333641637
    @test FinanceLib.tMul(0.06, -10.0, 12.0) == 0.5496327333641637
    @test FinanceLib.rate(7.35, 8.52, 5.0) == -0.029111071029244595
    @test FinanceLib.period(100.0,50.0,0.07) == 10.244768351058712

  end

  @testset "pv" begin
    @test FinanceLib.pv(10_000_000., 0.09, 5.0) == 6_499_313.862983453
    @test FinanceLib.pv(12_704_891.6109538, 0.06, 4.0, 12.0) ≈ 10_000_000. 
    @test FinanceLib.pvr(10_000_000., 1.09, 5.0) == 6_499_313.862983453
    @test FinanceLib.pvc(11_735.108709918102, 0.08, 2.0) == 10_000
  end

  @testset "fv" begin
    @test FinanceLib.fv(6_499_313.862983453, 0.09, 5.0) == 10_000_000.0
    @test FinanceLib.fv(10_000_000.0, 0.06, 4.0, 12.0) ≈ 12_704_891.6109538
    @test FinanceLib.fvc(10_000., 0.08, 2.0) == 11_735.108709918102
  end

  @testset "annuity" begin
    @test FinanceLib.pvAnnuity(1000.0, 0.12, 5.0) == 3_604.776202345007
    @test FinanceLib.pvAnnuity(7.33764573879378, 0.08, 30.0, 12.0) == 1000

    @test FinanceLib.pvAnnuity(100.0, 0.05) == 2000.0
    
    @test FinanceLib.fvAnnuity(1000.0, 0.05, 5.0) == 5_525.631250000007
    @test FinanceLib.fvAnnuity(2000.0, 0.24, 5.0, 3.0) == 54_304.2278549568

    @test FinanceLib.pmt(3_604.776202345007, 0.12, 5.0) == 1000.0
    @test FinanceLib.pmt(1000.0, 0.08, 30.0, 12.0) == 7.33764573879378

    @test FinanceLib.fmt(5_525.631250000007, 0.05, 5.0) == 1000
    @test FinanceLib.fmt(54_304.2278549568, 0.24, 5.0, 3.0) == 2000

    @test FinanceLib.pv(FinanceLib.pvAnnuity(10.0^6,.05,30.0),0.05,9.0) == 9_909_218.99605011
  end

  @testset "effective rates" begin
    @test FinanceLib.effRate(0.08, 2.0) ≈ 0.0816
    @test FinanceLib.effRateCont(0.08) == 0.08328706767495864
    
  end

  @testset "npv" begin
    @test FinanceLib.npv(0.05, [0.0:1.0:4.0;],[1000.,2000.0,4000.0,5000.0,6000.0],-1.45)==14709.923338335731
    @test FinanceLib.npv(0.08, [0.25,6.25,3.5,4.5,1.25], [-6.25,1.2,1.25,3.6,2.5], -0.45) == 0.36962283798505946
    @test FinanceLib.npv(0.08, zip([0.25,6.25,3.5,4.5,1.25],[-6.25,1.2,1.25,3.6,2.5]), -0.45) == 0.36962283798505946
    @test FinanceLib.npv(0.08, [0.25,6.25,3.5,4.5,1.25], [-6.25,1.2,1.25,3.6,2.5], 6.25) == 0.619010419015909

    @test FinanceLib.irr([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25]) ≈ 0.31813386476788824

    ts = collect(zip([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25])) :: FinanceLib.PeriodSeries

    @test FinanceLib.irr(ts) ≈ 0.31813386476788824

    @test FinanceLib.irr(zip([0.125,0.29760274,0.49760274,0.55239726,0.812671233], [-10.25,-2.5,3.5,9.5,1.25])) ≈ 0.31813386476788824

    @test FinanceLib.xnpv(0.08, [Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
      Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
      [-15, 5, 25, -10, 50], Dates.Date(2012,1,10) ) ==  44.15557928534869

    @test FinanceLib.xnpv(0.08, zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
      Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
      [-15, 5, 25, -10, 50.]), Dates.Date(2012,1,10) ) ==  44.15557928534869

    @test FinanceLib.xirr([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
      Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
      [-115, 5, 25, -10, 200] ) ==  0.2783166029306355

    td = collect(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
    Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
    [-115, 5, 25, -10, 200]))
    
    td1 = FinanceLib.dateToPeriodSeries(Dates.Date(2010,05,12), td)
    @test td1[3][1] == 2.7652292950034223 

    @test FinanceLib.irr(td1) ==  0.2783166029306353
    @test FinanceLib.xirr(td) ==  0.2783166029306355

    @test FinanceLib.xirr(zip([Dates.Date(2012,2,25), Dates.Date(2012,6,28), 
      Dates.Date(2013,2,15), Dates.Date(2014,9,18), Dates.Date(2015,2,20)],
      [-115, 5, 25, -10, 200]) ) ==  0.2783166029306355

    @test FinanceLib.npv(FinanceLib.PeriodSeries([(0.5,0.05), (1.25, 0.0575), (2, 0.0485), (3.5, 0.0625), (4.25, 0.055)]), [-150, 20, 15, 80, 100], 0.3) == 31.530253870718543

    @test FinanceLib.xnpv(FinanceLib.DateSeries([(Dates.Date(2014,9,20),0.05), (Dates.Date(2015,2,1), 0.0575), (Dates.Date(2016,10,5), 0.0485), (Dates.Date(2017,12,5), 0.0625), (Dates.Date(2019,1,5), 0.055)]), [-150, 20, 15, 80, 100], Dates.Date(2014,2,15)) ==  29.323165765999597 


  end




  @testset "Sharpe" begin
    @test FinanceLib.sharpe(1.58,9.26,22.36) ≈ 0.3434704830053667 
  end

end

include("FixedIncomes/runtests.jl")
include("Derivatives/runtests.jl")
