module MoneyMarket

tBillR(t, P0, F) = (1.0 - P0/F) * 360.0/t
tBillD(r, t, F) = r*t*F/360.0

holdingPerYield(P0, P1, D1) = (P1+D1)/P0 - 1.0
effAnnYield(t, P0, P1, D1) = ((P1+D1)/P0)^(365/t) - 1.0
moneyMktYield(t, P0, P1, D1) = ((P1+D1)/P0 - 1.0)*360/t

function twrr(bv, b_inf)
  n = length(bv)-1; r = 1.0
  for i in 1:n r *= bv[i+1]/(bv[i]+b_inf[i]) end
  r^(1/n) - 1.0
end

function twrr(n, bv, b_inf)
  r = 1.0
  for i in 1:(length(bv)-1) r *= bv[i+1]/(bv[i]+b_inf[i]) end
  r^(1/n) - 1.0
end









end 