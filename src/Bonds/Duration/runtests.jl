

import FinanceLib.Bonds.Duration as Du

@testset "FinanceLib.Bonds.Duration       " begin
  
  @testset "Duration" begin 

    @test Du.mcDuration() == 0


  end



end