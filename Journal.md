# Journal 

## Legend
C = Challange 
P = Progress
D = Design
S = Solution
E = Error
A = Action
N = Note


### July 7th, 2018

#### 09:56:45

				*A 00002*

				Adding a user login page. In order to do so, a table of users must be
				made. The test script has to be updated.

### July 7th, 2018

#### 16:32:53
				
				*C 0001*

				The array of raw tables selected must be passed to ui.R. ui.R needs to
				know what raw tables to render. i

#### 15:08:59

				Started building the function step by step. First all hardcoded valuse.
				Then slowly adding things such as inputs, lapply, and multiple reactive
				variables.

#### 14:25:17

				It feels like I am going in circles.

### July 5th, 2018

#### 17:57:05

				Everytime it says the error 'Data must be 2-dimension', it is thrown by
				the function 'renderDataTable'.

#### 08:37:22

				The raw tables are proving to be a challenge to display independently.
				The raw tables should be stored in a reactive variable. That reactive
				variable shoulde be passed to an output. That output should be
				displayed. This is the train of logic I will attempt to follow.

#### 06:39:27

				Continue investigating the cause of the non-updating dataviewer in the
				'1. Explore Database' section. I've created a reactive variable that
				contians the datatables with data from the database. 

### July 3rd, 2018

#### 20:05:54

*E 00002*

				The raw tables from the database were displayed using an observe
				function. This function has problem retro-actively updating the display.


*N 00003* 
		
				Continue implementing the reactive model. I am currently in the '1.
				Explore Database'. The data viewer is not display each table
				independently. 


#### 14:04:54

Continue

#### 13:56:09 
pause
#### 13:51:52

				The index array now works. Now, I will format it according to the
				consistent naming convention. 

Continue 


#### 12:12:05
Pause


#### 11:51:04

*S 00001: E 00001* 



#### 11:10:18

*E 00001* 

				The index reactive variable index 'dbTables$indexSelectedDbTables'
				doesn't work. 

*N 00002*

				Currently, I'm started making everything I can reactive. Once I need to
				display something I simply make it an output variable. The latest
				reactive variable is an index of the array of all tables. 

#### 06:32:35 

*T 00001:A 00001*
				First, I will create a dummy test variable that will take a user input
				to generate a string. 

				Second, I will create a dummy test reactive variable that contains a string


*A 00001* 

				The full query exists as a 2D list in an output variable.
					ex. "select * from test_cloacina_table_1 limit 1"
				For utiliy, the full query should be stored into a reactive variable.


#### 06:29:16 

*N 00001* 

				A datatable from the database can be queried for into a reactive
				variable which can then be displayed works. The source of the error is
				in the use of 'input$query'. An input variable with the query string. 



### July 2nd, 2018

## 0f07f49

#### 20:41:39 

				Goal: Find a way to put the datatable outputted by the import_data
				function into a reactive variable.

#### 20:27:52 
				Reactive variables work to be displayed. Now, I will see if they can be
				displayed at two points at the same time.

				Result: Reactive variables can not be displayed from two places at one
				time. 

				Test: Can the reactive variable be passed to two different output
				variables?

				Result: Yes, a single reactive variable can be passed to two different
				output variable, both of which, can be displayed.


#### 17:14:49 
				If I attempt to use an output into places of the ui, then neither works.
			

#### 16:57:00
				Survey the code and pick up where we left off. In the tab '3. Transfer
				Data From Raw to Format", both tables don't display. My last main
				thought for displaying the raw table was to pass the code that did the
				same thing in '1. Explore Database'.


