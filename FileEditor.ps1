
########################################################################################################################
# DESCRIPTION:  File Editor code snippet
########################################################################################################################

$FilePath = "" # [Path to file to be edited, including filename]
$OrgText  = "" # [Text String to replace]
$NewText  = "" # [Text string to insert]

(Get-Content -Path $FilePath) | ForEach-Object {$_ -replace "$OrgTex", "$NewText"} | Set-Content -Path $FilePath

########################################################################################################################
# DESCRIPTION:  File Editor code snippet Alternative (Useful for toggling a Comment marker)
########################################################################################################################

$FilePath = "" # [Path to file to be edited, including filename]
$OrgText  = "" # [Text String to replace]
$TempText1 = "" # [Temporary storage Variable]
$TempText2 = "" # [Temporary storage Variable]
$NewText  = "" # [Text string to insert]

# Uncomment
$OrgText = "text string"
$TempText1 = (get-content $FilePath) | Select-String -Pattern $OrgText
$NewText =  $TempText1 -replace "#", ""
(get-content $FilePath) | foreach-object {$_ -replace $TempText1, $NewText} | set-content $FilePath

# Comment
$OrgText = "text string"
$TempText = (get-content $FilePath) | Select-String -Pattern $OrgText
$NewText = $TempText1.Insert(0,"#")
(get-content $FilePath) | foreach-object {$_ -replace $TempText1, $NewText} | set-content $FilePath