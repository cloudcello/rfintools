# reference on testing packages:
# http://bioconductor.org/developers/unitTesting-guidelines/

# To start using testing packages quickly, here is
# the bare minimum: http://www.johnmyleswhite.com/notebook/2010/08/17/unit-testing-in-r-the-bare-minimum/

# The following test function was borrowed from the package 'rredis'
# checkEquals <- function(x, y) if(!isTRUE(all.equal(x, y, check.attributes=FALSE))) stop()

# require(RUnit)
require(blotter)
require(quantstrat)
require(rfintools)

options(digits=22) # default == 7
# ?Sys.info()
Sys.timezone()
Sys.setenv(TZ='UTC')

# switch to this: http://r-pkgs.had.co.nz/tests.html
checkEquals <- function(x, y)
{
    if(!isTRUE(all.equal(x, y, check.attributes=FALSE))) stop()
}

# dir=system.file('data',package='quantstrat')
dir=system.file('extdata',package='rfintools')
cat(dir,"\n")
load(file = paste0(dir,"/","test_tradeStats.RData"), envir=.GlobalEnv)
load(file = paste0(dir,"/","GBPUSD.RData"), envir=.GlobalEnv)
loadInstruments("TestInstruments.RData", dir=dir)

put.portfolio(portf2,portfolio.st = "forex")

(ls_instruments()) # for display only

if(0) {
    getPortfolio("forex")$symbols$GBPUSD$txn
    getPortfolio("forex")$symbols$GBPUSD$posPL
}

# full data ------------------------------------------------------------------ -
if(1) {
    cat("-------------------------------------------------------------------\n",
        "running test on the full data\n")

    ts <- tradeStatsExt("forex","GBPUSD", debugF = TRUE)

    attr(ts$Date.Min, "tzone") <- "UTC"
    attr(ts$Date.Max, "tzone") <- "UTC"
    str(ts)

    checkEquals( levels(ts$Portfolio)         ,      "forex"                  )
    checkEquals( levels(ts$Symbol)            ,      "GBPUSD"                 )
    checkEquals( ts$Num.Txns                  ,    24                         )
    checkEquals( ts$Num.Trades                ,    12                         )
    checkEquals( ts$Net.Trading.PL            ,  -492                         )
    checkEquals( ts$Avg.Trade.PL              ,   -41                         )
    checkEquals( ts$Med.Trade.PL              ,  -136                         )
    checkEquals( ts$Largest.Winner            ,   414                         )
    checkEquals( ts$Largest.Loser             ,  -396                         )
    checkEquals( ts$Gross.Profits             ,  1296                         )
    checkEquals( ts$Gross.Losses              , -1788                         )
    checkEquals( ts$Std.Dev.Trade.PL          ,   285.3865                    )
    checkEquals( ts$Percent.Positive          ,    33.333333333333329         )
    checkEquals( ts$Percent.Negative          ,    66.666666666666657         )
    checkEquals( ts$Profit.Factor             ,     0.72483221476512438       )
    checkEquals( ts$Avg.Win.Trade             ,   324                         )
    checkEquals( ts$Med.Win.Trade             ,   359                         )
    checkEquals( ts$Avg.Losing.Trade          ,  -223.5                       )
    checkEquals( ts$Med.Losing.Trade          ,  -241                         )
    checkEquals( ts$Avg.Daily.PL              ,   -61.5                       )
    checkEquals( ts$Med.Daily.PL              ,  -121                         )
    checkEquals( ts$Std.Dev.Daily.PL          ,   377.67975852566377          )
    checkEquals( ts$Ann.Sharpe                ,    -2.5849471986368129        )
    checkEquals( ts$Max.Drawdown              , -1424                         )
    checkEquals( ts$Profit.To.Max.Draw        ,    -0.3455056179775281        )
    checkEquals( ts$Avg.WinLoss.Ratio         ,     1.4496644295302488        )
    checkEquals( ts$Med.WinLoss.Ratio         ,     1.4896265560166377        )
    checkEquals( ts$Max.Equity                ,   400                         )
    checkEquals( ts$Min.Equity                , -1024                         )
    checkEquals( ts$End.Equity                ,  -492                         )
    checkEquals( ts$Max.Consec.Win.Trades     ,     2                         )
    checkEquals( ts$Max.Consec.Los.Trades     ,     4                         )
    checkEquals( ts$Avg.PLRecs.All.Trades     ,    22.583333333333332         )
    checkEquals( ts$Avg.PLRecs.Win.Trades     ,    27                         )
    checkEquals( ts$Avg.PLRecs.Los.Trades     ,    20.375                     )
    checkEquals( ts$Max.PLRecs.Flat.Period    ,    51                         )
    checkEquals( ts$Percent.Time.In.Market    ,    68.781725888324871         )
    checkEquals( ts$RINA.Index                ,    -1.1947141204532867        )

    checkEquals( ts$Date.Min, as.POSIXct("2002-10-21 00:30:00 UTC", tz="UTC") )
    checkEquals( ts$Date.Max, as.POSIXct("2002-11-04 23:00:00", tz="UTC")     )

}

