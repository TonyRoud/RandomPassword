# Function to return a specified number of non-alphanumeric characters
function Get-NonAlphaChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=2)][int]$ratio
    )

    $no = 1..$ratio | Get-Random

    $special = '!£$%&*=+@#?'

    ($special.ToCharArray() | Get-Random -Count $no) -join ""
}
# Function to return a specified number of numeric chars
function Get-NumericChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=2)][int]$ratio
    )

    $no = 1..$ratio | Get-Random

    $numericChars = (0..9) -join ""

    ($numericChars.ToCharArray() | Get-Random -Count $no) -join ""
}
# Function to return a specified number of upper case chars
function Get-UpperCaseChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=2)][int]$ratio
    )

    $no = 1..$ratio | Get-Random

    $UpperCaseChars = ((65..90) | ForEach-Object { [char]$_ }) -join ""

    ($UpperCaseChars.ToCharArray() | Get-Random -Count $no) -join ""
}
# Function to return a specified number of lower case chars
function Get-LowerCaseChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$no
    )

    $LCChars = ((97..122) | ForEach-Object { [char]$_ }) -join ""

    ($LCChars.ToCharArray() | Get-Random -Count $no) -join ""
}
Function New-RandomPassword {
    <#
    .SYNOPSIS
    Generates a random password of specified length and complexity, and copies it to the clipboard.

    .DESCRIPTION
    This function generates a random password composed of uppercase, lowercase, numeric and special characters.
    The desired complexity level can be set using the -complexity parameter. The ratio of each type of character
    in the final password will be associated to the complexity level. For example if the complexity is 2 (uppercase
    and lowercase) the mix will be around 50/50. The password will also be copied to the clipboard.

    .EXAMPLE
    New-RandomPassword -Length 10 -Complexity 4
    h73@e$bMga

    .EXAMPLE
    New-RandomPassword 12 3
    09tcNpsbBA

    .EXAMPLE
    New-RandomPassword -length 10 -complexity 4 -Verbose

    VERBOSE: Password generated and copied to clipboard:
    @Wm2XxBzge

    .PARAMETER Length
        This parameter determines the length of the password string

    .PARAMETER Complexity
        This parameter determines the complexity in terms of the types of character included in the password.
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=2)][int]$complexity
    )

    $nonAlpha     = ""
    $NumericChars = ""
    $UCChars      = ""
    $LCChars      = ""

    $lengthRemaining = $length
    $ratio = $length / $complexity

    if($complexity -gt 3) {
        $nonAlpha = Get-NonAlphaChars -length $length -ratio $ratio
        $lengthRemaining = $lengthRemaining - $nonAlpha.Length
    }
    if($complexity -gt 2) {
        $NumericChars = Get-NumericChars -length $length -ratio $ratio
        $lengthRemaining = $lengthRemaining - $NumericChars.Length
    }
    if($complexity -gt 1) {
        $UCChars = Get-UpperCaseChars -length $length -ratio $ratio
        $lengthRemaining = $lengthRemaining - $UCChars.Length
    }

    $LCChars = Get-LowerCaseChars -no $lengthRemaining

    $finalPassWord = $nonAlpha + $NumericChars + $UCChars + $LCChars

    $Pass = (($finalPassWord.ToCharArray() | Get-Random -Count $finalPassword.Length) -join '').Replace(" ","")

    $Pass | Set-ClipboardText

    Write-Verbose "Password generated and copied to clipboard:"
    $pass
}
Export-ModuleMember -Function New-RandomPassword