/*******************************************************
/* HELLO WORLD TSO CLIST
/*******************************************************
SET RCODE=0 
SET EOF=OFF 
ERROR +
  DO
    SET RCODE = &LASTCC 
    IF &RCODE=400 THEN + 
      SET EOF=ON
      RETURN
  END 
ALLOC FILE(NAMES) DA('input.data.set') SHR REUSE 
OPENFILE NAMES 
ALLOC FILE(GREETS) DA('output.data.set') +
      LIKE('other.data.set')
OPENFILE GREETS OUTPUT
GETFILE NAMES 
DO WHILE &EOF=OFF
  SET GREETS=HELLO, &NAMES
  PUTFILE GREETS 
  GETFILE NAMES 
END
CLOSFILE NAMES
FREE FILE(NAMES)
CLOSFILE GREETS
FREE FILE(GREETS)              
EXIT