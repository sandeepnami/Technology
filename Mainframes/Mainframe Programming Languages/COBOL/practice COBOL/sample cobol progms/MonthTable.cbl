      $ SET SOURCEFORMAT"FREE"
IDENTIFICATION DIVISION.
PROGRAM-ID.  MonthTable.
AUTHOR.  Michael Coughlan.
* This program counts the number of students born in each month and 
* displays the result.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT StudentFile ASSIGN TO "STUDENTS.DAT"
		ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD StudentFile.
01 StudentDetails.
   88  EndOfStudentFile  VALUE HIGH-VALUES.
   02  StudentId       PIC 9(7).
   02  StudentName.
       03 Surname      PIC X(8).
       03 Initials     PIC XX.
   02  DateOfBirth.
       03 YOBirth      PIC 9(4).
       03 MOBirth      PIC 9(2).
       03 DOBirth      PIC 9(2).
   02  CourseCode      PIC X(4).
   02  Gender          PIC X.

WORKING-STORAGE SECTION.
01 MonthTable.
   02 TableValues.
      03 FILLER       PIC X(18) VALUE "January  February".
      03 FILLER       PIC X(18) VALUE "March    April".
      03 FILLER       PIC X(18) VALUE "May      June".
      03 FILLER       PIC X(18) VALUE "July     August".
      03 FILLER       PIC X(18) VALUE "SeptemberOctober".
      03 FILLER       PIC X(18) VALUE "November December".
   02 FILLERh REDEFINES TableValues.
      03 Month OCCURS 12 TIMES PIC X(9).

01 MonthCount OCCURS 12 TIMES PIC 999 VALUE ZEROS.

01 MonthIdx           PIC 999.

01 HeadingLine          PIC X(19) VALUE " Month    StudCount".

01 DisplayLine.
   02 PrnMonth          PIC X(9).
   02 FILLER            PIC X(4) VALUE SPACES.
   02 PrnStudentCount   PIC ZZ9.
 

PROCEDURE DIVISION.
Begin.
   OPEN INPUT StudentFile
   READ StudentFile
      AT END SET EndOfStudentFile TO TRUE
   END-READ
   PERFORM UNTIL EndOfStudentFile
      ADD 1 TO MonthCount(MOBirth)
      READ StudentFile
         AT END SET EndOfStudentFile TO TRUE
      END-READ
   END-PERFORM

   DISPLAY HeadingLine
   PERFORM VARYING MonthIdx FROM 1 BY 1 UNTIL MonthIdx > 12
      MOVE Month(MonthIdx) TO PrnMonth
      MOVE MonthCount(MonthIdx) TO PrnStudentCount
      DISPLAY DisplayLine
   END-PERFORM.

   CLOSE StudentFile
   STOP RUN.
