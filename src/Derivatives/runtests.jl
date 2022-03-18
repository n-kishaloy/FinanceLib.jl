

import FinanceLib.Derivatives.Forwards as Fd
using Dates: Date
using FinanceLib: yearFrac

@testset "FinanceLib.Derivatives.Forwards                             " begin
  
  fw = Fd.Forward_S0(r = 0.03, T = 0.25, S0 = 50, benf = -1)
  @test fw.FT == 51.37827066066438
  @test Fd.getS0(fw) == 50.0
  @test Fd.valuation(fw, 52, 1/12) == 1.8766865113848255

  fw = Fd.Forward_S0(r = 0.03, T = 0.25, S0 = 50)
  @test fw.FT == 50.370853588886646
  @test Fd.getS0(fw) == 50.0

  T0 = Date(2015,10,5)
  T1 = Date(2016,1,8)
  TX = yearFrac(T0, T1)

  @test TX == 0.2600958247775496

  fw = Fd.Forward_S0(r = 0.03, T = TX, S0 = 50, benf = -1)
  # println(fw)

  dw = Fd.XForward_S0(r = 0.03, T0 = T0, T = T1, S0 = 50, benf = -1.0)
  # println(dw)

  @test fw.FT == dw.FT
  @test Fd.getS0(fw) == Fd.getS0(dw)

  TM = Date(2015, 12, 18)
  TZ = yearFrac(T0, TM) 
  # println(TZ)

  @test Fd.valuation(fw, 55, TZ) == Fd.valuation(dw, 55, TM)

end

import FinanceLib.Derivatives.Options as Op

@testset "FinanceLib.Derivatives.Options                              " begin

  ct = Op.Call(2_000, 81.75)

  @test Op.valuation(ct, ST = 1_900) == 0.0
  @test Op.profit(ct, ST = 1_900) == -81.75

  @test Op.valuation(ct, ST = 2_100) == 100.0
  @test Op.profit(ct, ST = 2_100) == 18.25

  pt = Op.Put(2_000, 79.25)

  @test Op.valuation(pt, ST = 1_900) == 100.0
  @test Op.profit(pt, ST = 1_900) == 20.75

  @test Op.valuation(pt, ST = 2_100) == 0.0
  @test Op.profit(pt, ST = 2_100) == -79.25

  cv = Op.CoveredCall(98, Op.Call(105, 8))

  @test Op.valuation(cv, ST = 110) == 105
  @test Op.profit(cv, ST = 110) == 15

  @test Op.valuation(cv, ST = 88) == 88
  @test Op.profit(cv, ST = 88) == -2

  pt = Op.ProtectivePut(0.875, Op.Put(0.90, 0.075))

  @test Op.valuation(pt, ST = 0.96) == 0.96
  @test Op.profit(pt, ST = 0.96) ≈ 0.01

  @test Op.valuation(pt, ST = 0.75) == 0.90
  @test Op.profit(pt, ST = 0.75) ≈ -0.05

end