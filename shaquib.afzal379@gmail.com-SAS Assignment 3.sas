                                            /*Assignment-3 */

FILENAME REFFILE '/folders/myfolders/Car_sales.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.Car_sales replace;
	GETNAMES=YES;
RUN;

/* Q1: */
data Car_sales;
set work.car_sales;
length Country_of_origin $20;
select (Manufacturer);
   when("Acura") Country_of_origin="Japan";
   when("Audi" ) Country_of_origin="Germany";
   when("BMW") Country_of_origin="Germany";
   when("Buick") Country_of_origin="USA";
   when("Cadilac") Country_of_origin="USA";
   when("Chevrole") Country_of_origin="USA";
   when("Chrysler") Country_of_origin="USA";
   when("Dodge") Country_of_origin="USA";
   when("Ford") Country_of_origin="USA";
   when("Honda") Country_of_origin="Japan";
   when("Hyundai") Country_of_origin="South Korea";
   when("Infiniti") Country_of_origin="Hong Kong";
   when("Jaguar") Country_of_origin="United Kingdom";
   when("Jeep") Country_of_origin="USA";
   when("Lexus") Country_of_origin="Japan";
   when("Lincoln") Country_of_origin="USA";
   when("Mercedes") Country_of_origin="Germany";
   when("Mercury") Country_of_origin="USA";
   when("Mitsubis") Country_of_origin="Japan";
   when("Nissan") Country_of_origin="Japan";
   when("Oldsmobi") Country_of_origin="USA";
   when("Plymouth") Country_of_origin="USA";
   when("Pontiac") Country_of_origin="USA";
   when("Porsche") Country_of_origin="Germany";
   when("Saab") Country_of_origin="Sweden";
   when("Saturn") Country_of_origin="USA";
   when("Subaru") Country_of_origin="Japan";
   when("Toyota") Country_of_origin="Japan";
   when("Volkswag") Country_of_origin="Germany";
   when("Volvo") Country_of_origin="Sweden";
   otherwise Country_of_origin="";
end;   
run;
proc sort data=car_sales out=car_sales;
by Manufacturer;
run;
proc freq data=work.car_sales;
tables Model*Country_of_origin / nocol nopercent nocum norow;
by manufacturer;
run; 

/* Q2: */
data car_sales1;
set work.car_sales;
length uniqueID $20; 
uniqueID = catx("-", Manufacturer, Model);
run;

/* Q3: */
/* 1: */
data car_sales2(keep=uniqueID Manufacturer Model Latest_launch _4_year_resale_value price_in_thousands sales_in_thousand) ;
set work.car_sales1;
run;

/* 2: */
data car_sales3(drop=Manufacturer Model Latest_launch _4_year_resale_value price_in_thousands sales_in_thousand) ;
set work.car_sales1;
run;

/* Q4: */
data Hyundai;
 infile datalines;
 input Manufacturer$ Model$ price_in_thousands _4_year_resale_value  Latest_launch date9.;
 datalines;
 Hyundai Tuscon 16.919 16.36 2Feb12
 Hyundai i45 39.384 19.875 3Jun11
 Hyundai Verna 14.114 18.225 4Jan12
 Hyundai Terracan 8.588 29.725 10Mar11
 ;
run;
data Hyundai;
set Hyundai;
format Latest_launch ddmmyy10.;
run; 
data Hyundai1;
set work.Hyundai;
length uniqueID $20; 
uniqueID = catx("-", Manufacturer, Model);
run;

/* Q5: */
data Total_sales;
set hyundai car_sales2;
run;

/* Q6: */
proc sort data=Total_sales out=Total_sales;
by uniqueID;
run;
proc sort data=car_sales3 out=car_sales3;
by uniqueID;
run;
data New_data;
merge Total_sales car_sales3;
by uniqueID;
run; 

/* Q7: */
proc sort data=New_data1 out=New_data1;
by uniqueID;
run;
data New_data1;
merge Total_sales(in=InTotal_sales) car_sales3 (in=Incar_sales3);
by uniqueID;
if InTotal_sales and Incar_sales3;
run;

