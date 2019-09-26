**Data Wrangling on Dallas Crime data**
=======================================

### Load the data into a dataframe - crimedata

### Let's have a look at the structure of the dataset

    summary(crimedata)
    ##  Incident Number w/year Year of Incident      Service Number ID 
    ##  216100-2017:   139     Min.   :2005     000001-2019-01:     1  
    ##  107406-2019:    24     1st Qu.:2015     000002-2015-01:     1  
    ##  073944-2016:    23     Median :2017     000002-2018-01:     1  
    ##  246967-2018:    18     Mean   :2017     000002-2019-01:     1  
    ##  080577-2019:    17     3rd Qu.:2018     000003-2017-01:     1  
    ##  018178-2019:    16     Max.   :2109     000003-2017-02:     1  
    ##  (Other)    :586043                      (Other)       :586274  
    ##      Watch                        Call (911) Problem
    ##  Min.   :1.000   58 - ROUTINE INVESTIGATION: 69581  
    ##  1st Qu.:1.000   11V - BURG MOTOR VEH      : 60497  
    ##  Median :2.000   6X - MAJOR DIST (VIOLENCE): 43985  
    ##  Mean   :1.913   11R - BURG OF RES         : 33947  
    ##  3rd Qu.:3.000   09V - UUMV                : 31054  
    ##  Max.   :3.000   09 - THEFT                : 26358  
    ##                  (Other)                   :320858  
    ##                                    Type of Incident 
    ##  BMV                                       : 63309  
    ##  UNAUTHORIZED USE OF MOTOR VEH - AUTOMOBILE: 27994  
    ##  BURGLARY OF HABITATION - FORCED ENTRY     : 22673  
    ##  FOUND PROPERTY (NO OFFENSE)               : 21076  
    ##  PUBLIC INTOXICATION                       : 18564  
    ##  CRIM MISCHIEF >OR EQUAL $100 BUT <$750    : 16830  
    ##  (Other)                                   :415834  
    ##                             Type  Location  
    ##  Highway, Street, Alley ETC        :111262  
    ##  Single Family Residence - Occupied: 70380  
    ##  Apartment Parking Lot             : 51114  
    ##  Parking Lot (All Others)          : 47110  
    ##  Outdoor Area Public/Private       : 38288  
    ##  Apartment Complex/Building        : 35454  
    ##  (Other)                           :232672  
    ##                              Type of Property 
    ##  N/A                                 :444555  
    ##  Motor Vehicle                       : 27346  
    ##  Other                               : 19416  
    ##  Residential Property Occupied/Vacant: 17761  
    ##  Apartment Complex/Building          : 17686  
    ##  Parking Lot                         : 14453  
    ##  (Other)                             : 45063  
    ##                Incident Address  Apartment Number Reporting Area
    ##                        :  3456          :468057   Min.   :1001  
    ##  1400 S LAMAR ST       :  2618   100    :  1366   1st Qu.:1248  
    ##  1600 CHESTNUT ST      :  1697   A      :  1229   Median :3058  
    ##  8687 N CENTRAL EXPY   :  1496   101    :  1181   Mean   :3134  
    ##  8008 HERB KELLEHER WAY:  1131   102    :  1024   3rd Qu.:4317  
    ##  9301 FOREST LN        :   936   103    :   933   Max.   :9611  
    ##  (Other)               :574946   (Other):112490   NA's   :715   
    ##       Beat                Division         Sector      Council District
    ##  Min.   :  3.0   NORTHEAST    :97289   Min.   :  0.0   D2     : 66433  
    ##  1st Qu.:237.0   SOUTHEAST    :92362   1st Qu.:230.0   D6     : 60814  
    ##  Median :416.0   CENTRAL      :88025   Median :410.0   D7     : 60576  
    ##  Mean   :414.2   SOUTHWEST    :87249   Mean   :410.2   D14    : 53776  
    ##  3rd Qu.:552.0   NORTHWEST    :83901   3rd Qu.:550.0   D8     : 51105  
    ##  Max.   :757.0   SOUTH CENTRAL:78327   Max.   :750.0   D4     : 45987  
    ##  NA's   :213     (Other)      :59127   NA's   :128     (Other):247589  
    ##           Target Area Action Grids
    ##                       :368249     
    ##  WebbChapel Timberline: 12387     
    ##  Five Points          : 12326     
    ##  Ross Bennett         : 11838     
    ##  Forest Audelia       : 10733     
    ##  Monument GoodLatimer : 10371     
    ##  (Other)              :160376     
    ##                                 Community      Date1 of Occurrence
    ##                                      :478293   08/03/2018:   624  
    ##  Northwest_PFA                       :  7764   09/01/2018:   623  
    ##  Northwest_PFA, Bachman Lake_PFA     :  7452   07/13/2018:   617  
    ##  FivePoints_PFA, Vickery Meadows_PFA :  7303   08/04/2018:   575  
    ##  Chaucer_PFA                         :  6766   07/02/2018:   573  
    ##  Garrett Park PFA, BryanHenderson_PFA:  5868   07/06/2018:   572  
    ##  (Other)                             : 72834   (Other)   :582696  
    ##  Year1 of Occurrence Month1 of Occurence Day1 of the Week
    ##  Min.   :1974        July     : 64858    Fri    :89608   
    ##  1st Qu.:2015        June     : 57497    Sat    :87054   
    ##  Median :2017        August   : 53735    Sun    :83392   
    ##  Mean   :2017        May      : 49422    Mon    :83120   
    ##  3rd Qu.:2018        October  : 47271    Thu    :82186   
    ##  Max.   :2019        September: 46584    Wed    :80548   
    ##  NA's   :2           (Other)  :266913    (Other):80372   
    ##  Time1 of Occurrence Day1 of the Year Date2 of Occurrence
    ##  00:00  : 20357      Min.   :  1.0    07/13/2018:   612  
    ##  22:00  : 15692      1st Qu.:101.0    08/03/2018:   612  
    ##  18:00  : 15483      Median :186.0    07/02/2018:   582  
    ##  20:00  : 13982      Mean   :184.2    08/24/2018:   566  
    ##  17:00  : 13811      3rd Qu.:268.0    09/01/2018:   559  
    ##  12:00  : 13438      Max.   :366.0    08/05/2018:   558  
    ##  (Other):493517      NA's   :2        (Other)   :582791  
    ##  Year2 of Occurrence Month2 of Occurence Day2 of the Week
    ##  Min.   :1984        July     : 65121    Mon    :88036   
    ##  1st Qu.:2015        June     : 57453    Fri    :85688   
    ##  Median :2017        August   : 54007    Sat    :83984   
    ##  Mean   :2017        May      : 49115    Sun    :83642   
    ##  3rd Qu.:2018        October  : 47282    Thu    :82122   
    ##  Max.   :2019        September: 46541    Tue    :81647   
    ##  NA's   :2           (Other)  :266761    (Other):81161   
    ##  Time2 of Occurrence Day2 of the Year                Date of Report  
    ##  08:00  : 15253      Min.   :  1.0    09/21/2017 03:38:00 AM:   139  
    ##  07:00  : 12254      1st Qu.:101.0    05/29/2019 12:31:00 PM:    26  
    ##  00:00  : 11554      Median :186.0    09/14/2018 09:41:00 AM:    26  
    ##  09:00  : 11291      Mean   :184.2    07/29/2019 09:00:00 AM:    25  
    ##  10:00  : 10716      3rd Qu.:267.0    03/28/2016 06:05:00 AM:    23  
    ##  12:00  :  9685      Max.   :366.0    10/22/2017 10:01:00 PM:    23  
    ##  (Other):515527      NA's   :2        (Other)               :586018  
    ##             Date incident created Offense Entered Year
    ##  09/21/2017 02:26:02 AM:   139    Min.   :2014        
    ##  05/29/2019 01:47:11 PM:    24    1st Qu.:2015        
    ##  03/28/2016 06:39:48 PM:    23    Median :2017        
    ##  07/11/2019 04:36:44 PM:    19    Mean   :2017        
    ##  11/14/2018 05:24:09 PM:    18    3rd Qu.:2018        
    ##  01/27/2019 04:29:46 PM:    17    Max.   :2019        
    ##  (Other)               :586040                        
    ##  Offense Entered Month Offense Entered Day of the Week
    ##  July     : 65287      Fri:86048                      
    ##  June     : 57582      Mon:91412                      
    ##  August   : 54311      Sat:79640                      
    ##  May      : 48642      Sun:78255                      
    ##  October  : 47263      Thu:83550                      
    ##  September: 46614      Tue:83902                      
    ##  (Other)  :266581      Wed:83473                      
    ##  Offense Entered Time Offense Entered  Date/Time      CFS Number    
    ##  16:55  :   810       Min.   :  1                          :  3113  
    ##  16:58  :   804       1st Qu.:100                17-1798291:   139  
    ##  16:59  :   795       Median :186                15-2011150:    51  
    ##  16:49  :   787       Mean   :184                17-2012378:    45  
    ##  16:54  :   774       3rd Qu.:267                15-1958964:    40  
    ##  17:01  :   774       Max.   :366                17-2002855:    39  
    ##  (Other):581536                                  (Other)   :582853  
    ##            Call Received Date Time                Call Date Time  
    ##                        :  3113                           :  3113  
    ##  09/21/2017 02:25:13 AM:   139     09/21/2017 02:25:13 AM:   139  
    ##  10/03/2015 12:40:30 PM:    51     10/03/2015 12:40:30 PM:    51  
    ##  10/22/2017 03:12:36 PM:    45     10/22/2017 03:12:36 PM:    45  
    ##  09/26/2015 06:05:17 AM:    40     09/26/2015 06:05:17 AM:    40  
    ##  10/21/2017 07:33:41 AM:    39     10/21/2017 07:33:41 AM:    39  
    ##  (Other)               :582853     (Other)               :582853  
    ##             Call Cleared Date Time           Call Dispatch Date Time
    ##                        :  3484                           :  3168    
    ##  09/21/2017 08:47:02 PM:   139     09/21/2017 02:25:14 AM:   139    
    ##  10/06/2015 11:40:38 AM:    51     10/03/2015 12:40:30 PM:    51    
    ##  10/22/2017 03:17:18 PM:    45     10/22/2017 03:12:53 PM:    45    
    ##  09/29/2015 08:03:24 AM:    40     09/26/2015 06:05:18 AM:    40    
    ##  10/21/2017 07:57:13 AM:    39     10/21/2017 07:33:59 AM:    39    
    ##  (Other)               :582482     (Other)               :582798    
    ##                    Special Report (Pre-RMS)        Person Involvement Type
    ##                                :583048      Victim             :541085    
    ##  State Fair (Inside Fair)      :  1199                         : 21060    
    ##  RMS-System Dark               :   871      Registered Owner   : 20743    
    ##  State Fair                    :   339      Owner              :  2383    
    ##  Alan Ross Texas Freedom Parade:   322      Stln Vehicle (UUMV):   610    
    ##  Fireworks At River Bottoms    :   161      Driver             :   320    
    ##  (Other)                       :   340      (Other)            :    79    
    ##                Victim Type             Victim Name    
    ##  Individual          :349919   CITY OF DALLAS:101340  
    ##  Government          : 85823                 : 24523  
    ##  Business            : 85534   WALMART       :  1003  
    ##  Society/Public      : 34432   7-11          :   979  
    ##                      : 29320   ONCOR         :   768  
    ##  Religious Organizati:   485   (Other)       :457666  
    ##  (Other)             :   767   NA's          :     1  
    ##              Victim Race                   Victim Ethnicity 
    ##                    :230987                         :227437  
    ##  Black             :120312   Hispanic or Latino    :112821  
    ##  Hispanic or Latino:112828   Non-Hispanic or Latino:245339  
    ##  White             :107337   Unknown               :   683  
    ##  Asian             :  5880                                  
    ##  Middle Eastern    :  4950                                  
    ##  (Other)           :  3986                                  
    ##  Victim Gender      Victim Age     Victim Age at Offense
    ##         :230812   Min.   : -9.00   Min.   :  0.0        
    ##  Female :160870   1st Qu.: 28.00   1st Qu.: 27.0        
    ##  Male   :193216   Median : 37.00   Median : 37.0        
    ##  N      :     1   Mean   : 39.91   Mean   : 39.7        
    ##  TEST   :    11   3rd Qu.: 50.00   3rd Qu.: 50.0        
    ##  Unknown:  1370   Max.   :934.00   Max.   :934.0        
    ##                   NA's   :249099   NA's   :254542       
    ##             Victim Home Address Victim Apartment Victim Zip Code 
    ##                       : 36382          :434438          : 43628  
    ##  725 N JIM MILLER RD  : 13528   101    :  1349   75217  : 37018  
    ##  9915 E NORTHWEST HWY : 10815   A      :  1324   75211  : 25321  
    ##  334 S HALL ST        : 10418   102    :  1228   75220  : 24926  
    ##  1999 E CAMP WISDOM RD: 10027   B      :  1145   75241  : 20470  
    ##  9801 HARRY HINES BLVD:  9643   103    :  1129   75216  : 20246  
    ##  (Other)              :495467   (Other):145667   (Other):414671  
    ##    Victim City      Victim State        Victim Business Name
    ##  DALLAS  :459322   TX     :533835                 :562547   
    ##          : 37037          : 41860   SELF          :   807   
    ##  GARLAND :  6064   OK     :  1375   UNEMPLOYED    :   711   
    ##  MESQUITE:  5465   LA     :   863   CITY OF DALLAS:   606   
    ##  IRVING  :  5249   CA     :   843   SELF EMPLOYED :   535   
    ##  PLANO   :  3611   AR     :   669   (Other)       : 21068   
    ##  (Other) : 69532   (Other):  6835   NA's          :     6   
    ##            Victim Business Address Victim Business Phone
    ##                        :570508               :578154    
    ##  9915 E NORTHWEST HWY  :    73     2146704415:    54    
    ##  1400 S LAMAR ST       :    70     2146708345:    43    
    ##  1500 MARILLA ST       :    66     2146704413:    38    
    ##  8008 HERB KELLEHER WAY:    60     2146707470:    35    
    ##  (Other)               : 15502     2146714500:    28    
    ##  NA's                  :     1     (Other)   :  7928    
    ##  Responding Officer #1  Badge No               Responding Officer #1  Name
    ##  94392  :  7968                  WILLIS,LINDA,M              :  7968      
    ##  118918 :  4599                                              :  4876      
    ##         :  4054                  SPURR,RUTH                  :  4599      
    ##  106291 :  3669                  BELAYE,DIANE,KAY            :  3669      
    ##  120365 :  3467                  BURNETT,MICHELLE,J          :  3467      
    ##  6751   :  1509                  CAMPOPIANO III,PAUL,PASQUELE:  1509      
    ##  (Other):561014                  (Other)                     :560192      
    ##  Responding Officer #2 Badge No        Responding Officer #2  Name
    ##         :364750                                      :364751      
    ##  6700   :   656                 FRANCIS JR,GEORGE    :   656      
    ##  7270   :   606                 LEAL,JAIME           :   606      
    ##  10226  :   598                 MYTYCH,CLAYTON,ROSS  :   598      
    ##  6614   :   579                 WILKERSON,ROBERT,C   :   579      
    ##  9738   :   575                 CAMPBELL,DANIEL,DAVID:   575      
    ##  (Other):218516                 (Other)              :218515      
    ##  Reporting Officer Badge No Assisting Officer Badge No
    ##  94392  :  7977                    :162858            
    ##  118918 :  4608             5799   : 11425            
    ##  106291 :  3675             T168   : 10333            
    ##  120365 :  3472             T187   :  8295            
    ##         :  2647             T259   :  7538            
    ##  6751   :  1511             T270   :  6664            
    ##  (Other):562390             (Other):379167            
    ##  Reviewing Officer Badge No Element Number Assigned
    ##  81075  : 41142             EX07   :  7660         
    ##  15356  : 32589             OFFDTY :  6825         
    ##  105273 : 27351             EX06   :  4671         
    ##  111210 : 26991                    :  3644         
    ##  057074 : 25323             EX01   :  3326         
    ##  70495  : 25277             EX04   :  3288         
    ##  (Other):407607             (Other):556866         
    ##             Investigating Unit 1
    ##                       :172793   
    ##  Investigations       :373935   
    ##  Patrol               :  3401   
    ##  Strategic Development: 29250   
    ##  Support              :  6901   
    ##                                 
    ##                                 
    ##                                    Investigating Unit 2
    ##                                              :172768   
    ##  Special Investigations / Auto Theft         : 69622   
    ##  Property Crime Division / NE Property Crimes: 48299   
    ##  Property Crime Division / NW Property Crimes: 38035   
    ##  Property Crime Division / SW Property Crimes: 35764   
    ##  Property Crime Division / SC Property Crimes: 30468   
    ##  (Other)                                     :191324   
    ##                      Offense Status             UCR Disposition  
    ##  Suspended                  :452759   Suspended         :452793  
    ##  Clear by Arrest            : 88507   CBA (Over Age 17) : 82535  
    ##  Clear by Exceptional Arrest: 16562   CBEA (Over Age 17): 16068  
    ##  Open                       : 11073   Open              : 10986  
    ##                             : 10713                     : 10645  
    ##  Closed/Cleared             :  6637   Closed            :  6603  
    ##  (Other)                    :    29   (Other)           :  6650  
    ##  Victim Injury Description Victim Condition 
    ##          :556594                   :563693  
    ##  DECEASED:   450           Critical:   319  
    ##  PAIN    :   331           Deceased:  2921  
    ##  N       :   329           Good    : 13935  
    ##  NONE    :   226           N/A     :     1  
    ##  (Other) : 28348           Serious :   615  
    ##  NA's    :     2           Stable  :  4796  
    ##                 Modus Operandi (MO) Family Offense Hate Crime  
    ##                           : 24771        :  2004      :585606  
    ##  FOUND PROPERTY           :  9834   false:584276   No :   511  
    ##  PUBLIC INTOXICATION      :  3591                  Yes:   163  
    ##  INJURED PERSON           :  3104                              
    ##  CRIMINAL TRESPASS WARNING:  2847                              
    ##  (Other)                  :541944                              
    ##  NA's                     :   189                              
    ##                          Hate Crime Description     Weapon Used    
    ##  None                               :561517     Other     :247058  
    ##  Unknown                            : 23488               :197060  
    ##                                     :   852     None      : 53858  
    ##  Anti White                         :   108     Hands-Feet: 32691  
    ##  Anti Black Or African American     :    63     Handgun   : 27955  
    ##  Anti Homosexual (Gays and Lesbians):    51     Vehicle   :  5181  
    ##  (Other)                            :   201     (Other)   : 22477  
    ##  Gang Related Offense Victim Package Drug Related Istevencident
    ##     :193846           Mode:logical          :  2060            
    ##  G  :   408           NA's:586280    2      :     1            
    ##  J  :    54                          3      :     2            
    ##  No :331810                          No     :500451            
    ##  UNK: 58582                          UNK    : 64025            
    ##  Yes:  1580                          Unknown:    12            
    ##                                      Yes    : 19729            
    ##             RMS Code      Criminal Justice Information Service Code
    ##  MA-22990004-F1 : 63309   Min.   : 9990017                         
    ##  FS-24110003-G1 : 27994   1st Qu.:22990004                         
    ##  F2-22990002-E5 : 22673   Median :29990002                         
    ##  NA-99999999-X3 : 21076   Mean   :50969864                         
    ##  MB-29990016-L82: 16830   3rd Qu.:99999999                         
    ##  FS-22990001-E1 : 16225   Max.   :99999999                         
    ##  (Other)        :418173                                            
    ##           Penal Code                      UCR Offense Name 
    ##  PC 30.04(a)   : 67923                            :177068  
    ##  No Offense    : 60237   THEFT/BMV                : 63907  
    ##  PC 31.07      : 42330   VANDALISM & CRIM MISCHIEF: 55605  
    ##  PC 28.03(b)(2): 34390   FOUND                    : 37877  
    ##  PC 30.02(c)(2): 34260   OTHER THEFTS             : 32483  
    ##  PC 30.02(c)(1): 20115   UUMV                     : 30893  
    ##  (Other)       :327025   (Other)                  :188447  
    ##                 UCR Offense Description    UCR Code     
    ##                             :177068     Min.   : 110    
    ##  THEFT                      :105614     1st Qu.: 630    
    ##  CRIMINAL MISCHIEF/VANDALISM: 55605     Median : 710    
    ##  BURGLARY                   : 44491     Mean   :1420    
    ##  FOUND PROPERTY             : 37877     3rd Qu.:2100    
    ##  AUTO THEFT - UUMV          : 30893     Max.   :5700    
    ##  (Other)                    :134732     NA's   :177068  
    ##     Offense Type                                        NIBRS Crime    
    ##           :177068                                             :259103  
    ##  NOT CODED: 63634   MISCELLANEOUS                             : 83310  
    ##  PART1    :200909   THEFT FROM MOTOR VEHICLE                  : 31027  
    ##  PART2    :144669   DESTRUCTION/ DAMAGE/ VANDALISM OF PROPERTY: 27733  
    ##                     UUMV                                      : 23736  
    ##                     ALL OTHER LARCENY                         : 20763  
    ##                     (Other)                                   :140608  
    ##                                  NIBRS Crime Category
    ##                                            :259103   
    ##  MISCELLANEOUS                             : 83310   
    ##  LARCENY/ THEFT OFFENSES                   : 67886   
    ##  DESTRUCTION/ DAMAGE/ VANDALISM OF PROPERTY: 27733   
    ##  ASSAULT OFFENSES                          : 26474   
    ##  BURGLARY/ BREAKING & ENTERING             : 24857   
    ##  (Other)                                   : 96917   
    ##                        NIBRS Crime Against   NIBRS Code     NIBRS Group
    ##                                  :259103          :259103    :259103   
    ##  C - PERSON, PROPERTY, OR SOCIETY:  9503   999    : 92813   A:202355   
    ##  MISCELLANEOUS                   : 83310   23F    : 31027   B: 32009   
    ##  PERSON                          : 26869   290    : 27733   C: 19849   
    ##  PERSON, PROPERTY, OR SOCIETY    : 11054   220    : 24857   D: 72964   
    ##  PROPERTY                        :164733   240    : 23736              
    ##  SOCIETY                         : 31708   (Other):127011              
    ##      NIBRS Type                          Update Date      X Coordinate    
    ##           :259103   2017-09-21 18:11:03.0000000:   139   Min.   :2415424  
    ##  Coded    :193763   2019-07-21 10:51:51.0000000:    24   1st Qu.:2478578  
    ##  No Coded : 60450   2016-03-30 09:51:18.0000000:    23   Median :2493689  
    ##  Not Coded: 72964   2018-12-12 08:52:14.0000000:    18   Mean   :2494751  
    ##                     2019-04-30 08:00:34.0000000:    17   3rd Qu.:2507320  
    ##                     2017-03-10 10:09:53.0000000:    16   Max.   :2590096  
    ##                     (Other)                    :586043   NA's   :3835     
    ##   Y Cordinate         Zip Code           City            State       
    ##  Min.   :6901369   Min.   :    0   DALLAS  :576137   TX     :580456  
    ##  1st Qu.:6954801   1st Qu.:75214           :  5305          :  5453  
    ##  Median :6974741   Median :75224   Dallas  :  3683   T      :   218  
    ##  Mean   :6977629   Mean   :75224   GARLAND :   137   TN     :    77  
    ##  3rd Qu.:7001175   3rd Qu.:75235   MESQUITE:    98   UT     :    30  
    ##  Max.   :7087257   Max.   :97224   ROWLETT :    76   DE     :    12  
    ##  NA's   :3835      NA's   :3714    (Other) :   844   (Other):    34  
    ##                                                            Location1     
    ##                                                                 :  3456  
    ##  1400 S LAMAR ST\nDALLAS, TX 75215\n(32.767362, -96.795092)     :  2612  
    ##  1600 CHESTNUT ST\nDALLAS, TX 75226\n(32.780825, -96.777351)    :  1632  
    ##  8687 N CENTRAL EXPY\nDALLAS, TX 75225\n(32.86875, -96.770691)  :  1471  
    ##  8008 HERB KELLEHER WAY\nDALLAS, TX 75235\n(32.85262, -96.85281):  1106  
    ##  9301 FOREST LN\nDALLAS, TX 75243\n(32.909205, -96.740013)      :   928  
    ##  (Other)                                                        :575075

