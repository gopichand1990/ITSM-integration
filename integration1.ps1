$SNowUser = “admin”
$Systemid="54dbd2aadb111300e25dd450cf9619bd " #Paste the Incident's sys ID
$SNowPass = ConvertTo-SecureString –String “Tinku123(” –AsPlainText -Force
$SNowCreds = New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $SNowUser, $SNowPass
$headers = @{
Accept = “application/json”
}
#connecting to incident
$jsn = Invoke-RestMethod -Credential $SNowCreds -Headers $headers -Method Get -Uri “https://dev36472.service-now.com/api/now/table/incident/$Systemid”
#extracting values from json
$id = $jsn.result.short_description
#$jsn.result.number
#$id1 = $id -contains 'memory'
write-host "FETCHING TICKET DETAILS FROM SERVICE NOW"
write-host "TICKET DESCRIPTION: $id" 
$id1= $id -match 'updated'
<#if($id1)
{
$server = gc "C:\Users\Administrator\Desktop\server.txt"
foreach ($ser in $server)
{
#invoke-command -computername $ser -ScriptBlock{
$temp = 'c:\windows\temp\*'
$daystodelete = 5
$objshell = New-Object -ComObject shell.application
$objfolder = $objshell.namespace(0XA)
Get-ChildItem $temp    -Recurse -Force -Verbose -ErrorAction silentlycontinue|
Where-Object { ($_.creationtime -lt $(get-date).adddays(-$daystodelete)) } |
Remove-Item -force -Verbose -Recurse -ErrorAction silentlycontinue
$objfolder.items()|foreach-object {remove-item $_.path -erroraction silentlycontinue -recurse} -Verbose
write-host "MEMORY CLEANUP DONE"  
#}
}
}#>
$cred= New-Object System.Management.Automation.PSCredential($SNowUser,$SNowPass)
$url ="https://dev36472.service-now.com/incident.do?wsdl"
$webservicex = New-WebServiceProxy -Uri $url -Credential $cred
$type=$webservicex.GetType().Namespace
$update= New-Object($type+'.update')
$update.sys_id="54dbd2aadb111300e25dd450cf9619bd"
#$update.short_description='this has to ticket'
$update.state= 6
$webservicex.update($update)
Write-host "TICKET RESOLVED SUCCESSFULLY"