function Test-ADCredentials {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Username,
        
        [Parameter(Mandatory=$true)]
        [string]$Password,
        
        [Parameter(Mandatory=$true)]
        [string]$Domain
    )
    
    try {
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement
        $contextType = [System.DirectoryServices.AccountManagement.ContextType]::Domain
        $principalContext = New-Object System.DirectoryServices.AccountManagement.PrincipalContext($contextType, $Domain)
        
        $valid = $principalContext.ValidateCredentials($Username, $Password)
        
        if ($valid) {
            Write-Host "Credentials are valid" -ForegroundColor Green
        } else {
            Write-Host "Credentials are invalid" -ForegroundColor Red
        }
        
        return $valid
    }
    catch {
        Write-Host "Error validating credentials: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    finally {
        if ($principalContext) {
            $principalContext.Dispose()
        }
    }
}
