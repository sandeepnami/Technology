Private Sub Form_Load()

Dim loopvar As Integer
Dim response As Integer

For loopvar = 1 To 1
Beep
Next loopvar
response = MsgBox("Did you hear the beeps", vbOKOnly, "Beeps")
For loopvar = 1 To 5
Beep
Next loopvar
response = MsgBox("Did you hear the beeps", vbOKOnly, "Beeps")
For loopvar = 1 To 10
Beep
Next loopvar
response = MsgBox("Did you hear the beeps", vbOKOnly, "Beeps")

End Sub