It is clear from the structure of the data, that there are 586280
observations (rows) of 100 variables(columns).

    colnames(crimedata)
    ##   [1] "Incident Number w/year"                   
    ##   [2] "Year of Incident"                         
    ##   [3] "Service Number ID"                        
    ##   [4] "Watch"                                    
    ##   [5] "Call (911) Problem"                       
    ##   [6] "Type of Incident"                         
    ##   [7] "Type  Location"                           
    ##   [8] "Type of Property"                         
    ##   [9] "Incident Address"                         
    ##  [10] "Apartment Number"                         
    ##  [11] "Reporting Area"                           
    ##  [12] "Beat"                                     
    ##  [13] "Division"                                 
    ##  [14] "Sector"                                   
    ##  [15] "Council District"                         
    ##  [16] "Target Area Action Grids"                 
    ##  [17] "Community"                                
    ##  [18] "Date1 of Occurrence"                      
    ##  [19] "Year1 of Occurrence"                      
    ##  [20] "Month1 of Occurence"                      
    ##  [21] "Day1 of the Week"                         
    ##  [22] "Time1 of Occurrence"                      
    ##  [23] "Day1 of the Year"                         
    ##  [24] "Date2 of Occurrence"                      
    ##  [25] "Year2 of Occurrence"                      
    ##  [26] "Month2 of Occurence"                      
    ##  [27] "Day2 of the Week"                         
    ##  [28] "Time2 of Occurrence"                      
    ##  [29] "Day2 of the Year"                         
    ##  [30] "Date of Report"                           
    ##  [31] "Date incident created"                    
    ##  [32] "Offense Entered Year"                     
    ##  [33] "Offense Entered Month"                    
    ##  [34] "Offense Entered Day of the Week"          
    ##  [35] "Offense Entered Time"                     
    ##  [36] "Offense Entered  Date/Time"               
    ##  [37] "CFS Number"                               
    ##  [38] "Call Received Date Time"                  
    ##  [39] "Call Date Time"                           
    ##  [40] "Call Cleared Date Time"                   
    ##  [41] "Call Dispatch Date Time"                  
    ##  [42] "Special Report (Pre-RMS)"                 
    ##  [43] "Person Involvement Type"                  
    ##  [44] "Victim Type"                              
    ##  [45] "Victim Name"                              
    ##  [46] "Victim Race"                              
    ##  [47] "Victim Ethnicity"                         
    ##  [48] "Victim Gender"                            
    ##  [49] "Victim Age"                               
    ##  [50] "Victim Age at Offense"                    
    ##  [51] "Victim Home Address"                      
    ##  [52] "Victim Apartment"                         
    ##  [53] "Victim Zip Code"                          
    ##  [54] "Victim City"                              
    ##  [55] "Victim State"                             
    ##  [56] "Victim Business Name"                     
    ##  [57] "Victim Business Address"                  
    ##  [58] "Victim Business Phone"                    
    ##  [59] "Responding Officer #1  Badge No"          
    ##  [60] "Responding Officer #1  Name"              
    ##  [61] "Responding Officer #2 Badge No"           
    ##  [62] "Responding Officer #2  Name"              
    ##  [63] "Reporting Officer Badge No"               
    ##  [64] "Assisting Officer Badge No"               
    ##  [65] "Reviewing Officer Badge No"               
    ##  [66] "Element Number Assigned"                  
    ##  [67] "Investigating Unit 1"                     
    ##  [68] "Investigating Unit 2"                     
    ##  [69] "Offense Status"                           
    ##  [70] "UCR Disposition"                          
    ##  [71] "Victim Injury Description"                
    ##  [72] "Victim Condition"                         
    ##  [73] "Modus Operandi (MO)"                      
    ##  [74] "Family Offense"                           
    ##  [75] "Hate Crime"                               
    ##  [76] "Hate Crime Description"                   
    ##  [77] "Weapon Used"                              
    ##  [78] "Gang Related Offense"                     
    ##  [79] "Victim Package"                           
    ##  [80] "Drug Related Istevencident"               
    ##  [81] "RMS Code"                                 
    ##  [82] "Criminal Justice Information Service Code"
    ##  [83] "Penal Code"                               
    ##  [84] "UCR Offense Name"                         
    ##  [85] "UCR Offense Description"                  
    ##  [86] "UCR Code"                                 
    ##  [87] "Offense Type"                             
    ##  [88] "NIBRS Crime"                              
    ##  [89] "NIBRS Crime Category"                     
    ##  [90] "NIBRS Crime Against"                      
    ##  [91] "NIBRS Code"                               
    ##  [92] "NIBRS Group"                              
    ##  [93] "NIBRS Type"                               
    ##  [94] "Update Date"                              
    ##  [95] "X Coordinate"                             
    ##  [96] "Y Cordinate"                              
    ##  [97] "Zip Code"                                 
    ##  [98] "City"                                     
    ##  [99] "State"                                    
    ## [100] "Location1"

