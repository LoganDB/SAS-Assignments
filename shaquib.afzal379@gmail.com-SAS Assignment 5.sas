                                             /*Assignment-5*/

FILENAME REFFILE '/folders/myfolders/Grocery_coupons.xls';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLS
	OUT=WORK.Grocery_coupons replace;
	GETNAMES=YES;
RUN;

data Grocery_coupons(drop=i);
set work.grocery_coupons;
array varN[*] _numeric_;
do i=1 to dim(varN);
if varN[i]= . then varN[i]=0;
	end;
	array varC[*] _character_;
do i=1 to dim(varC);
if varC[i]= . then varC[i]='NA';
	end;
	run;
/* Q1: */
data Grocery_coupons1(drop=date1 date2 date3);
set work.grocery_coupons;
date1=couponexpiry;
date2='31mar14'd;
date3=today();
months=intck('month',date1,date2);
months_1=intck('month',date1,date3);
weeks=intck('month',date1,date2);
weeks_1=intck('month',date1,date3);
days=intck('week',date1,date2);
days_1=intck('days',date1,date3);
format date1 date9.;
format date2 date9.;
format date3 date9.;
run;

/* Q2: */
data grocery_coupons2(drop=date1);
set work.grocery_coupons;
date1=couponexpiry;
coupon_issuance_date=intnx('months',date1,3);
format date1 date9.;
format coupon_issuance_date date9.;
run;

/* Q3: */
data grocery_coupons3(drop=date1);
set work.grocery_coupons;
date1=couponexpiry;
date2='30dec14'd;
date_diff=datdif(date1,date2,'30/360');
format date1 date9.;
format date2 date9.;
run;

/* Q4: */
data data_analysis;
set work.grocery_coupons;
retain Total_margin 0;
Margin=round(amtspent)-amtspent;
Total_margin=Total_margin+Margin;
run;proc print;run;

data data_analysis;
set work.grocery_coupons;
retain Estimated_margin 0;
Margin=round(amtspent)-amtspent;
Estimated_margin=Estimated_margin+(Margin/1404);
run;proc print;run;


FILENAME REFFILE '/folders/myfolders/department.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.Department replace;
	GETNAMES=YES;
RUN;

/* Q5: */
data department1;
set work.department;
Last_name=scan(name,2,',');
run;

/* Q6: */
data department2;
set work.department;
Starting_position=index(name,',')-1;
run;

/* Q7: */
data department3;
set work.department;
First_name=substr(name,1,index(name,',')-1);
run;
