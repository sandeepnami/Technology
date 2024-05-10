		1. Fetch only some rows
	SELECT DISTINCT TSN,YEAR,QUARTER,BRANCH,COMPANY,  
	 CLIENT_NAME,JURIS_ABBREV                         
	FROM DB20R03.TAX076_DEFERRALS                     
	ORDER BY TSN                                      
	FETCH FIRST 3000 ROWS ONLY                        
		2. Using substring: 
	SELECT SUBSTR(NAME,1,30) NAME,SUBSTR(TBNAME,1,30) TBNAME,
	           SUBSTR(CREATOR,1,10) CREATOR,                                                
	       TYPE,DBNAME,SUBSTR(REMARKS,1,30) REMARKS,PARENTS,                                  
	       CHILDREN,KEYCOLUMNS,STATUS
	FROM SYSIBM.SYSTABLES                              
	 WHERE CREATOR                        ='DB10K01' 
		3. Copy host variables in COBOL
	COPY DVTAX076 REPLACING ==:TAG:== BY ==TAX76==
	 
	COPY RCN0301W                                            
	   REPLACING ==01 RCN0301-PARMS== BY ==05 RCN0301-PARMS==
	             ==01 RCN0301== BY ==05 RCN0301==.           
		4. Finding primary key in a table 
		TSO DB2 K01 R17    -- WHERE K01 Is region and R17 is table
		5. QUERY using NOT equal to (<>)
		/*SQL IN PROGRAM MRP799*/                                            
		SELECT CIFC_DIV_ITM_CD ,CIFC_PC_NBR,CIFC_CREATE_TS ,CIFC_FSA_ELIG_CD 
		  FROM CID99D.CORP_ITM_FSA_CHGS                                      
		 WHERE CIFC_PC_NBR NOT IN ('89','03')                                
		 ORDER BY CIFC_DIV_ITM_CD, CIFC_CREATE_TS DESC                       
		;                                                                    
		                     
		
		6. Empty table with query
	DELETE statement without WHERE clause
	TRUNCATE TABLE table_name
	E.g. TRUNCATE TABLE DB20R03.TAX075_CRED_7200_INV 
	If there are access issues like -501 then try
	DELETE FROM DB20R03.TAX075_CRED_7200_INV
	 
		6. INSERT table from one table to another with same DB2ID
	/*INSERT ALL RECORDS                      
	INSERT INTO DB20S03.TAX075_CRED_7200_INV  
	SELECT * FROM DB20R03.TAX075_CRED_7200_INV
	;                                         
		7. Table Compare tool TSO $TCMPR
	X TO exclude fields
		8. Count distinct rows considering multiple columns in a table
	select count(*) from
    (select distinct col1, col2, col3 FROM table) t
	Or
	select count(distinct col1 || col2 || col3) from table
	 
	For single column
	Select col1, count(distinct col1) from tab1
		9. Date functions
	SELECT YEAR('1993-08-10-20.00.00'),   
	   MONTH('1993-08-10-20.00.00-08:00'),
	   DAY('1993-08-10-20.00.00+09:00')   
	  FROM SYSIBM.SYSDUMMY1;              
		10. Query 
	/*COUNT JOIN FOR TAX72 AND TAX75*/                                
	SELECT COUNT(*) FROM (                                            
	SELECT                                                            
	      REQ_BR_CO,ADV_CR_AMT,DATE(TAX72.CREATE_TS) TAX72_CREATE_TS, 
	      PROCESS_DATE,CHECK_DATE,IRS_7200_APPROVED_LOAN              
	FROM DB20R03.TAX075_CRED_7200_INV TAX75 INNER JOIN                
	             DB20R03.TAX072_IRS7200_ADV_CREDITS TAX72             
	ON TAX72.REQ_BR_CO=CONCAT(TAX75.BRANCH,TAX75.COMPANY) AND         
	   TAX72.EFF_CNTRY=SUBSTR(TAX75.YEAR,1,2) AND                     
	   TAX72.EFF_YR=SUBSTR(TAX75.YEAR,3,2) AND                        
	   TAX72.EFF_QTR=TAX75.QUARTER                                    
	WHERE FORM_TYP='7200' AND                                         
	     DATE(TAX72.CREATE_TS)>TAX75.PROCESS_DATE                     
	ORDER BY TAX72.REQ_BR_CO,TAX72.CREATE_TS,TAX75.PROCESS_DATE) T    
	;                                                                 
	 
		11. Using Minus in the query sinteresting fact
		12. For Mass updates lock the table and update it
	LOCK TABLE DB10J02.A76 IN EXCLUSIVE MODE;                       
	UPDATE DB10J02.A76 SET YEARX = '2020' WHERE YEARX = '2019';     
	13. Another query
	/*SQL IN PROGRAM MRP799 NOT EQUAL*/                  
	/*SQL IN PROGRAM MRP799 NOT EQUAL*/                   
	INSERT INTO CID99D.CORP_ITM_FSA_CHGS                  
	(SELECT PI_ITM_CD,PI_PC_NBR,                          
	        '2010-02-03-15.07.58.226191' CIFC_CREATE_TS,  
	        'F' CIFC_FSA_ELIG_CD                          
	        FROM CID99D.PC_ITM                            
	        WHERE PI_PC_NBR='46' AND PI_MMFD1M_KEY <> 0)  
	;                                                     
	14. Groupby interesting fact
	 We can use Where condition and simplify the query then apply groupby 
	 SELECT          TSN,                               
	                 QUARTER,                           
	                 BRANCH,                            
	                 COMPANY,                           
	                 JURIS_ABBREV,                      
	                 CLIENT_NAME,                       
	                 SUM(TAXES) AS TAXES                
	 FROM DB20R03.TAX076_DEFERRALS                      
	 WHERE YEAR     = '2020'                            
	 GROUP BY TSN,QUARTER,BRANCH,COMPANY,JURIS_ABBREV,  
	          CLIENT_NAME                               
	 HAVING QUARTER='2'            

