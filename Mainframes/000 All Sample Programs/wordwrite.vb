
Dim tempWordApp As New Word.Application
tempWordApp.Visible = True
Dim tempWordDoc As Word.Document
Set tempWordDoc = tempWordApp.Documents.Add(Visible:=True)


 IE.Document.execCommand "SelectAll", False
        tempWordDoc.Content.Text = tempWordDoc.Content.Text & vbCrLf & IE.Document.Selection.createRange().Text
        'wdFormatText=.txt
        tempWordDoc.SaveAs ActiveWorkbook.Path & "\WebScrapedText", FileFormat:=wdFormatHTML
        MsgBox "exit"