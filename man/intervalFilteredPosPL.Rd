% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tradeStats.R
\name{intervalFilteredPosPL}
\alias{intervalFilteredPosPL}
\title{Filters position PL records that correspond to set intervals exatly;
       removes all the 'extra' records, including those of transactions}
\usage{
intervalFilteredPosPL(ct, interval = NULL)
}
\arguments{
\item{ct}{environment with context variables, which must include the
following: portfolio, symbol, ppl (position PL), dates,
dargs(expanded '...'), etc. (yet to be worked out)}

\item{interval}{optional character string, containing one of "millisecond"
(or "ms"), "microsecond" (or "us"), "second", "minute", "hour", "day",
"week", "month", "quarter", or "year". This can optionally be preceded by a
positive integer, or followed by "s".}
}
\description{
When a portfolio is updated not on every timestamp, but on intervals larger
than intervals b/n market data timestamps, Position PL records are formed out
of a 'union' of records based on the Interval argument and records that
correspond to records within transactions table.
Time in the market should be based on interval timestamps to be correct,
excluding duplicates (!), so the statement above should be applied to
statistics based on the number of PosPL records in general.
At the same time, those records not falling on Interval
endpoints could simply be removed from PosPL and the statistics will not be
distorted by those "txn" table records
}
\details{
"time zero" for endpoints is always linked to the beginning of the
available price time series. Therefore, "endpoints" may be different
for the same study depending on the loaded price data This is a good
approach as it relieves the user of the burden to keep an extra
variable for the beginning of the time series across other functions
of the QS framework
}

