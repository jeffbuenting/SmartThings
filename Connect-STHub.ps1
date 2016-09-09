Function Connect-STHub {

<# 
    .Link
        http://docs.smartthings.com/en/latest/smartapp-web-services-developers-guide/authorization.html?highlight=rest
#>

    [CmdletBinding()]
    Param (
       # [PSCredential]$Credential
    )


    $ClientID = ****
    $Secret = *****
    $ServerURI = *****

    # ----- Get Authoriztion Code
    Write-Verbose "Connect-STHub : Getting Authorization Code"

    $Body = @{
        Response_Type='Code'
        Client_ID=$ClientID
        Scope='app'
        Redirect_URI=$ServerURI
    } 

    $Code = Invoke-RestMethod -Uri https://graph.api.smartthings.com/oauth/authorize -Method Get -Body $Body -ContentType 'application/json'

    $Code

    # ----- Get Autorization Token
    Write-Verbose "Connect-STHub : Getting Authorization Token"

    $Body = @{
        grant_type='authorization_code'
        code=$Code
        client_id=$ClientID
        client_secret=$Secret
        redirect_uri=$ServerURI
    }

    $Token = Invoke-RestMethod -Uri https://graph.api.smartthings.com/oauth/authorize -Method Get -Body $Body -ContentType 'application/x-www-form-urlencoded'

    Write-Output $Token

}

$T = Connect-STHub -Verbose