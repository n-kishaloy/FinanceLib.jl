"""
```
Module      : FinanceLib.Statements
Description : Implement Statements modules for the FinanceLib library
Copyright   : (c) 2022 Kishaloy Neogi
License     : MIT
Maintainer  : Kishaloy Neogi
Email       : nkishaloy@yahoo.com
```
The module describes the base modules of Statements. These includes Balance Sheets, 
Income Statements and Cash Flow Statements and their utiities. 


You may see the github repository at <https://github.com/n-kishaloy/FinanceLib.jl>
"""
module Statements

using Chain: @chain

balanceSheetCalcMap = 
  [ 
    (:Inventories, 
    [:RawMaterials, :WorkInProgress, :FinishedGoods],
    Symbol[]
    )
  , (:CurrentAssets,
    [:Cash, :CurrentReceivables, :CurrentLoans, :CurrentAdvances, :OtherCurrentAssets, :CurrentInvestments, :Inventories],
    Symbol[]
    )
  , (:NetPlantPropertyEquipment,
    [:PlantPropertyEquipment],
    [:AccumulatedDepreciation]
    )
  , (:NetLeaseRentalAssets,
    [:LeasingRentalAssets],
    [:AccumulatedAmortizationLeaseRental]
    )
  , (:NetIntangibleAssets,
    [:IntangibleAssets, :IntangibleAssetsDevelopment],
    [:AccumulatedAmortization]
    )
  , (:LongTermAssets,
    [:AccountReceivables, :LongTermLoanAssets, :LongTermAdvances, :LongTermInvestments, :OtherLongTermAssets, :NetPlantPropertyEquipment, :NetLeaseRentalAssets, :Goodwill, :CapitalWip, :OtherTangibleAssets, :NetIntangibleAssets],
    Symbol[]
    )
  , (:Assets,
    [:CurrentAssets, :LongTermAssets],
    Symbol[]
    )
  , (:CurrentLiabilities,
    [:CurrentPayables, :CurrentBorrowings, :CurrentNotesPayable, :OtherCurrentLiabilities, :InterestPayable, :CurrentProvisions, :CurrentTaxPayables, :LiabilitiesSaleAssets, :CurrentLeasesLiability],
    Symbol[]
    )
  , (:LongTermLiabilities,
    [:AccountPayables, :LongTermBorrowings, :BondsPayable, :DeferredTaxLiabilities, :LongTermLeasesLiability, :DeferredCompensation, :DeferredRevenues, :CustomerDeposits, :OtherLongTermLiabilities, :PensionProvision, :TaxProvision, :LongTermProvision],
    Symbol[]
    )
  , (:Liabilities,
    [:CurrentLiabilities, :LongTermLiabilities],
    Symbol[]
    )
  , (:Equity,
    [:CommonStock, :PreferredStock, :PdInCapAbovePar, :PdInCapTreasuryStock, :RevaluationReserves, :Reserves, :RetainedEarnings, :AccumulatedOci, :MinorityInterests],
    Symbol[] 
    )

  ] :: Vector{Tuple{Symbol, Vector{Symbol}, Vector{Symbol}}}

profitLossCalcMap = 
  [ (:Revenue,
    [:OperatingRevenue, :NonOperatingRevenue],
    [:ExciseStaxLevy]
  )
  , (:COGS,
    [:CostMaterial, :DirectExpenses],
    Symbol[]
  )
  , (:GrossProfit,
    [:Revenue],
    [:COGS]
  )
  , (:Pbitda,
    [:GrossProfit, :OtherIncome],
    [:Salaries, :AdministrativeExpenses, :ResearchNDevelopment, :OtherOverheads, :OtherOperativeExpenses, :OtherExpenses, :ExceptionalItems]
  )
  , (:Pbitx,
    [:Pbitda],
    [:Depreciation, :AssetImpairment, :LossDivestitures, :Amortization]
  )
  , (:Pbtx,
    [:Pbitx, :InterestRevenue, :OtherFinancialRevenue],
    [:InterestExpense, :CostDebt]
  )
  , (:Pbt,
    [:Pbtx],
    [:ExtraordinaryItems, :PriorYears]
  )
  , (:Pat,
    [:Pbt],
    [:TaxesCurrent, :TaxesDeferred]
  )
  , (:OtherComprehensiveIncome,
    [:GainsLossesForex, :GainsLossesActurial, :GainsLossesSales, :FvChangeAvlSale],
    [:OtherDeferredTaxes]
  )
  , (:TotalComprehensiveIncome,
    [:Pat, :OtherComprehensiveIncome],
    Symbol[]
  )
  ] :: Vector{Tuple{Symbol, Vector{Symbol}, Vector{Symbol}}}

# cashFlowCalcMap = 



function createCalcMaps(bM)
  bCl = [x for (x, _, _) ∈ bM] :: Vector{Symbol}
  bE = mapreduce( ((x,y,z),) -> (y...,z...), 
      (z,y) -> [z...,filter(x -> x ∉ bCl , y)...] :: Vector{Symbol}, bM , init = Symbol[]  ) 
  bCl, bE
end

balanceSheetCalcItems, balanceSheetEntries = createCalcMaps(balanceSheetCalcMap)
profitLossCalcItems, profitLossEntries = createCalcMaps(profitLossCalcMap)





end