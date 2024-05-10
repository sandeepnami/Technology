
/*Working command Fetch first 10 rows*/
Select * from PD.AC_ROLE_IN_SRVC
FETCH FIRST 10 ROWS ONLY
/*Working command Fetch last 10 rows*/
select * from PD.AC_ROLE_IN_SRVC
order by ENTRY ASC	
FETCH FIRST 10 ROWS ONLY

/*
Table definition in sql
*/
EXEC SQL DECLARE PDR.MP_OBP_CONFIG TABLE                
( OBP_OFFER_CODE                 CHAR(6) NOT NULL,      
  VARBL_FXD_IND                  CHAR(1) NOT NULL,      
  AC_OFFSET_IND                  CHAR(1) NOT NULL,      
  DBT_INTRST_TYPE                CHAR(3) NOT NULL,      
  RURAL_IND                      CHAR(1) NOT NULL,      
  NAB_EMPLOYEE_IND               CHAR(1) NOT NULL,      
  DEFENCE_IND                    CHAR(1) NOT NULL,      
  LOW_DOC_IND                    CHAR(1) NOT NULL,      
  BUNDLE_TYPE                    CHAR(8) NOT NULL,      
  EFFECT_DATE                    DECIMAL(9, 0) NOT NULL,
  MARKETING_MP_ID                CHAR(4) NOT NULL,      
  PROCESSNG_MP_ID                CHAR(4) NOT NULL,      
  ACCT_COMT_TYPE                 DECIMAL(3, 0) NOT NULL,
  PKG_MKT_MP_ID                  CHAR(4) NOT NULL,      
  PACKAGE_TYPE                   CHAR(4) NOT NULL,      
  OFFSET_MP_ID                   CHAR(4) NOT NULL,      
  OFFSET_PMP_ID                  CHAR(4) NOT NULL,      
  EFEC_STAT                      CHAR(1) NOT NULL,      
  UPDATED_BY                     CHAR(8) NOT NULL,      
  ENTRY                          CHAR(12) NOT NULL      
) END-EXEC.                                             


select * from PD.AC_ROLE_IN_SRVC group by mp_id
Select * from PD.AC_ROLE_IN_SRVC

SELECT OBP_OFFER_CODE,MARKETING_MP_ID FROM PDR.MP_OBP_CONFIG
/*Strings in DB2 are represanted by single quotes*/
SELECT OBP_OFFER_CODE, MARKETING_MP_ID FROM PDR.MP_OBP_CONFIG
WHERE OBP_OFFER_CODE = 'NCS001'
	