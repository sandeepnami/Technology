Sub Assoc_arr()
    
    Dim muldim_arr(0 To 3, 0 To 600) As String
    Dim variation As String
    Dim variance_fieldname_arr(0 To 6) As String
    Dim numrows As Integer
    Dim numrows_variation As Integer
    Dim curr_row As Integer
    Dim i As Integer
    Dim variance_count As Integer
        
    '0-customer
    '1-BSB
    '2-product
    '3-variation
    
    'Selection of range
    Sheet2.Activate
    'Count no of rows with data
    numrows = Range("A2", Range("A2").End(xlDown)).Rows.Count
    'MsgBox "no of rows with data :" & numrows
    
    For i = 0 To numrows - 1
        curr_row = i + 2
        ActiveSheet.Range("B" & curr_row).Select
        muldim_arr(0, i) = ActiveCell.Offset(0, 0).Value
        ActiveSheet.Range("C" & curr_row).Select
        muldim_arr(1, i) = ActiveCell.Offset(0, 0).Value
        ActiveSheet.Range("D" & curr_row).Select
        muldim_arr(2, i) = ActiveCell.Offset(0, 0).Value
        ActiveSheet.Range("E" & curr_row).Select
        muldim_arr(3, i) = ActiveCell.Offset(0, 0).Value
        
    Next
    
    'MsgBox "Customeer no :" & muldim_arr(0, 24)
    
    variation = muldim_arr(3, 0)
    variance_count = 0
    Sheet3.Activate
    For i = 0 To numrows - 1
        curr_row = i + 2
        ActiveSheet.Range("B" & curr_row).Select
        If ActiveCell.Offset(0, 0).Value = variation Then
            variance_fieldname_arr(variance_count) = ActiveCell.Offset(0, 1).Value
            variance_count = variance_count + 1
        End If
        'increment the offset to point to next row
        ActiveCell.Offset(1, 0).Select
    Next
    
    For i = 0 To variance_count - 1
    
        MsgBox variance_fieldname_arr(i)
    
    Next
    
End Sub