5. DB2 using ROW_NUMBER
 SELECT TSN,SUM(TAXES) AS TAXES,ROW_NUMBER() OVER () ROWNUMBER 
 FROM DB20R03.TAX076_DEFERRALS                                 
 GROUP BY TSN                                                  
 ORDER BY TSN                                                  
 FETCH FIRST 1000 ROWS ONLY;                                   
 
 6. DB2 using lIMIT
 SELECT TSN,SUM(TAXES) AS TAXES,ROW_NUMBER() OVER () ROWNUMBER 
 FROM DB20R03.TAX076_DEFERRALS                                 
 GROUP BY TSN                                                  
 ORDER BY TSN                                                  
 FETCH FIRST 1000 ROWS ONLY;                 
 7. DB2 using ORDER BY
 SELECT TSN,SUM(TAXES) AS TAXES,ROW_NUMBER() OVER () ROWNUMBER 
 FROM DB20R03.TAX076_DEFERRALS                                 
 GROUP BY TSN                                                  
 ORDER BY TSN ASC,QUARTER ASC

2. Using temperory tables in the COBOL DB2 programs
Inserting Data in Temperory tables
EXEC SQL                                
     INSERT INTO SESSION.GT001_TSN_LIST 
         (                              
           TSN                          
         )                              
     VALUES                             
         (                              
           :WS-TSN-GRP                  
         )                              
         FOR :QTRI-TSN-COUNT ROWS         -- ask rakesh about the purpose
     ATOMIC                             
END-EXEC                                
 3. File manager freeze
 3. Using dummy table
 SELECT CURRENT TIMESTAMP        
    INTO                         
      :ATS119-TRANS-INITIATE-TS  
 FROM SYSIBM.SYSDUMMY1  
-> Using distinct
   SELECT DISTINCT TSN,          
                   BRANCH,       
                   COMPANY,      
                   JURIS_ABBREV, 
                   CLIENT_NAME   
 FROM DB20R03.TAX076_DEFERRALS   
   WHERE YEAR     = ?            
     AND QUARTER  = ?            
     AND TSN      =?             
   ORDER BY TSN                  
   OPTIMIZE FOR 10 ROWS   

->
/* FINDING THE PRIMARY KEY*/               
SELECT  SUBSTR(NAME,1,20),SUBSTR(TBCREATOR,1,20),KEYSEQ 
FROM SYSIBM.SYSCOLUMNS                     
WHERE  TBNAME = 'CUSTOMER'  AND  KEYSEQ  > 0           
       AND TBCREATOR='CID99D'              
ORDER BY KEYSEQ ASC                        
;                                          
                      
/* FINDING THE FOREIGN KEY*/                   
SELECT  SUBSTR(B.REFTBNAME,1,20) AS PARENTTABLE,SUBSTR(COLNAME,1,20)
FROM SYSIBM.SYSFOREIGNKEYS A, SYSIBM.SYSRELS B 
WHERE A.RELNAME = B.RELNAME                    
AND B.TBNAME = 'CUSTOMER'                      
AND B.REFTBCREATOR = A.CREATOR                 
;                                              

-> SQL comments in Spufi
/*SQL FOR MRP799*/                                             
SELECT CUS_NBR,CUS_LOCATION_KEY,CUS_PURCH_FL,CUS_MSFD01_KEY    
  FROM CID99D.CUSTOMER                                         
 WHERE CUS_PC_NBR      = '46'                                  
 AND   CUS_INACTIVE_FL = 0                                     
-- AND   CUS_POS_COMM_CD > '0'                                 
 ORDER BY CUS_NBR                                              
;                                                              

  
	                                      
	
	
	 
	 
	 
	 

