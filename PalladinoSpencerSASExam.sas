*Spencer Palladino
SAS Exam
Stat 4360;

*Question 1;
*Part A;
data pinfo;
	infile 'D:\data\pinfo.txt' firstobs=2 expandtabs; *expand tabs fixes tab issue
												and firstobs=2 sets first line of data to line 2;
	input ID$ trt$ base age gender$; *import the variables;
	label time='Week'
		trt='Treatment'
		base='Baseline Rate';
run;
proc means data=pinfo  Mean Median Min Max Std; *create 5 summary stat;
	var age; *choose var;
	title '5 Summary Statistics for Age'; *creates title;
run;

*Part B;
proc freq data=pinfo;
	tables gender*trt / chisq nocol norow nopercent; *chisq gets chi squared test output for the variables
													nocol, norow, and nopercent get rid of extra info in tables;
	title 'Contingencytable of the counts for Gender vs. Treatment';
run;

*Part C;
data progabide;
	infile 'D:\data\progabide.txt' firstobs=2 expandtabs; *expand tabs fixes tab issue
												and firstobs=2 sets first line of data to line 2;
	input ID$ Time$ Y; *import the variables;
	label time='Week'
			Y='Number of Seizures'
	;*label variables;
run;

data placebo;
	infile 'D:\data\placebo.txt' firstobs=2 expandtabs; *expand tabs fixes tab issue
												and firstobs=2 sets first line of data to line 2;
	input ID$ Time$ Y; *import the variables;
	label time='Week'
			Y='Number of Seizures'
	; *label vars;
run;

data allpatients;
	set progabide placebo; *vertically merge the 2 data sets;
run;
title 'Distribution of the Number of Seizures';
proc univariate data=allpatients noprint;  
	histogram Y  ; *creates histogram of variable Y;
	label Y='Number of Seizures'; *labels var Y as Seizures on the axis;
run;

*Part D;
data allinfo;
	merge placebo progabide pinfo; *merge data horizontally;
	by ID; *merge using ID;
	label time='week'
			Y='Number of Seizures'
			trt='Treatment'
			base='Base Rate'; *label variables;
run;
proc print data=allinfo label; *print data with made labels;
	where ID contains '227'; *specify to just ID# 227;
	title 'Observations for Patient 227'; *new title for output;
run;

*Part E;
data parte;
	set allinfo; *set dataset I want to pull data from;
	if gender='F' and time='3' and trt='0'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
proc means data=parte mean; *request mean of new data;
	var y; *choose y as variable;
	title 'Mean Number of Seizures of Women in Week 3 on Placebo';
run;

*Part F;
data partf;
	set allinfo; *set dataset I want to pull data from;
	if gender='M' and time='1' and trt='0'
	then output;*set parameters for observations I want to include
				and then add them to my new dataset;
run;
proc means data=partf Q1; *request quartile 1 of new data;
	var y; *choose y as variable;
	title 'Quartile 1 of Seizures of Men in Week 1 on Placebo';
run;

*Part G;
data partg;
	set allinfo; *set dataset I want to pull data from;
	if gender='F' and time='2' and trt='1'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
proc means data=partg Max; *request max of new data;
	var y;*choose y as variable;
	title 'Max Number of Seizures by Women in Week 2 on Progabide';
run;

*Part H;
data parth;
	set allinfo; *set dataset I want to pull data from;
	if gender='M' and time='4' and trt='1'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
proc means data=parth median; *request median of new data;
	var y; *choose y as variable;
	title 'Median Number of Seizures by Men in Week 4 on Progabide';
run;

*Part I;
data parti;
	set allinfo; *set dataset I want to pull data from;
	change = base-y; *create new variable in dataset;
	label change= 'Change in Seizures'; *label new var;
run;
proc means data=parti min max; *request min and max of new dataset;
	var change; *choose var*;
	title 'Min and Max Change of Seizures from Baseline';
run;

*Part J;
*Plot 1;
data partji;
	set parti; *set dataset I want to pull data from;
	if gender='F' and trt='0'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
