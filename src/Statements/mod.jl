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

import FinanceLib as Fl

@enum BsTyp begin
  Cash                          
  CurrentReceivables             
  CurrentLoans                   
  CurrentAdvances               
  OtherCurrentAssets            
  CurrentInvestments            
  Inventories                   
  RawMaterials                  
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
  NetIncomeDiscontinuedOps    
  NetIncome             
  GainsLossesForex              
  GainsLossesActurial           
  GainsLossesSales              
  FvChangeAvlSale               
  OtherDeferredTaxes            
  OtherComprehensiveIncome      
  TotalComprehensiveIncome      
end

@enum CfTyp begin
  DeferredIncomeTaxes           
  ChangeInventories             
  ChangeReceivables             
  ChangePayables                
  ChangeLiabilities             
  ChangeProvisions              
  OtherCfOperations             
  StockCompensationExpense      
  StockCompensationTaxBenefit   
  AccretionDebtDiscount         
  CashFlowOperations            
  InvestmentsPpe                
  InvestmentsCapDevp            
  InvestmentsLoans              
  AcqEquityAssets               
  DisEquityAssets               
  DisPpe                        
  ChangeInvestments             
  CfInvestmentInterest          
  CfInvestmentDividends         
  OtherCfInvestments            
  CashFlowInvestments           
  StockSales                    
  StockRepurchase               
  DebtIssue                     
  DebtRepay                     
  InterestFin                   
  Dividends                     
  DonorContribution             
  OtherCfFinancing              
  CashFlowFinancing             
  NetCashFlow                   
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
  , (NetIncome,
    [Pat, NetIncomeDiscontinuedOps],
    PlTyp[]
  )
  , (OtherComprehensiveIncome,
    [GainsLossesForex, GainsLossesActurial, GainsLossesSales, FvChangeAvlSale],
    [OtherDeferredTaxes]
  )
  , (TotalComprehensiveIncome,
    [NetIncome, OtherComprehensiveIncome],
    PlTyp[]
  )
  ]  :: Vector{Tuple{PlTyp, Vector{PlTyp}, Vector{PlTyp}}}

# cashFlowCalcMap = 

const BsDict = Dict{BsTyp, Float64}
const PlDict = Dict{PlTyp, Float64}
const CfDict = Dict{CfTyp, Float64}

using Dates: Date

struct Account
  dateBegin         :: Date 
  dateEnd           :: Date

  balanceSheetBegin :: Union{BsDict, Nothing}
  balanceSheetEnd   :: Union{BsDict, Nothing}
  profitLoss        :: Union{PlDict, Nothing}
  cashFlow          :: Union{CfDict, Nothing}

  others            :: Union{Dict{Symbol, Float64}, Nothing}
end

struct Params  
  U   :: Float64  # Unlevered
  S   :: Float64  # Tax shield
  E   :: Float64  # Equity 
  D   :: Float64  # Debt 
  V   :: Float64  # Valuation

end

struct Company 
  code          :: Symbol
  affiliation   :: Dict{Symbol, Float64}
  consolidated  :: Bool
  period        :: Vector{Date}
  balanceSheet  :: Dict{Date, BsDict}
  profitLoss    :: Dict{Tuple{Date, Date}, PlDict}
  cashFlow      :: Dict{Tuple{Date, Date}, CfDict}
  others        :: Dict{Tuple{Date, Date}, Dict{Symbol, Float64}}
  sharePrice    :: Union{Fl.DateSeries, Nothing}
  rate          :: Union{Vector{Params}, Nothing}
  beta          :: Union{Vector{Params}, Nothing}
end

function createCalcSets(bM :: Vector{Tuple{T, Vector{T}, Vector{T}}}) where T
  bCl = [x for (x, _, _) ∈ bM] :: Vector{T}
  bE = mapreduce( ((x,y,z),) -> (y...,z...), 
      (z,y) -> [z...,filter(x -> x ∉ bCl , y)...] :: Vector{T}, bM, init = T[]) 
  Set(bCl), Set(bE)
end

balanceSheetCalcItems, balanceSheetEntries = createCalcSets(balanceSheetCalcMap)
profitLossCalcItems, profitLossEntries = createCalcSets(profitLossCalcMap)

getAccount(x::Company, d1::Date, d2::Date) = Account(
  d1, d2, get(x.balanceSheet,d1,nothing), get(x.balanceSheet,d2,nothing), 
  get(x.profitLoss,(d1,d2),nothing), get(x.cashFlow,(d1,d2),nothing), 
  get(x.others,(d1,d2),nothing)
)

putAccount!(x::Company, z::Account) = error("TODO: Add Implementation")

putDict!(x::Company, z::BsDict, d1) = error("TODO: Add Implementation")

putDict!(x::Company, z::PlDict, d1, d2) = error("TODO: Add Implementation")

putDict!(x::Company, z::CfDict, d1, d2) = error("TODO: Add Implementation")

cleanDict!(x) = error("TODO: Add Implementation")

cleanDict!(x::Company) = error("TODO: Add Implementation")

calcDict!(x::BsDict) = error("TODO: Add Implementation")

calcDict!(x::PlDict) = error("TODO: Add Implementation")

calcDict!(x::CfDict, b1, b2) = error("TODO: Add Implementation")

calcDict!(x::Company) = error("TODO: Add Implementation")

saveParquet(x) = error("TODO: Add Implementation")

readParquet(s) = error("TODO: Add Implementation")

eps(x) = error("TODO: Add Implementation")
dilutedEPS(;earn, prefDiv = 0.0, shares, sharePrice, options) = error("TODO: Add Implementation")

end