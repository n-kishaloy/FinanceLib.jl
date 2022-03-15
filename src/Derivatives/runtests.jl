

import FinanceLib.Derivatives as Dv

@testset "FinanceLib.Derivatives    " begin
  
  fw = Dv.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
  @test fw.FT == 51.37827066066438
  @test Dv.getS0(fw) == 50.0
  @test Dv.valForward(fw, 52, 1/12) == 1.8766865113848255

  fw = Dv.Forward_S0(r = 0.03, T = 0.25, S0 = 50)
  @test fw.FT == 50.370853588886646
  @test Dv.getS0(fw) == 50.0

end