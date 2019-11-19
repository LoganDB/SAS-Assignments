                                 /* ASSINMENT 1 */
/* Q1: */
PROC IMPORT DATAFILE='/folders/myfolders/Car_sales.csv'
	DBMS=CSV
	OUT=work.IMPORT replace ;
	GETNAMES=YES;
RUN;

/* Q2: */
data car_missing;
 set WORK.import;
  if price_in_thousands = . or
  _4_year_resale_value=. then delete;
  run; proc print; run;
  
/* Q3: */
data Car_sales_1 Car_sales_2 Car_sales_3 Car_sales_4 Car_sales_5;
set work.import;
if Price_in_thousands<=15 then output Car_sales_1;
else if Price_in_thousands<=20 then output Car_sales_2;
else if Price_in_thousands<=30 then output Car_sales_3;
else if Price_in_thousands<=40 then output Car_sales_4;
else if Price_in_thousands>40 then output Car_sales_5;
run;




/* Q4: */
data Car_Sales_new;
set work.import(keep=Manufacturer Model Sales_in_thousands Price_in_thousands);
run;

/* Q5: */
data Car_sales_Passenger;
set work.import;
where Vehicle_type="Passenger" and 
Latest_launch>'1oct2014'd;
run;