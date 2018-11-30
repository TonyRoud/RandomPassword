# Function to return a specified number of non-alphanumeric characters
function Get-NonAlphaChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=2)][int]$ratio
    )

    $sublength = $length / $ratio

    $no = 1..$sublength | Get-Random

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
    $sublength = $length / $ratio
    $no = 1..$sublength | Get-Random

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
    $sublength = $length / $ratio

    $no = 1..$sublength | Get-Random

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
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=1)][int]$complexity
    )

    $nonAlpha     = ""
    $NumericChars = ""
    $UCChars      = ""
    $LCChars      = ""

    $lengthRemaining = $length

    if($complexity -gt 3) {
        $nonAlpha = Get-NonAlphaChars -length $length -ratio 4
        $lengthRemaining = $lengthRemaining - $nonAlpha.Length
    }
    if($complexity -gt 2) {
        $NumericChars = Get-NumericChars -length $length -ratio 4
        $lengthRemaining = $lengthRemaining - $NumericChars.Length
    }
    if($complexity -gt 1) {
        $UCChars = Get-UpperCaseChars -length $length -ratio 3
        $lengthRemaining = $lengthRemaining - $UCChars.Length
    }

    $LCChars = Get-LowerCaseChars -no $lengthRemaining

    $finalPassWord = $nonAlpha + $NumericChars + $UCChars + $LCChars

    $Pass = (($finalPassWord.ToCharArray() | Get-Random -Count $finalPassword.Length) -join '').Replace(" ","")

    $Pass | Set-ClipboardText

    return $pass

    Write-Host "`[ $pass `] copied to clipboard"
}