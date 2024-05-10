Set WshShell = WScript.CreateObject("WScript.Shell")
 bsb=InputBox("Enter BSB","Enter Value",3054)
 account=InputBox("Enter Account number","Enter Value",843004085)
 count=InputBox("Enter Number of withdrawals","Enter Value",10)
 amount=InputBox("Enter deposit amount","Enter Value",5)
For i = 1 To count
	'WshShell.Run "iexplore http://ebobs-test.prod.au.thenational.com/EBobsWeb/"
	WshShell.AppActivate "Microsoft Internet Explorer"
	'WScript.Sleep 1000
	'WshShell.SendKeys "{ENTER}"
	'WScript.Sleep 1000
	WshShell.SendKeys "{F2}"
	WScript.Sleep 1000
	WshShell.SendKeys "2210"
	WshShell.SendKeys "{ENTER}"
	WScript.Sleep 1000
	WshShell.SendKeys bsb
	WshShell.SendKeys account
	WshShell.SendKeys amount
	WshShell.SendKeys "{ENTER}"
	WScript.Sleep 1000
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys "{TAB}"
	WshShell.SendKeys amount
	WshShell.SendKeys "{ENTER}"
	WScript.Sleep 1000
	WshShell.SendKeys "{ENTER}"
	WScript.Sleep 1000
Next