We will select only the variables that are needed for the analysis.

### Select only the columns that are needed for the analysis

    crimedata <- crimedata %>% select(`Incident Number w/year`,`Year of Incident`,`Type of Incident`,Beat,Division, `Type of Property`,`Date1 of Occurrence`,`Month1 of Occurence`,`Time1 of Occurrence`,`Day1 of the Week`,`Day1 of the Year`,`Victim Age`,`Victim Gender`, `Offense Status`, `UCR Offense Name`, `Victim Condition`, `Weapon Used`)

Now with the selected varaibles, let us clean the data and make it ready
for analysis.

This dataset is supposed to have the crime reports from June 2014 till
August 2019.

### Year cannot be more the 2019.

    current_year <- as.integer(format(Sys.Date(), "%Y"))
    crimedata$`Year of Incident`[crimedata$`Year of Incident`> current_year] = current_year

### Remove rows with `Year of Incident` 2005,2009,2010,2011,2013

    crimedata <- crimedata %>% filter(`Year of Incident` %!in% c(2005, 2009, 2010, 2011, 2013))

### Age - Reset values greater than 125 to 125

    crimedata$`Victim Age`[crimedata$`Victim Age` > 125 ] = 125

### Age - Age cannot be a negative value.

    crimedata$`Victim Age` <- ifelse(crimedata$`Victim Age`< 0 , abs(crimedata$`Victim Age`) , crimedata$`Victim Age`)

