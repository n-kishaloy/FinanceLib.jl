
import FinanceLib as Fl

import FinanceLib.FixedIncomes as FI
import FinanceLib.FixedIncomes.Rates as Rt

@testset "FinanceLib.FixedIncomes                                     " begin

  @test FI.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10)]), 0.06) * 1000 == 931.0789294108725

  
  @test FI.priceCouponBond(Fl.PeriodSeries([(1, 0.09), (2, 0.10), (3, 0.11)]), 0.05) * 100 == 85.49448240486119

end


@testset "FinanceLib.FixedIncomes.Rates                               " begin
  
  @test Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])[4][2] ≈ 0.08002666689660898


end

include("Bonds/runtests.jl")