title 'Change of Baseline Seizure rate by Age for Females taking a Placebo Scatter Plot';
proc sgplot data=partji;
	scatter x=age y=change / group=time
	markerattrs=(symbol=circlefilled); 
	*creates scatter plot with my varibales and has filled black dots as points;
	*I decided to have each week show as a different color in the plot (group=time);
	xaxis min=10 max=50; *set x axis;
	yaxis min=-25 max=100;*set yaxis;
run;

*plot 2;
data partjii;
	set parti; *set dataset I want to pull data from;
	if gender='F' and trt='1'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
title 'Change of Baseline Seizure rate by Age for Females taking Progabide Scatter Plot';
proc sgplot data=partjii;
	scatter x=age y=change / group=time
	markerattrs=(symbol=circlefilled); 
	*creates scatter plot with my varibales and has filled black dots as points;
	*I decided to have each week show as a different color in the plot (group=time);
	xaxis min=10 max=50; *set x axis;
	yaxis min=-25 max=100;*set yaxis;
run;
*plot 3;
data partjiii;
	set parti; *set dataset I want to pull data from;
	if gender='M' and trt='0'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
title 'Change of Baseline Seizure rate by Age for Males taking a Placebo Scatter Plot';
proc sgplot data=partjiii;
	scatter x=age y=change / group=time
	markerattrs=(symbol=circlefilled); 
	*creates scatter plot with my varibales and has filled black dots as points;
	*I decided to have each week show as a different color in the plot (group=time);
	xaxis min=10 max=50; *set x axis;
	yaxis min=-25 max=100;*set yaxis;
run;
*plot 4;
data partjiv;
	set parti; *set dataset I want to pull data from;
	if gender='M' and trt='1'
	then output; *set parameters for observations I want to include
				and then add them to my new dataset;
run;
title 'Change of Baseline Seizure rate by Age for Males taking Progabide Scatter Plot';
proc sgplot data=partjiv;
	scatter x=age y=change / group=time
	markerattrs=(symbol=circlefilled); 
	*creates scatter plot with my varibales and has filled black dots as points;
	*I decided to have each week show as a different color in the plot (group=time);
	xaxis min=10 max=50; *set x axis;
	yaxis min=-25 max=100;*set yaxis;
run;

*Question 2;
data doughrise2;
	infile 'D:\data\doughrise2.TXT' firstobs=2 ; *firstobs=2 sets first line of data to line 2;
	input day temperature; *import the variables;
run;
data doughrise1;
	infile 'D:\data\doughrise1.TXT' firstobs=4 ; *firstobs=2 sets first line of data to line 4;
	input day additive$ risetime; *import the variables;
run;

*Part A;
proc format; *create format;
	value $words  1= 'gluten flour'
			2 = 'barley malt extract'
			3 = 'potato starch'
			4 = 'control'; *list what i want each output to look like;
run;
data dough; *create new dataset;
	merge doughrise2 doughrise1 ; *merge data just imported;
		by day; *merge using ID;
	label day='Day of Experiment'
				additive='Dough Conditioner'
				risetime='Time to Double'
				temperature='Room Temperature'; *label variables;
	format additive $words.; *request previously created format to be used
  							for variable additive;
run;
libname MIDTERM 'D:\data\'; *create MIDTERM library;

proc copy in=work out=MIDTERM; *grabs dough file that was just ran in work library
								and moves it to my MIDTERM library;
select dough; *select the dough file;
run;
proc print data=MIDTERM.dough label; *print data from MIDTERM library;
  title 'Dough'; *title for output;
run;

*Part B;
title 'Anova Test for Relationship Between Rising Time and Additive';
proc glm data=MIDTERM.dough alpha=.1;
	class additive; *class additive as it's categorical;
	model risetime=additive / ss1 ss2 ss3 ss4; *create model and 
											check each type of SSE;
	means additive / tukey CLM CLDIFF ;*use tukey method;
run;

*Part C;
title 'Regression model for Relationship Between Rising Time and Temperature';
proc reg data=MIDTERM.dough alpha=.01; *sets alpha to .01 for CI limits;
      model risetime=temperature / CLB ; *create what we want regression model to be
	  										CLB adds the confidence limits;
