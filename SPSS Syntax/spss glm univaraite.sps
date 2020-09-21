﻿* Encoding: UTF-8.

DATASET ACTIVATE DataSet6.

UNIANOVA W2PANSSSUM BY groupcd
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=groupcd(LSD DUNNETT(1)) 
  /PLOT=PROFILE(groupcd) TYPE=BAR ERRORBAR=SE(2) MEANREFERENCE=NO
  /EMMEANS=TABLES(groupcd) COMPARE ADJ(LSD)
  /PRINT ETASQ DESCRIPTIVE PARAMETER HOMOGENEITY OPOWER
  /CRITERIA=ALPHA(.05)
  /DESIGN=groupcd.
