
import FinanceLib.FixedIncomes.Bonds as Bd
import FinanceLib.FixedIncomes.Bonds.Rates as Rt


@testset "FinanceLib.FixedIncomes.Bonds                               " begin
  

    @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 == 931.0789294108725
    @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 == 85.49448240486119

    @test Bd.priceCouponBond(0.07, Bd.CouponBond(0.05, 2, 3)) == 0.9497711186125141

    @test Bd.priceCouponBond(Rt.RateCurve([0.05, 0.055, 0.06, 0.07, 0.075, 0.085],2), Bd.CouponBond(0.05, 2, 3)) == 0.916183660871172

    @test Bd.ytmCouponBond(Bd.CouponBond(0.05, 2, 3), 0.916183660871172) == 0.0837711782111691

    rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
    bd = Bd.priceCouponBond(rS, 0.1)*100
    @test bd == 105.42950371364294

    @test Bd.ytmCouponBond(rS, 0.1) == 0.0861792633877846

    @testset "FinanceLib.FixedIncomes.Bonds.Rates                     " begin
  
      @test Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])[4][2] ≈ 0.08002666689660898

      @test Rt.parToSpotRates(Rt.RateCurve([0.05, 0.0597, 0.0691, 0.0781], 1)).rate[4] ≈ 0.08002666689660898 
    
    end
    
  

end