### Division - Change all the values to Upper case and handle missing values

    tmp <- crimedata %>% mutate(new_division = toupper(Division))
    crimedata$Division <- tmp$new_division

### Day of the Year - Handle missing values. Set Outliers. Values cannot be more than 366

    crimedata$`Day1 of the Year`[which(is.na(crimedata$`Day1 of the Year`))] = 0
    crimedata$`Day1 of the Year`[which(crimedata$`Day1 of the Year` > 366)] = 366

### Find the Season of the Year i.e., Summer/Winter/Fall/Spring

    crimedata <- crimedata %>% mutate(Season = ifelse(`Month1 of Occurence` %in% c("March", "April", "May"), "Spring", 
                                         ifelse(`Month1 of Occurence`%in% c("June", "July", "August"), "Summer",
                                               ifelse(`Month1 of Occurence` %in% c("September", "October", "November"), "Fall",
                                                      ifelse(`Month1 of Occurence` %in% c("December", "January", "February"), "Winter", NA)))))

### Column - Incident Number w/year has both incident number and year. Remove year

    crimedata <- crimedata %>% mutate(`Incident Number` = sub("-.*", "", `Incident Number w/year`))

### Now drop the column "Incident Number w/year"

    crimedata <- crimedata %>% select(-`Incident Number w/year`)