run;
*part i of C; 
title 'Temerature vs Rising Time Scatter Plot'; 
proc sgplot data= MIDTERM.dough;
	scatter x=temperature y=risetime / 
	markerattrs=(symbol=circlefilled); *set variables to axis ;
	xaxis label='temperature'; *renaming x axis;
	yaxis label='Time Until Rise'; *renaming y axis;
	reg x=temperature y=risetime; *create linear estimate line on plot;
run;
*Part D;
data partd;
	set MIDTERM.dough;
	if additive = '1' then gluten=1; else gluten=0; *create gluten var;
	if additive = '2' then barley=1; else barley=0; *create barley var;
	if additive = '3' then potato=1; else potato=0; *create potato var;
	keep risetime temperature gluten barley potato; *choose vars I want in table;
	output;
run;
title 'First 4 Days of Data';
proc print data=partd (firstobs=1 obs=4) label; *only show first 4 observartions;
run;

*Part e;
title 'Model Estimation for Rise Time';
proc reg data=partd plots=QQplot plots=diagnostics(unpack);
	model risetime = temperature gluten barley potato /clm;
run;

*Question 3;
data question3;
  set MIDTERM.question3; *set data in library;
   Z=Y;
   A=7;
   B= x1;
   C= x2;
   D= x3;
   E= x4;
   F= x5;
   pred= A + B + C + D + E + F;
   res= Z-pred; *create each variable;
   keep Z A B C D E F pred res; *choose the variables to keep;
run;
*Part i;
proc standard data=question3 mean=0 std=1 out=resquestion3;
  var res ;
RUN;
*Part ii;
 title 'First 3 Observations in New Question 3 Dataset';
proc print data =resquestion3 (firstobs=1 obs=3);
run;
*part iii;
proc sgplot data= resquestion3;
	scatter x=pred y=z / markerattrs=(symbol=circlefilled); *set variables to axis;
	xaxis label='pred'; *renaming x axis;
	yaxis label='Z'; *renaming y axis;
	reg x=pred y=z; *create linear estimate line on plot;
	xaxis min=0 max=20; *set x axis;
	yaxis min=-50 max=12500;*set yaxis;
	title 'Scatter Plot of Z vs Pred';
run;
*Part iv;
proc sgplot data= resquestion3;
	scatter x=pred y=res / markerattrs=(symbol=circlefilled); *set variables to axis;
	xaxis label='pred'; *renaming x axis;
	yaxis label='res'; *renaming y axis;
	refline 0 / axis = y; *make line at y=0;
	xaxis min=0 max=20; *set x axis;
	yaxis min=-2 max=4;*set yaxis;
	title 'Scatter Plot of Res vs Pred';
run;

*Part B;
data question3b;
  set MIDTERM.question3; *set data in library;
   Z=log(Y);
   A=7;
   B=2 * x1;
   C= -1 / x2;
   D= -3 * x3;
   E= 4 * x1 * x2;
   F= sqrt(x5);
   pred= A + B + C + D + E + F;
   res= Z-pred; *create each variable;
   keep Z A B C D E F pred res; *choose the variables to keep;
run;
*Part i b;
proc standard data=question3b mean=0 std=1 out=resquestion3b;
  var res ;
RUN;
*Part ii b;
 title 'First 3 Observations in New Question 3 B Dataset';
proc print data =resquestion3b (firstobs=1 obs=3);
run;
*part iii b;
proc sgplot data= resquestion3b;
	scatter x=pred y=z / markerattrs=(symbol=circlefilled); *set variables to axis;
	xaxis label='pred'; *renaming x axis;
	yaxis label='Z'; *renaming y axis;
	reg x=pred y=z; *create linear estimate line on plot;
	
	title 'Scatter Plot of Z vs Pred Part B';
run;
*Part iv b;
proc sgplot data= resquestion3b;
	scatter x=pred y=res / markerattrs=(symbol=circlefilled); *set variables to axis;
	xaxis label='pred'; *renaming x axis;
	yaxis label='res'; *renaming y axis;
	refline 0 / axis = y; *make line at y=0;
	
	title 'Scatter Plot of Res vs Pred Part B';
run;