# scoped data ---------------------------------------------------------------- -
if(1) {
    cat("-------------------------------------------------------------------\n",
        "running test on the scoped data\n")

    pd <- .parseISO8601("2002-10-22::2002-10-30", tz="UTC")
    dates <- paste0(pd$first.time,"::",pd$last.time)
    print(dates)
    ts <- tradeStatsExt("forex","GBPUSD", Dates = dates)

    attr(ts$Date.Min, "tzone") <- "UTC"
    attr(ts$Date.Max, "tzone") <- "UTC"

    str(ts)


    checkEquals( levels(ts$Portfolio)          ,      "forex"                 )
    checkEquals( levels(ts$Symbol)             ,      "GBPUSD"                )
    checkEquals( ts$Num.Txns                   ,    15                        )
    checkEquals( ts$Num.Trades                 ,     7                        )
    checkEquals( ts$Net.Trading.PL             ,  -912                        )
    checkEquals( ts$Avg.Trade.PL               ,   -87.428571428565633        )
    checkEquals( ts$Med.Trade.PL               ,  -126                        )
    checkEquals( ts$Largest.Winner             ,   364                        )
    checkEquals( ts$Largest.Loser              ,  -396                        )
    checkEquals( ts$Gross.Profits              ,   528                        )
    checkEquals( ts$Gross.Losses               , -1140                        )
    checkEquals( ts$Std.Dev.Trade.PL           ,   263.97149918306059         )
    checkEquals( ts$Percent.Positive           ,    28.571428571428569        )
    checkEquals( ts$Percent.Negative           ,    71.428571428571431        )
    checkEquals( ts$Profit.Factor              ,     0.46315789473686186      )
    checkEquals( ts$Avg.Win.Trade              ,   264                        )
    checkEquals( ts$Med.Win.Trade              ,   264                        )
    checkEquals( ts$Avg.Losing.Trade           ,  -228                        )
    checkEquals( ts$Med.Losing.Trade           ,  -246                        )
    checkEquals( ts$Avg.Daily.PL               ,  -122.39999999999191         )
    checkEquals( ts$Med.Daily.PL               ,  -126                        )
    checkEquals( ts$Std.Dev.Daily.PL           ,   421.5765648135594          )
    checkEquals( ts$Ann.Sharpe                 ,    -4.6089842866502995       )
    checkEquals( ts$Max.Drawdown               , -1424                        )
    checkEquals( ts$Profit.To.Max.Draw         ,    -0.6404494382022472       )
    checkEquals( ts$Avg.WinLoss.Ratio          ,     1.1578947368421546       )
    checkEquals( ts$Med.WinLoss.Ratio          ,     1.0731707317073498       )
    checkEquals( ts$Max.Equity                 ,   400                        )
    checkEquals( ts$Min.Equity                 , -1024                        )
    checkEquals( ts$End.Equity                 ,  -912                        )
    checkEquals( ts$Max.Consec.Win.Trades      ,     2                        )
    checkEquals( ts$Max.Consec.Los.Trades      ,     4                        )
    checkEquals( ts$Avg.PLRecs.All.Trades      ,    24.142857142857142        )
    checkEquals( ts$Avg.PLRecs.Win.Trades      ,    24                        )
    checkEquals( ts$Avg.PLRecs.Los.Trades      ,    24.2                      )
    checkEquals( ts$Max.PLRecs.Flat.Period     ,    19                        )
    checkEquals( ts$Percent.Time.In.Market     ,    85.067873303167417        )
    checkEquals( ts$RINA.Index                 ,    -1.0735954363659634       )

    checkEquals( ts$Date.Min, as.POSIXct( "2002-10-22 UTC", tz="UTC")         )
    checkEquals( ts$Date.Max, as.POSIXct("2002-10-30 23:30:00 UTC", tz="UTC") )

}

# scoped data ---------------------------------------------------------------- -
if(1) {
    cat("-------------------------------------------------------------------\n",
        "running test on the scoped data: initial exit transaction, to check ",
        "for the number of transactions\n")

    pd <- .parseISO8601("2002-10-23::2002-10-31", tz="UTC")
    dates <- paste0(pd$first.time,"::",pd$last.time)
    print(dates)
    ts <- tradeStatsExt("forex","GBPUSD", Dates = dates) #  NetTrPL ==  -532

    attr(ts$Date.Min, "tzone") <- "UTC"
    attr(ts$Date.Max, "tzone") <- "UTC"

    str(ts)


    # 'data.frame':	1 obs. of  40 variables:
    checkEquals( levels(ts$Portfolio)          , "forex"                      )
    checkEquals( levels(ts$Symbol)             , "GBPUSD"                     )
    checkEquals( ts$Num.Txns                   , 14                           )

    # includes the opening / initial exit transaction, i.e. counts thansactions
    # correctly
    checkEquals( ts$Num.Trades                 , 7                            )

    checkEquals( ts$Date.Min, as.POSIXct( "2002-10-23 UTC", tz="UTC")         )
    checkEquals( ts$Date.Max, as.POSIXct("2002-10-31 23:30:00 UTC", tz="UTC") )

}

