PROC IMPORT OUT= WORK.autismchina 
 /* change file name here*/ DATAFILE= "C:\Users\jenarriaza\SAS Files\Data\revs\OSU r7 over60_ageclass_rev.sav"
 
            DBMS=SPSS REPLACE;

RUN;
title;

proc contents data=autismchina;
run;
title;

data multidata ;
  set autismchina;
  keep SUBNUM DRUGCODEN communicationbarriersBaselineave communicationbarriersV1average communicationbarriersV2average communicationbarriersV3average;
  run;

proc print data=multidata (obs=92); 
run;
*univariate set-up for mixed model;
data unidata;
  set multidata;
  array A(4)communicationbarriersBaselineave--communicationbarriersV3average;
  subject +1;
  do time=1 to 4;
        osucommubarrtot=A(time);
	output;
  end; 
drop communicationbarriersBaselineave--communicationbarriersV3average; 
run;

data unidata;
  set unidata;
  
run;

****** Model1 -- Unstructured osu dis over 60 comm barriers total -measure model,  **********;
proc mixed data=unidata method=ml;
title "repeated measures osu r7 dis over 60 communication barriers tot ov unstructured model";
  class SUBNUM DRUGCODEN time;
  model osucommubarrtot= DRUGCODEN time  time*DRUGCODEN/solution;
  repeated time /subject=SUBNUM type=un r rcorr;
  lsmeans time*DRUGCODEN/diffs;
    ods output diffs=drugdiffs lsmeans=druglsmeans;
run; 
