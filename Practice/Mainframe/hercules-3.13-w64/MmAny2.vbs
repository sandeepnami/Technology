'*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+
' Generator   : PPWIZARD version 11.140
'             : FREE tool for Windows, OS/2, DOS and UNIX by Dennis Bareis (dbareis@gmail.com)
'             : http://dennisbareis.com/ppwizard.htm
' Time        : Sunday, 24 Sep 2017 7:41:10pm
' Input File  : C:\Users\rbowler\Documents\Projects\spinhawk\makemsi\Hercules-W64.MM
' Output File : C:\Users\rbowler\Documents\Projects\spinhawk\makemsi\out\Hercules-W64.MM\Log\Scripts\VB\MakemsiAdvertisedCmdLine.VBS
'*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+

 if Wscript.Arguments.Count = 1 then if Wscript.Arguments(0) = "!CheckSyntax!" then wscript.quit(21924)




'================================================================
' Used to implement a special MAKEMSI advertised shortcut type
' which allows the power of a non-advertised shortcut while
' skill being advertised!
'
' Product Name   : Hercules-390 (64-Bit)
' Product Version: 3.13.00
'================================================================




dim CmdLine : CmdLine = ""
if  wscript.arguments.count = 0 then
Die("We expected at least one parameter!")
end if
for i =  0 to wscript.arguments.count-1
if i <> 0 then CmdLine = CmdLine & " "
CmdLine = CmdLine & wscript.arguments(i)
next
CmdLine = replace(CmdLine, "{'}", """")
CmdLine = replace(CmdLine, "{and}",          "&")
CmdLine = replace(CmdLine, "{or}",           "|")
CmdLine = replace(CmdLine, "{gt}",           ">")
CmdLine = replace(CmdLine, "{lt}",           "<")
CmdLine = replace(CmdLine, "{percent}",      "%")
CmdLine = replace(CmdLine, "{hat}",          "^")
Execute(CmdLine)


sub Execute(CmdLine)
on error resume next
dim oShell : set oShell = CreateObject("WScript.Shell")
DieOnErr "CreateObject(""WScript.Shell"")"
oShell.run CmdLine, 1, false
set oShell = Nothing
end sub


sub DieOnErr(Reason)

if  err.number <> 0 then
Die "Failed on : " & Reason
end if
end sub


sub Die(Reason)
dim T : T = ""

if  CmdLIne <> "" then
T = T & "We have been called to execute the command line:"
T = T & vbCRLF & vbCRLF
T = T & CmdLine
T = T & vbCRLF
end if
T = T & Reason
MsgBox T, vbCritical, "FAILED INVOKING COMMAND LINE"
wscript.quit 999
end sub 
