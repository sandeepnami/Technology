************************************************************************************************************
Perfect spec PROG.DEV8.SPEC.LIBRARY(AF0341M0)
************************************************************************************************************

* if else condition
                 @~~~~~~~~~~~~~~¢               
              No |  Read input  |               
  **<************|  Transaction |               
 |               {~~~~~~~~~~~~~~}               
 |                      | Yes                
 .rc3 on                |-<**********************¢
 |  		  	  @~~~~~~~~~~~~~~¢       		   |
 |              No|  Device Type |                 |
 |    *<**********|  = OB 		 |                 |
 |	|			  {~~~~~~~~~~~~~~}                 |
 |  |                   | Yes                      |
 |  |                   |                          |
 |  |            @~~~~~~~~~~~~~~¢                  |
 |  |           |  Call        |-**********¢       |
 |  |  			|  AF0001M0    |            |      |
 |  |           {~~~~~~~~~~~~~~}            |      |
 |  |                                       |      |
 |  |                                       |      |
 .rc3 off                                   |      |
 |  |                                       |      |
 |  |                                       |      |
 |  |                                       |      |
 |  |             @~~~~~~~~~~~~~~¢          |      |
 |  |             |  Call        |          |      |
 |   **********>**|  AF0000M0    |          |      |
 |                |              |          |      |
 |                {~~~~~~~~~~~~~~}          |      |
 |                      |                   |      |                                                          
 |               @~~~~~~~~~~~~~~¢           |      |
 |               |  Read More   |****************>-}  
 |               |  Transaction |  YES             
 |               {~~~~~~~~~~~~~~}                  
 |                      | No                       
 |                      |                          
 |                      |                          
 |               @~~~~~~~~~~~~~~¢                  
  ************>**|  FINISH      |                  
                 {~~~~~~~~~~~~~~}               
                                          
************************************************************************************************************
*representation of copybooks note last qualifier of copubook is eliminated
:ul.                                                              
:li.:hp2.S107315 ¬PRD for Old Messages (redefines GR07517):ehp2.  
.rc 1 on                                 
:li.:hp2.S160147 ¬Input Message:ehp2.    
:li.:hp2.S160148 ¬Input Message:ehp2.    
.rc 1 off                                
:eul.
************************************************************************************************************
*represntation of perform and move
*PERFORM 7190-RR0031M0-GET-RECIP-DETS
*MOVE EL06798-ACCT-RR0031M0-RTN TO EL06798-GR01518 
* "&EL06798."= "Letters Salutation Name" this reperesents the desctiption to be available on scriptitng the spec
:ul.                                                            
:li.Perform :hdref refid=obtsal.                                
:li.Set EL06798-GR01518 (&EL06798.) to EL06798-ACCT-RR0031M0-RTN
:eul.
************************************************************************************************************
*doubt ask sravani spec-AF0316M0
.rc 5 on                                  
:li.if EL19804 (&EL19804.) is 'A' or 'OB' 
.rc 5 off                                 
