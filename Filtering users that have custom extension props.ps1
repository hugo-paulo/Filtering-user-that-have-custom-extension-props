 Connect-MgGraph

 #This is the base line 

 $users = Invoke-MgGraphRequest -Uri "https://graph.microsoft.com/beta/users/?`$select=mail,id,createdDateTime,extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample&`$filter=createdDateTime le 2022-12-02T16:00:00Z"

 $users.value 
 
 #Remove all user that don't have extenison props
 $usersWithExt = $users.value | Where-Object {$_.extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample -notcontains $null}

 #only return user with extension not equal to true 
 $usersWithExtNotTrue = $usersWithExt | Where-Object {$_.extension_a74d0a2daede4b4f847b5e0eb438b9f8_MyExtExample -notcontains "true"}