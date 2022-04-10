"""
```
Module       FinanceLib.Statements
Description  Implement Statements modules for the FinanceLib library
Copyright    (c) 2022 Kishaloy Neogi
License      MIT
Maintainer   Kishaloy Neogi
Email        nkishaloy@yahoo.com
```
The module describes the base modules of Statements. These includes Balance Sheets, 
Income Statements and Cash Flow Statements and their utiities. 


You may see the github repository at <https//github.com/n-kishaloy/FinanceLib.jl>
"""
module Statements

@enum BsTyp begin
  Cash                          
  CurrentReceivables             
  CurrentLoans                   
  CurrentAdvances               
  OtherCurrentAssets            
  CurrentInvestments            
  RawMaterials                  
  Inventories                   
  WorkInProgress                
  FinishedGoods                 
  CurrentAssets                 
  AccountReceivables            
  LongTermLoanAssets            
  LongTermAdvances              
  LongTermInvestments              
  OtherLongTermAssets            
  PlantPropertyEquipment        
  AccumulatedDepreciation       
  NetPlantPropertyEquipment     
  LeasingRentalAssets           
  AccumulatedAmortizationLeaseRental  
  NetLeaseRentalAssets          
  Goodwill                      
  CapitalWip                    
  OtherTangibleAssets             
  IntangibleAssets              
  IntangibleAssetsDevelopment   
  AccumulatedAmortization          
  NetIntangibleAssets           
  LongTermAssets                
  Assets                          
  CurrentPayables               
  CurrentBorrowings             
  CurrentNotesPayable           
  OtherCurrentLiabilities       
  InterestPayable               
  CurrentProvisions             
  CurrentTaxPayables            
  LiabilitiesSaleAssets         
  CurrentLeasesLiability        
  CurrentLiabilities            
  AccountPayables               
  LongTermBorrowings            
  BondsPayable                  
  DeferredTaxLiabilities        
  LongTermLeasesLiability       
  DeferredCompensation          
  DeferredRevenues              
  CustomerDeposits              
  OtherLongTermLiabilities      
  PensionProvision              
  TaxProvision                  
  LongTermProvision             
  LongTermLiabilities           
  Liabilities                   
  CommonStock                   
  PreferredStock                
  PdInCapAbovePar               
  PdInCapTreasuryStock          
  RevaluationReserves           
  Reserves                      
  RetainedEarnings              
  AccumulatedOci                
  MinorityInterests             
  Equity
end

@enum PlTyp begin
  OperatingRevenue              
  NonOperatingRevenue           
  ExciseStaxLevy                
  OtherIncome                   
  Revenue                       
  CostMaterial                  
  DirectExpenses                
  COGS                          
  Salaries                      
  AdministrativeExpenses        
  ResearchNDevelopment          
  OtherOverheads                
  OtherOperativeExpenses        
  OtherExpenses                 
  ExceptionalItems                
  GrossProfit                   
  Pbitda                        
  Depreciation                  
  AssetImpairment               
  LossDivestitures              
  Amortization                  
  Pbitx                         
  InterestRevenue               
  InterestExpense               
  CostDebt                      
  OtherFinancialRevenue         
  Pbtx                          
  ExtraordinaryItems            
  PriorYears                    
  Pbt                           
  TaxesCurrent                  
  TaxesDeferred                 
  Pat                           
  GainsLossesForex              
  GainsLossesActurial           
  GainsLossesSales              
  FvChangeAvlSale               
  OtherDeferredTaxes            
  OtherComprehensiveIncome      
  TotalComprehensiveIncome      
end



