
import FinanceLib.FixedIncomes.Bonds as Bd
import FinanceLib.FixedIncomes.Bonds.Rates as Rt
import FinanceLib as Fl

@testset "FinanceLib.FixedIncomes.Bonds                               " begin
  

    # @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 == 931.0789294108725
    # @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 == 85.49448240486119

    @test Bd.priceCouponBond(0.03, Bd.CouponBond(0.05, 2, 3)) == 1.0569718716547531

    @test Bd.priceCouponBond(Fl.RateCurve([0.0016, 0.0021, 0.0027, 0.0033, 0.0037,    0.0041],2), Bd.CouponBond(0.05, 2, 3)) == 1.1369147941993403

    @test Bd.ytmCouponBond(Bd.CouponBond(0.05, 2, 3), 1.1369147941993403) == 0.004038639185260929

    # rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
    # bd = Bd.priceCouponBond(rS, 0.1)*100
    # @test bd == 105.42950371364294
    # @test Bd.ytmCouponBond(rS, 0.1) == 0.0861792633877846

    @testset "FinanceLib.FixedIncomes.Bonds.Rates                     " begin
  
      @test Rt.parToSpotRates(Fl.RateCurve([0.05, 0.0597, 0.0691, 0.0781], 1)).rate[4] ≈ 0.08002666689660898 


      er = Rt.parToSpotRates(Fl.RateCurve([0.020000, 0.024000, 0.027600, 0.030840, 0.033756, 0.036380], 2)).rate

      er[1] ≈ 0.02
      er[4] ≈ 0.030974
      er[5] ≈ 0.033975
      er[6] ≈ 0.036701

      et = Rt.spotToParRates(Fl.RateCurve(er, 2)).rate 

      @test et[3] ≈ 0.027600
      @test et[4] ≈ 0.030840
      @test et[6] ≈ 0.036380
  

    end
    
  

end

