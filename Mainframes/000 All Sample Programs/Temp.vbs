Sub LinkDefectsToEntities(FolderName As String, TestName As String)
'-----------------------------------------------------------
' This example creates a test and a test set with test steps.
' It then creates three defects and links them to the test,
' the run, and the test step.
'-----------------------------------------------------------
    Dim TestF As TestFactory
    Dim NewTest As test
    Dim StepF As DesignStepFactory
    Dim desStep As DesignStep
    Dim root As SubjectNode, folder As SubjectNode
    Dim TreeMgr As TreeManager
    Dim labTreeMgr As TestSetTreeManager
    Dim labFolder As SysTreeNode, labTreeRoot As SysTreeNode
    Dim BugF As BugFactory
    Dim Bug1 As Bug, Bug2 As Bug, bug3 As Bug
    Dim TestSetF As TestSetFactory
    Dim TstSet As TestSet
    Dim testInstanceF As TSTestFactory
    Dim tstInstance As TSTest
    Dim RunF As RunFactory
    Dim theRun As run
    Dim runStepF As StepFactory
    Dim runStep As Step, runStep2 As Step
    Dim TestId As String
    Dim lst As list, Item
    On Error GoTo LinkDefectsToEntitiesErr
'tdc is a TDConnection object. When this routine is run,
' the user is authenticated and connected to the project.
    Set TreeMgr = tdc.TreeManager
    Set TestF = tdc.TestFactory
    Set labTreeMgr = tdc.TestSetTreeManager
    Set BugF = tdc.BugFactory
'------------------------------------------
' Test Plan
'------------------------------------------
'Get or create test plan subject folder
    errmsg = "Subject tree error"
    Set root = TreeMgr.TreeRoot("Subject")
    On Error Resume Next
    Set folder = root.FindChildNode(FolderName)
    On Error GoTo LinkDefectsToEntitiesErr
    If folder Is Nothing Then _
        Set folder = root.AddNode(FolderName)
'Create a design test
    errmsg = "Design test error"
    'Get the test if it exists
    ' For the code of GetTest, see the Test object example
    ' "Get a test object with name and path"
    Set NewTest = GetTest(TestName, FolderName)
    'If it doesn't exist, create it
    If NewTest Is Nothing Then
        Set NewTest = TestF.AddItem(Null)
        NewTest.Name = TestName
        NewTest.Type = "MANUAL"
        'Put the test in the new subject folder
        NewTest.Field("TS_SUBJECT") = folder.NodeID
        NewTest.Post
    End If
'Get or create a design step from the factory of the new test
    errmsg = "Design step error"
    Set StepF = NewTest.DesignStepFactory
    Dim aFilter As TDFilter
    Set aFilter = StepF.Filter
    Dim StepName$
    StepName = TestName & "Step_1"
    aFilter.Filter("DS_STEP_NAME") = StepName
    Set lst = StepF.NewList(aFilter.Text)
    If lst.Count = 0 Then
        Set desStep = StepF.AddItem(Null)
        desStep.StepName = StepName
        desStep.StepDescription = "Step to be linked to defect."
        desStep.StepExpectedResult = "This step expected to be linked."
        desStep.Post
    Else
        Set desStep = lst.Item(1)
    End If
'-----------------------------------------
' Test Lab
'------------------------------------------
'Get or create a test set folder
    errmsg = "Lab node error"
    Dim tsFolder$, tsFolderPath$
    tsFolder = FolderName & "_TS"
    tsFolderPath = "Root\" & tsFolder
    On Error Resume Next
    Set labFolder = labTreeMgr.NodeByPath(tsFolderPath)
    On Error GoTo LinkDefectsToEntitiesErr
    If labFolder Is Nothing Then
        Set labTreeRoot = labTreeMgr.root
        Set labFolder = labTreeRoot.AddNode(tsFolder)
        labTreeRoot.Post
    End If
'Get or create a test set from the factory of the new folder
    errmsg = "Test set error"
    Dim tsName$
    tsName = TestName & "_TS"
    Set TestSetF = labFolder.TestSetFactory
    Set aFilter = TestSetF.Filter
    aFilter.Filter("CY_CYCLE") = tsName
    Set lst = TestSetF.NewList(aFilter.Text)
    If lst.Count = 0 Then
        Set TstSet = TestSetF.AddItem(Null)
        TstSet.Field("CY_CYCLE") = tsName
        TstSet.Post
    Else
        Set TstSet = lst.Item(1)
    End If
'Get or create a test instance from the factory of the new test set
    errmsg = "Test instance error"
    Set testInstanceF = TstSet.TSTestFactory
    Set aFilter = testInstanceF.Filter
    aFilter.Filter("TC_TEST_ID") = NewTest.ID
    Set lst = testInstanceF.NewList(aFilter.Text)
    If lst.Count = 0 Then
        Set tstInstance = testInstanceF.AddItem(Null)
    'Put the new test in the test set
        tstInstance.Field("TC_TEST_ID") = NewTest.ID
    Else
        Set tstInstance = lst.Item(1)
    End If
    tstInstance.Status = "No Run"
    tstInstance.Post
'Create a run of the test instance
    errmsg = "Run error"
    Dim runName$
    runName = TestName & "Linked_Run"
    Set RunF = tstInstance.RunFactory
    Set theRun = RunF.AddItem(runName)
    theRun.Status = "FAILED"
    theRun.Post
