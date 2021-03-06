
import FinanceLib as Fl

import FinanceLib.FixedIncomes.MoneyMarkets as MM
import FinanceLib.FixedIncomes as FI

@testset "FinanceLib.FixedIncomes                                     " begin

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


end


include("Bonds/runtests.jl")