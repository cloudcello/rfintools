# TODO: ----
# find R packages that use 'bigmemory' package with 'foreach'
# a solution for small-RAM (non server-grade) computers is to use the following front-end
# for quantstrat:

# RAM-HDD(SDD) map:
# write functions that create a set of tuples:
#    "path/to/paramset_result" :: "memory-mapped name of that particular portfolio"
#

# TODO: ----
# write into debug info: run time (start, completion, duration) of the combo
# computer name & pid
#

# TODO: ----
# convert the templates I am using (re-worked luxor demos from QuantStrat framework)
# so they exclude any private info and include them into the package as
# strategy development templates

# TODO: ---
# write a proper description for the robustApplyParamset() function:
# mention that as a side effect, one can even kill the master process and nothing bad
# will happen as all the tasks for the job are in the redis server. (New) workers will
# connect to the server whenever they do, even after the master process has been shut
# down (or crashed for whatever reason). Workers then get all the remaining tasks
# and complete the job.
# As a verification, the master process can be restarted at the very end (after workers
# processed all there was to process from the redis server), the master process will
# check all the backup files, and
# will resubmit all the tasks that have not been processed or failed to save for any reason.
# The master process combine the result and save it.
#


# TODO: profile code & see the 'call tree' using these standard tools: ----
# https://mikedewar.wordpress.com/2010/05/13/profiling-in-r/
# other references on code profiling
# https://cran.r-project.org/doc/manuals/R-exts.html#Tidying-and-profiling-R-code
# https://stat.ethz.ch/R-manual/R-devel/library/utils/html/Rprof.html
# http://www.noamross.net/blog/2013/4/25/faster-talk.html
# http://www.stat.berkeley.edu/~nolan/stat133/Fall05/lectures/profilingEx.html
# https://cran.r-project.org/web/packages/aprof/aprof.pdf
# A MUST-READ: http://adv-r.had.co.nz/Profiling.html
#

# TODO: syslog ----
# https://en.wikipedia.org/wiki/Syslog
# use syslog as a logger: http://www.aboutdebian.com/syslog.htm
# find out how easy it is to send messages
# http://sysbible.org/2008/07/25/configuring-syslog-to-receive-messages-from-the-network-aka-listen/
# adjust flog.appender ---- Manage appenders for loggers
# write flog.appender for syslog to be able to send data to syslog !!!
#
# hadoop uses syslog!
# http://stackoverflow.com/questions/17450816/running-a-r-script-using-hadoop-streaming-job-failing-pipemapred-waitoutputthr
# via what java library ?
# maybe that java library could be plugged into R code?
#
#


# TODO: write a manual on speeding up calcs ----
# when to use path dependence and how to turn it off
# (it's 'on' by default
# what functions in QS use path dependence
#



# TODO: create functions to work with time zones properly (check/change, etc.) ----
#
# 1. read help ?Sys.timezone
#
# 2. TZ Reference Windows: R: R_HOME\share\zoneinfo\ Linux: /usr/share/zoneinfo
#
#    how to read zoneinfo database:
#    zdump - timezone dumper
#    zdump -v "file_name"
#
#      will dump for each zonename on the command line,
#
#      print the time at the lowest possible time value,
#      the time one day after the lowest possible time value,
#
#      the times both one second before and exactly at
#      each detected time discontinuity,
#
#      the time at one day less than the highest ossible time value, and
#      the time at the highest possible time value.
#
#      Each line ends with isdst=1 if the given time is Daylight
#      Saving Time or isdst=0 otherwise.
#
# 3. The proper way to save market data would be to assign market time zone
#    prior to saving the data or _after_ saving the data (in *.rda) format
#    and then re-saving it
#
# 4. zipped latest data
#    http://www.iana.org/time-zones
#
#

# TODO: determine the number of cores for each node within a shell script / batch ! ----
# (for running the max number of workers automatically)
#