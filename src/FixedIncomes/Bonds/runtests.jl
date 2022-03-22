
import FinanceLib.FixedIncomes.Bonds as Bd

import FinanceLib.FixedIncomes.Bonds.MoneyMarket as MM

@testset "FinanceLib.FixedIncomes.Bonds                               " begin
  
  @testset "MoneyMarkets" begin 
    @test MM.tBillR(150,98_000,100_000) ≈ 0.048
    @test MM.tBillD(0.048, 150, 100_000) == 2_000

    @test MM.holdingPerYield(98, 95, 5) == 0.020408163265306145
    @test MM.effAnnYield(150, 98, 95, 5) == 0.05038831660532006
    @test MM.moneyMktYield(150, 98, 95, 5) == 0.04897959183673475

    @test MM.twrr([4,6,5.775,6.72,5.508],[1,-0.5,0.225,-0.6]) == 
    0.06159232319186159
    @test MM.twrr(1.0, [100, 112, 142.64], [0, 20.])==0.21027878787878795


  end

    @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 == 931.0789294108725
    @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 == 85.49448240486119

    rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
    bd = Bd.priceCouponBond(rS, 0.1)*100
    @test bd == 105.42950371364294

    @test Bd.ytmCoupleBonds(rS, 0.1) == 0.0861792633877846

end

