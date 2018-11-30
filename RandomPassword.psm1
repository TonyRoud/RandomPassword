# Function to return a specified number of non-alphanumeric characters
function Get-NonAlphaChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=2)][int]$ratio
    )

    $sublength = $length / $ratio

    $no = 1..$sublength | Get-Random

    $nonalphanumeric = '!£$%^&*()=+@#?'

    $nonalphanumeric.ToCharArray() | Get-Random -Count $no
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

    $numericChars = 0..9

    $numericChars | Get-Random -Count $no
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

    $UpperCaseChars = (65..90) | ForEach-Object { [char]$_ }

    $UpperCaseChars | Get-Random -Count $no
}
# Function to return a specified number of lower case chars
function Get-LowerCaseChars {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$no
    )

    $lowerCaseChars = (97..122) | ForEach-Object { [char]$_ }

    $lowerCaseChars | Get-Random -Count $no
}
Function Get-FullRandomPassword {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)][int]$length,
        [Parameter(Mandatory=$true,Position=1)][int]$complexity
    )

    $lengthRemaining = $length

    if($complexity -gt 3) {
        $nonAlpha = Get-NonAlphaChars -length $length -ratio 4
        $lengthRemaining = $lengthRemaining - $nonAlpha.count
    }
    if($complexity -gt 2) {
        $NumericChars = Get-NumericChars -length $length -ratio 4
        $lengthRemaining = $lengthRemaining - $NumericChars.count
    }
    if($complexity -gt 1) {
        $UCChars = Get-UpperCaseChars -length $length -ratio 3
        $lengthRemaining = $lengthRemaining - $UCChars.count
    }

    $LCChars = Get-LowerCaseChars -no $lengthRemaining

    $finalPassWord = $nonAlpha + $NumericChars + $UCChars + $LCChars

    ($finalPassWord | Get-Random -Count $finalPassword.Length) -join ''
}