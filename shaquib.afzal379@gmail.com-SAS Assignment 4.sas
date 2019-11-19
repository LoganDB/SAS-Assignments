                                        /* Assignment-4 */

/* Q1: */
/* 1) */
data Account_Value1;
rate=0.1;
do year=1 to 15;
	capital+5000;
	accumulated_interest+(capital*rate);
	Value_of_acc=capital+accumulated_interest;
	output;
	end;
run;

/* 2) */
data Account_Value2;
rate=0.1;
do year=1 to 15;
	capital+5000;
	accumulated_Interest+(accumulated_Interest+capital)*rate;
	Value_of_acc=accumulated_Interest+capital;
	output;
	end;
run;

/*  Q2: */
data quest2;
mpg=20;
do while (miles<=250 and fuel<10);
	fuel+1;
	miles=mpg*fuel;
	output;
	end;
run;

/* Q3: */
/* 1) */
data earn_3;
capital=500000;
rate=0.07;
do year=1 to 25;
	accumulated_interest+(capital+accumulated_interest)*rate;
	value_of_acc=accumulated_interest+capital;
	output;
	end;
run;

 
/*  2) */
data earn_4;
amount=500000;
rate=0.07;
do year=1 to 25;
do month=1 to 12;
	interest=amount*(rate/12);
	amount+interest;
	output;
	end;
	end;
run;