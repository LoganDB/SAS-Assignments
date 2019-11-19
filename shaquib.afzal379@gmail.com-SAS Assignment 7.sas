                                /*ASSIGNMENT-7*/


/*QUESTION-1  */

data models;
input Name $ T_or_R $ price Material $;
datalines;
Black Track 796 Aluminum
Delta Road 399 CroMoly
Jet Track 1130 CroMoly
Mistral Road 1995 Carbon
Noreaster Mountain 899 Aluminum
Santa Mountain 459 Aluminum
Scirocco Mountain 2256 Titanium
Trade Road 759 Aluminum
;
run;

%let dataset = models;
%let sortvar= price;
%let dispsortvar=price;
%let ascdesc=ascending;

%put &dataset;
%put &sortvar;
%put &ascdesc;

%macro print;

proc sort data=&dataset.;
by &sortvar.;
run;

proc print data=&dataset.;
title "Sorted by &dispsortvar. &ascdesc.";
run;

%mend;

%print

/*QUESTION-2  */

proc import datafile='/folders/myfolders/Orders.txt' 
  out=orders 
  dbms=csv replace;
  delimiter= " ";
run;

if %put &sysday='Tuesday' then  1;
run;

data orders;
infile datalines dlm=",";
length model $20.;
input custid date date7. model $ no_of_orders;
format date date7.;
datalines;
287,15OCT03,Delta Breeze,15
287,15OCT03,Santa Ana,15
274,16OCT03,Jet Stream,1
174,17OCT03,Santa Ana,20
174,17OCT03,Noreaster,5
174,17OCT03,Scirocco,1
347,18OCT03,Mistral,1
287,21OCT03,Delta Breeze,30
287,21OCT03,Santa Ana,25
;
run;

%macro friday;

proc sort data=orders;
by custid;
run;

proc report data=orders;
by custid;
run;

%mend;
 
%macro monday;
proc print data=orders;
var custid, date, no_of_orders;
run;
%mend;

%macro notmonfri;
proc print data=orders;
run;
%mend;

%let day=&sysday;
%put &day;


%macro question2;

data orders;
set orders;
%if &day.='Friday' %then %friday;
%if &day.='Monday' %then %monday;
%else %notmonfri;

run;

%mend;

%question2;

/* QUESTION-3*/

%MACRO T;
data k;
%do j= 2 %to 3;
%do i= 1 %to 10;
var&i=&i**&j;
%end;
output;
%end;
run;
%MEND;
%T;

/* QUESTION-4*/
%local i next_word;
%let i=1;
%do %while (%scan(&word_list, &i) ne );
   %let next_word = %scan(&word_list, &i);
   %if &next_word.='' %then %BByee;
   %let i = %eval(&i + 1);
%end;

/*QUESTION-5*/
%macro question5(a,b);
proc freq data= car_sales;
table &a.*&b./crosslist ;
run;
%mend;

%question5(Model,Manufacturer);

%macro question5_1(avar1=,bvar2=);
proc freq data= car_sales;
table &avar1*&bvar2/crosslist ;
run;
%mend;

%question5_1(avar1=Model,bvar2=Manufacturer);