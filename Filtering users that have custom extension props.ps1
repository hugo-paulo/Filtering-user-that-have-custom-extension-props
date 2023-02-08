Connect-MgGraph

#This is the base line 
#? filter no being applied on the request
$users = Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/beta/users/?`$select=displayName,mail,id,createdDateTime,extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample&`$filter=createdDateTime le 2022-12-02T16:00:00Z"

$users.value 
 
#Remove all user that don't have extenison props
$usersWithExt = $users.value | Where-Object {$_.extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample -notcontains $null}

#only return user with extension not equal to true 
$usersWithExtNotTrue = $usersWithExt | Where-Object {$_.extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample -notcontains "true"}

$usersWithExtNotTrue


#using cmdlt get user, might solve issue with pagination as above

Select-MgProfile -Name "beta" #"1.0"


$usersWithExt = Get-MgUser -all -Filter "createdDateTime le 2022-12-02T16:00:00Z" | Where-Object {$_.additionalProperties.extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample -notcontains $null}


$usersWithExtNotTrue = $usersWithExt | Where-Object {$_.additionalProperties.extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample -notcontains "true"}

$usersWithExtNotTrue 


########################################

#Filtering by identities

$domain = "onmicrosoft.com"

$allUsers = Get-MgUser -all -Property displayName, identities, userPrincipalName |  Select-Object -Property displayName, userPrincipalName -ExpandProperty identities


$matchedUser = $allUsers | Where-Object {$_.IssuerAssignedId -Match $domain }


$matchedUser.DisplayName
$matchedUser.userPrincipalName


#########################################
Getting an available extension properties
https://learn.microsoft.com/en-us/graph/api/directoryobject-getavailableextensionproperties?view=graph-rest-1.0&tabs=csharp#request-body