### Extract the hour of the day when the crime took place.

    crimedata <- crimedata %>% mutate(`Hour of the Day` = sub(":.*", "",`Time1 of Occurrence`))

### Handle the missing values for the column Type of Property

    crimedata$`Type of Property`[which(crimedata$`Type of Property` == "")] = NA

### Type of Property cannot have numeric values

    crimedata$`Type of Property` <- droplevels(crimedata$`Type of Property`, exclude = c(910,920,932,510))

### Group similar offense types

    crimedata$`Crime Type` <- crimedata$`UCR Offense Name`
    crimedata$`Crime Type` <- as.character(crimedata$`Crime Type`)

    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ASSAULT", "AGG ASSAULT - NFV"))] = "ASSAULT"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("BURGLARY-BUSINESS", "BURGLARY-RESIDENCE"))] = "BURGLARY"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("THEFT/BMV", "THEFT/SHOPLIFT", "OTHER THEFTS", "THEFT ORG RETAIL", "EMBEZZLEMENT"))] = "THEFT"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ROBBERY-BUSINESS", "ROBBERY-INDIVIDUAL"))] = "ROBBERY"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("ACCIDENT MV", "MOTOR VEHICLE ACCIDENT"))] = "ACCIDENT"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("NARCOTICS & DRUGS", "DRUNK & DISORDERLY", "DWI", "LIQUOR OFFENSE", "INTOXICATION MANSLAUGHTER"))] = "DRUGS"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("TRAFFIC VIOLATION", "TRAFFIC FATALITY"))] = "TRAFFIC"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("MURDER", "SUDDEN DEATH&FOUND BODIES", "VANDALISM & CRIM MISCHIEF", "WEAPONS", "ARSON", "TERRORISTIC THREAT", "KIDNAPPING", "HUMAN TRAFFICKING", "OFFENSE AGAINST CHILD", "ORANIZED CRIME"))] = "VIOLENCE"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("DISORDERLY CONDUCT" ,"CRIMINAL TRESPASS", "EVADING", "RESIST ARREST", "FAIL TO ID", "GAMBLING", "ESCAPE", "FRAUD", "UUMV", "FORGE & COUNTERFEIT"))] = "NONVIOLENCE"
    crimedata$`Crime Type`[which(crimedata$`Crime Type` %in% c("NOT CODED", "LOST", "ANIMAL BITE", "OTHERS", "FOUND", "INJURED FIREARM", "INJURED HOME", "INJURED OCCUPA", "INJURED PUBLIC"))] = "OTHERS"

### Write the cleaned dataset to a file.

write.csv(crimedata, output\_file, row.names = FALSE)
