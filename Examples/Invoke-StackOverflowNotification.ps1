#PowerShell script to notify when new PowerShell StackOverflow questions are published.

#To run via crontab every 5 mins:
# */5 * * * *  /usr/local/bin/pwsh /path/to/script/Invoke-StackOverflowNotification.ps1

[cmdletbinding()]
Param(
    $Category = 'PowerShell'
)

$LatestQuestion = Invoke-RestMethod "https://stackoverflow.com/feeds/tag?tagnames=$Category&sort=newest" | Select-Object -First 1

$LatestQuestionID = $LatestQuestion.ID
$QuestionTitle = $LatestQuestion.title.'#text'

if (Test-Path $Home/LatestQuestion.txt) {
    $PrevQuestionID = Get-Content $Home/LatestQuestion.txt
}

If ($LatestQuestionID -ne $PrevQuestionID) {
    Invoke-MacNotification -Title "New #$Category question on StackOverflow" -Message $QuestionTitle
    $LatestQuestionID | Set-Content $Home/LatestQuestion.txt
}

