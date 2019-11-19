                                    /*ASSIGNENT 2 */

/* Q1: */
filename reffile '/folders/myfolders/Grocery_coupons.xls';
PROC IMPORT DATAFILE=reffile
	DBMS=xls
	OUT=work.Grocery_coupons replace ;
	GETNAMES=YES;
	run;
data Grocery_coupons_updated;
set Work.Grocery_coupons;
label storeid = "Store ID"
hlthfood="Health food store"
size="Size of store"
org="organization"
custid="Customer ID"
gender="Gender"
shopfor="Who shopping for"
veg="Vegetarian"
style="Shopping style"
usecoup="Use coupons"
week="Week"
seq="Sequence"
carry="Carryover"
coupval="Value_of coupon"
amtspent="Amount spent";
run;
proc format lib=work.grocery_coupons_updated;
value  hlthfood 0="No" 1="Yes";
value size 1="Small" 2="Medium" 3="Large"	;
value org 1="Emphasizes produce" 2="Emphasizes deli" 3="Emphasizes bakery" 4="No emphasis";
value gender 0="Male" 1="Female";
value shopfor 1="Self" 2="Self and spouse"	3="Self and family";
value veg 0="No" 1="Yes";
value style 1="Biweekly; in bulk" 2="Weekly; similar items"	3="Often; what's on sale";
value usecoup 1="No" 2="From newspaper"	3="From mailings" 4="From both";
value carry 0="First period" 1="No coupon"	2="5 percent" 3="15 percent" 4="25 percent";
value coupval 1="No value"	2="5 percent" 3="15 percent" 4="25 percent";
RUN;
proc contents data=work.grocery_coupons_updated;
run;

/* Q2 */
PROC SORT DATA = Grocery_coupons OUT = Grocery_coupons1;
BY gender ;
RUN;
proc freq data= Grocery_coupons1;
tables coupval*style / nocol nocum nopercent norow out=Overall_data;
run;
proc freq data= Grocery_coupons1;
tables coupval*style / nocol nocum nopercent norow out=overall_data_by_gender;
by  gender;
run;

/* Q3: */
proc sort data=Grocery_coupons out=grocery_coupons2;
by org;
run;
proc freq data=Grocery_coupons2;
tables size / nocol norow out=Table_cell ;
by org;
run;
proc freq data=Grocery_coupons2;
tables size / nocol nocum nopercent norow out=Table_cell_frequencies(keep=size count);
run;
proc freq data=Grocery_coupons2;
tables size / nocol nocum nofreq norow out=Table_cell_percentages(keep=org size percent) ;
by org;
run;

/* Q4: */
proc means data=grocery_coupons3 sum min max mean var;
var amtspent;
output out=table2
max = max_amtspent 
min=min_amtspent
mean=avg_amtspent
sum=tot_amtspent;
class org size;
run;

