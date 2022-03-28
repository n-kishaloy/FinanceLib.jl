
import FinanceLib.FixedIncomes.Bonds as Bd
import FinanceLib.FixedIncomes.Bonds.Rates as Rt


@testset "FinanceLib.FixedIncomes.Bonds                               " begin
  

    # @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 == 931.0789294108725
    # @test Bd.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 == 85.49448240486119

    @test Bd.priceCouponBond(0.03, Bd.CouponBond(0.05, 2, 3)) == 1.0569718716547531

    @test Bd.priceCouponBond(Rt.RateCurve([0.0016, 0.0021, 0.0027, 0.0033, 0.0037,    0.0041],2), Bd.CouponBond(0.05, 2, 3)) == 1.1369147941993403

    @test Bd.ytmCouponBond(Bd.CouponBond(0.05, 2, 3), 1.1369147941993403) == 0.004038639185260929

    # rS = Fl.PeriodSeries([(1, 0.05), (2, 0.06), (3, 0.07), (4, 0.08), (5, 0.09)])
    # bd = Bd.priceCouponBond(rS, 0.1)*100
    # @test bd == 105.42950371364294
    # @test Bd.ytmCouponBond(rS, 0.1) == 0.0861792633877846

    @testset "FinanceLib.FixedIncomes.Bonds.Rates                     " begin
  
      @test Rt.parToSpotRates(Rt.RateCurve([0.05, 0.0597, 0.0691, 0.0781], 1)).rate[4] ≈ 0.08002666689660898 

      @test Rt.discFactorToSpotRate(Rt.DiscountFactor([0.9524, 0.89, 0.8163, 0.735],1)).rate[3] == 0.0699990723472752

      dsc = Rt.discFactorToSpotRate(Rt.DiscountFactor([ 0.99920063949, 0.99790330288, 
      0.99596091045, 0.99342713542, 0.99080111671, 0.98778777227 ],2)).rate

      @test dsc[1] ≈ 0.0016
      @test dsc[2] ≈ 0.0021
      @test dsc[3] ≈ 0.0027
      @test dsc[4] ≈ 0.0033
      @test dsc[5] ≈ 0.0037
      @test dsc[6] ≈ 0.0041

      er = Rt.parToSpotRates(Rt.RateCurve([0.020000, 0.024000, 0.027600, 0.030840, 0.033756, 0.036380], 2)).rate

      er[1] ≈ 0.02
      er[4] ≈ 0.030974
      er[5] ≈ 0.033975
      er[6] ≈ 0.036701

      et = Rt.spotToParRates(Rt.RateCurve(er, 2)).rate 

      @test et[3] ≈ 0.027600
      @test et[4] ≈ 0.030840
      @test et[6] ≈ 0.036380
  
      @test Rt.rate(Rt.RateCurve([0.05, 0.06, 0.07, 0.08], 2), 1.5) == 0.07
      @test Rt.rateEst(Rt.RateCurve([0.05, 0.06, 0.07, 0.08], 2), 1.5) == 0.07
      @test Rt.rateEst(Rt.RateCurve([0.05, 0.06, 0.07, 0.08], 2), 1.2) == 0.064

    end
    
  

end