# scoped data ---------------------------------------------------------------- -
if(1) {
    cat("-------------------------------------------------------------------\n",
        "running test on the scoped data with \"interval\" : initial exit",
        "transaction, to check for the number of transactions\n")

    pd <- .parseISO8601("2002-10-23::2002-10-31", tz="UTC")
    dates <- paste0(pd$first.time,"::",pd$last.time)
    print(dates)
    ts <- tradeStatsExt("forex","GBPUSD", Dates = dates, debugF = TRUE,
                        Interval = "6hours")

    attr(ts$Date.Min, "tzone") <- "UTC"
    attr(ts$Date.Max, "tzone") <- "UTC"

    str(ts)


    checkEquals( levels(ts$Portfolio)      ,       "forex"                    )
    checkEquals( levels(ts$Symbol)         ,       "GBPUSD"                   )
    checkEquals( ts$Num.Txns               ,     14                           )
    checkEquals( ts$Num.Trades             ,      7                           )
    checkEquals( ts$Net.Trading.PL         ,   -382                           )
    checkEquals( ts$Avg.Trade.PL           ,   -107.42857142856978            )
    checkEquals( ts$Med.Trade.PL           ,   -245.99999999999577            )
    checkEquals( ts$Largest.Winner         ,    364.00000000000364            )
    checkEquals( ts$Largest.Loser          ,   -396.00000000000148            )
    checkEquals( ts$Gross.Profits          ,    528.00000000000705            )
    checkEquals( ts$Gross.Losses           ,  -1279.9999999999957             )
    checkEquals( ts$Std.Dev.Trade.PL       ,    272.54532170072878            )
    checkEquals( ts$Percent.Positive       ,     28.571428571428569           )
    checkEquals( ts$Percent.Negative       ,     71.428571428571431           )
    checkEquals( ts$Profit.Factor          ,      0.41250000000000692         )
    checkEquals( ts$Avg.Win.Trade          ,    264.00000000000352            )
    checkEquals( ts$Med.Win.Trade          ,    264.00000000000352            )
    checkEquals( ts$Avg.Losing.Trade       ,   -255.99999999999912            )
    checkEquals( ts$Med.Losing.Trade       ,   -255.99999999999466            )
    checkEquals( ts$Avg.Daily.PL           ,   -150.3999999999977             )
    checkEquals( ts$Med.Daily.PL           ,   -255.99999999999466            )
    checkEquals( ts$Std.Dev.Daily.PL       ,    426.4959554321735             )
    checkEquals( ts$Ann.Sharpe             ,     -5.5980038091694011          )
    checkEquals( ts$Max.Drawdown           ,   -948                           )
    checkEquals( ts$Profit.To.Max.Draw     ,     -0.40295358649789031         )
    checkEquals( ts$Avg.WinLoss.Ratio      ,      1.0312500000000173          )
    checkEquals( ts$Med.WinLoss.Ratio      ,      1.0312500000000353          )
    checkEquals( ts$Max.Equity             ,    150                           )
    checkEquals( ts$Min.Equity             ,   -798                           )
    checkEquals( ts$End.Equity             ,   -382                           )
    checkEquals( ts$Max.Consec.Win.Trades  ,      2                           )
    checkEquals( ts$Max.Consec.Los.Trades  ,      3                           )
    checkEquals( ts$Avg.PLRecs.All.Trades  ,     21                           )
    checkEquals( ts$Avg.PLRecs.Win.Trades  ,     24                           )
    checkEquals( ts$Avg.PLRecs.Los.Trades  ,     19.800000000000001           )
    checkEquals( ts$Max.PLRecs.Flat.Period ,     19                           )
    checkEquals( ts$Percent.Time.In.Market ,     71.428571428571431           )
    checkEquals( ts$RINA.Index             ,     -5.5689672544079754          )
    checkEquals( ts$Date.Min               ,       "2002-10-23 UTC"           )
    checkEquals( ts$Date.Max               ,       "2002-10-31 23:30:00 UTC"  )

}

# end ------- ---------------------------------------------------------------- -
cat("end of test\n")

# t(tradeStatsExt("forex","GBPUSD", Dates = "2002-10-23::2002-10-30", debugF = TRUE))
# t(tradeStatsExt("forex","GBPUSD", Dates = "2002-10-21 00:00 UST::2002-10-30 00:00 UST",debugF = TRUE))

# done!