'Get the design step created above for the test
' to be associated with this test run
    errmsg = "Design steps error"
    theRun.CopyDesignSteps
    theRun.Post
'Add the steps to run and fail them
    Set runStepF = theRun.StepFactory
    Set lst = runStepF.NewList("")
    For Each Item In lst
     Set runStep2 = Item
     runStep2.Status = "Failed"
     runStep2.Post
    Next
'------------------------------------------
' Defect Module
'------------------------------------------
'Create new defects
    errmsg = "Create Bug1 error"
    Set Bug1 = BugF.AddItem(Null)
    Bug1.Summary = "Associated to " & TestName
    Bug1.Status = "New"
    Bug1.Priority = "3-High"
    Bug1.Field("BG_SEVERITY") = "3-High"
    Bug1.DetectedBy = c_qcUser
    Bug1.Field("BG_DETECTION_DATE") = Date
    Bug1.Post
    '
    errmsg = "Create Bug2 error"
    Set Bug2 = BugF.AddItem(Null)
    Bug2.Summary = "Associated to " & runName
    Bug2.Status = "New"
    Bug2.Priority = "3-High"
    Bug2.Field("BG_SEVERITY") = "3-High"
    Bug2.DetectedBy = c_qcUser
    Bug2.Field("BG_DETECTION_DATE") = Date
    Bug2.Post
    '
    errmsg = "Create Bug2 error"
    Set bug3 = BugF.AddItem(Null)
    bug3.Summary = "Associated to Run Step " & TestName & ":" & runStep2.Name
    bug3.Status = "New"
    bug3.Priority = "3-High"
    bug3.Field("BG_SEVERITY") = "3-High"
    bug3.DetectedBy = c_qcUser
    bug3.Field("BG_DETECTION_DATE") = Date
    bug3.Post
'
'Add associations between diffent entities and bugs
    Dim BugLinkF As LinkFactory
    Dim b2Test As Link, b2Run As Link, b2Step As Link
    Dim testL As ILinkable, runL As ILinkable, stepL As ILinkable
    Dim anObj As Object
'Cast test to Ilinkable and get bug link factory
    errmsg = "Error linking Bug1"
    Set testL = NewTest
    Set BugLinkF = testL.BugLinkFactory
'Create a link between Bug1 and the test
    Set b2Test = BugLinkF.AddItem(Bug1)
    b2Test.LinkType = "Related"
    b2Test.Post
'Show the link definition
    Set anObj = b2Test.LinkedByEntity
    Debug.Print TypeName(anObj), anObj.Name 'ITest LinkTest
    Set anObj = b2Test.SourceEntity
    Debug.Print TypeName(anObj), anObj.Name 'ITest LinkTest
    Set anObj = b2Test.TargetEntity
    Debug.Print TypeName(anObj), anObj.Summary 'IBug Associated to LinkTest
'Cast Bug2 to Ilinkable and get bug link factory
    errmsg = "Error linking Bug2"
    Set runL = theRun
    Set BugLinkF = runL.BugLinkFactory
'Create a link between Bug2 and the run
    Set b2Run = BugLinkF.AddItem(Bug2)
    b2Run.LinkType = "Related"
    b2Run.Post
'Show the link definition
    Set anObj = b2Run.LinkedByEntity
    Debug.Print TypeName(anObj), anObj.Name 'IRun2 LinkTestLinked_Run
    Set anObj = b2Run.SourceEntity
    Debug.Print TypeName(anObj), anObj.Name 'IRun2 LinkTestLinked_Run
    Set anObj = b2Run.TargetEntity
    Debug.Print TypeName(anObj), anObj.Summary 'IBug Associated to LinkTestLinked_Run
'Cast Bug3 to Ilinkable and get bug link factory
    errmsg = "Error linking Bug3"
    Set stepL = runStep2
    Set BugLinkF = stepL.BugLinkFactory
'Create a link between Bug3 and the run step
    Set b2Step = BugLinkF.AddItem(bug3)
    b2Step.LinkType = "Related"
    b2Step.Post
'Show the link definition
    Set anObj = b2Step.LinkedByEntity
    Debug.Print TypeName(anObj), anObj.Name 'IStep2 LinkTestStep_1
    Set anObj = b2Step.SourceEntity
    Debug.Print TypeName(anObj), anObj.Name 'IStep2 LinkTestStep_1
    Set anObj = b2Step.TargetEntity
    Debug.Print TypeName(anObj), anObj.Summary 'IBug Associated to Run Step LinkTest:LinkTestStep_1
'Show the link definition from the bug side.
'Note that source and target are reversed.
    Dim bugL As ILinkable, lList As list, aLink As Link
    Dim bugLF As LinkFactory
    Set bugL = bug3
    Debug.Print
    Set bugLF = bugL.LinkFactory
    Set lList = bugLF.NewList("")
    For Each aLink In lList
        Set anObj = aLink.LinkedByEntity
        Debug.Print TypeName(anObj), anObj.Name ' IStep2 LinkTestStep_1
        Set anObj = aLink.SourceEntity
        Debug.Print TypeName(anObj), anObj.Summary ' IBug Associated to Run Step LinkTest:LinkTestStep_1
        Set anObj = aLink.TargetEntity
        Debug.Print TypeName(anObj), anObj.Name 'IStep2 LinkTestStep_1
    Next aLink
Exit Sub
LinkDefectsToEntitiesErr:
ErrHandler err, "LinkDefectsToEntities", err.Description & vbCrLf & errmsg
'Resume Next
End Sub
