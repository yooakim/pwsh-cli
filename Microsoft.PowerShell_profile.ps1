Set-StrictMode -Version latest

$PSDefaultParameterValues = @{
    "Out-File:Encoding"            = "UTF8"
}

$env:TIME_STYLE="long-iso" # Set time format to ISO 8601 (CLI utilities)

[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::CreateSpecificCulture("sv-SE")
[System.Threading.Thread]::CurrentThread.CurrentUICulture = [System.Globalization.CultureInfo]::CreateSpecificCulture("sv-SE")
[System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]::CreateSpecificCulture("sv-SE")
[System.Threading.Thread]::CurrentThread.CurrentUICulture = [System.Globalization.CultureInfo]::CreateSpecificCulture("sv-SE")

if ($host.Name -eq 'ConsoleHost') {
    # Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -PredictionViewStyle ListView
    Import-Module -Name Terminal-Icons

    # Enable Unicode and Emoji support
    [console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
}



<#
.Synopsis
   Get information about your external IP adress
.DESCRIPTION
   Gets information from ipinfo.io about your externally visible IP address.

.EXAMPLE
   Get-IpInfo
.EXAMPLE
   Get-IpInfo -All
#>
function Get-IpInfo {
    [CmdletBinding()]
    [Alias("myip")]
    Param
    (
        # List only IP (default) or all information returned
        [Parameter(Mandatory = $false)]
        [switch]
        $All = $false
    )

    Begin {
        $uri = "http://ipinfo.io/json"
    }
    Process {
        $ip = Invoke-RestMethod -Method GET -Uri $uri -DisableKeepAlive:$true -UseBasicParsing
    }
    End {
        if ($all -eq $false) {
            $ip.ip
        }
        else {
            $ip
        }
    }
}

Function Get-GitIgnore {
    [Alias("gig")]
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$list
    )
    $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
    Invoke-WebRequest -UseBasicParsing -Uri "https://www.gitignore.io/api/$params" | Select-Object -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}

function Get-RandomPassword {
    param (
        [int]$Length = 16,
        [string]$AllowedChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
    )

    # Validate parameters
    if ($Length -le 0) {
        throw "Password length must be a positive integer."
    }

    if ([string]::IsNullOrEmpty($AllowedChars)) {
        throw "AllowedChars must contain at least one character."
    }

    $bytes = New-Object byte[] $Length

    # Securely generate random bytes
    [System.Security.Cryptography.RandomNumberGenerator]::Fill($bytes)

    $result = New-Object char[] $Length
    for ($i = 0; $i -lt $Length; $i++) {
        $result[$i] = $AllowedChars[$bytes[$i] % $AllowedChars.Length]
    }

    return -join $result
}

