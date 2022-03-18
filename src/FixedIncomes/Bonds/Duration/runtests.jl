

import FinanceLib.FixedIncomes.Bonds.Duration as Du

@testset "FinanceLib.FixedIncomes.Bonds.Duration       " begin
  
  @testset "Duration" begin 

    @test Du.mcDuration() == 0


  end



end