balanceSheetCalcMap = 
  [ 
    (Inventories, 
    [RawMaterials, WorkInProgress, FinishedGoods],
    BsTyp[]
    )
  , (CurrentAssets,
    [Cash, CurrentReceivables, CurrentLoans, CurrentAdvances, OtherCurrentAssets, CurrentInvestments, Inventories],
    BsTyp[]
    )
  , (NetPlantPropertyEquipment,
    [PlantPropertyEquipment],
    [AccumulatedDepreciation]
    )
  , (NetLeaseRentalAssets,
    [LeasingRentalAssets],
    [AccumulatedAmortizationLeaseRental]
    )
  , (NetIntangibleAssets,
    [IntangibleAssets, IntangibleAssetsDevelopment],
    [AccumulatedAmortization]
    )
  , (LongTermAssets,
    [AccountReceivables, LongTermLoanAssets, LongTermAdvances, LongTermInvestments, OtherLongTermAssets, NetPlantPropertyEquipment, NetLeaseRentalAssets, Goodwill, CapitalWip, OtherTangibleAssets, NetIntangibleAssets],
    BsTyp[]
    )
  , (Assets,
    [CurrentAssets, LongTermAssets],
    BsTyp[]
    )
  , (CurrentLiabilities,
    [CurrentPayables, CurrentBorrowings, CurrentNotesPayable, OtherCurrentLiabilities, InterestPayable, CurrentProvisions, CurrentTaxPayables, LiabilitiesSaleAssets, CurrentLeasesLiability],
    BsTyp[]
    )
  , (LongTermLiabilities,
    [AccountPayables, LongTermBorrowings, BondsPayable, DeferredTaxLiabilities, LongTermLeasesLiability, DeferredCompensation, DeferredRevenues, CustomerDeposits, OtherLongTermLiabilities, PensionProvision, TaxProvision, LongTermProvision],
    BsTyp[]
    )
  , (Liabilities,
    [CurrentLiabilities, LongTermLiabilities],
    BsTyp[]
    )
  , (Equity,
    [CommonStock, PreferredStock, PdInCapAbovePar, PdInCapTreasuryStock, RevaluationReserves, Reserves, RetainedEarnings, AccumulatedOci, MinorityInterests],
    BsTyp[] 
    )

  ]  :: Vector{Tuple{BsTyp, Vector{BsTyp}, Vector{BsTyp}}}

profitLossCalcMap = 
  [ (Revenue,
    [OperatingRevenue, NonOperatingRevenue],
    [ExciseStaxLevy]
  )
  , (COGS,
    [CostMaterial, DirectExpenses],
    PlTyp[]
  )
  , (GrossProfit,
    [Revenue],
    [COGS]
  )
  , (Pbitda,
    [GrossProfit, OtherIncome],
    [Salaries, AdministrativeExpenses, ResearchNDevelopment, OtherOverheads, OtherOperativeExpenses, OtherExpenses, ExceptionalItems]
  )
  , (Pbitx,
    [Pbitda],
    [Depreciation, AssetImpairment, LossDivestitures, Amortization]
  )
  , (Pbtx,
    [Pbitx, InterestRevenue, OtherFinancialRevenue],
    [InterestExpense, CostDebt]
  )
  , (Pbt,
    [Pbtx],
    [ExtraordinaryItems, PriorYears]
  )
  , (Pat,
    [Pbt],
    [TaxesCurrent, TaxesDeferred]
  )
  , (OtherComprehensiveIncome,
    [GainsLossesForex, GainsLossesActurial, GainsLossesSales, FvChangeAvlSale],
    [OtherDeferredTaxes]
  )
  , (TotalComprehensiveIncome,
    [Pat, OtherComprehensiveIncome],
    PlTyp[]
  )
  ]  :: Vector{Tuple{PlTyp, Vector{PlTyp}, Vector{PlTyp}}}

# cashFlowCalcMap = 



function createCalcMaps(bM :: Vector{Tuple{T, Vector{T}, Vector{T}}}) where T
  bCl = [x for (x, _, _) ∈ bM] :: Vector{T}
  bE = mapreduce( ((x,y,z),) -> (y...,z...), 
      (z,y) -> [z...,filter(x -> x ∉ bCl , y)...] :: Vector{T}, bM, init = T[]) 
  bCl, bE
end

balanceSheetCalcItems, balanceSheetEntries = createCalcMaps(balanceSheetCalcMap)
profitLossCalcItems, profitLossEntries = createCalcMaps(profitLossCalcMap)





end