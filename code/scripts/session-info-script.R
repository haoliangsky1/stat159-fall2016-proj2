# Include all library() calls to the packages 
# that are used in the project
sink('session-info.txt')
print('Packages used for this project:')
library(stats)
'stats'
library(base)
'base'
library(utils)
'utils'
library(grDevices)
'grDevices'
library(graphics)
'graphics'
library(testthat)
'testthat'
library(plyr)
'plyr'
print('R Session Infomation')
sessionInfo()
sink()