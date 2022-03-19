

import FinanceLib.FixedIncomes as FI
import FinanceLib.FixedIncomes.Rates as Rt

@testset "FinanceLib.FixedIncomes                                     " begin
  

end


@testset "FinanceLib.FixedIncomes.Rates                               " begin
  
  @test Rt.parToSpotRates([(1,0.05), (2,0.0597), (3, 0.0691), (4, 0.0781)])[4][2] ≈ 0.08002666689660898


end

include("Bonds/runtests.jl")