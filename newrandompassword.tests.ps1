Import-Module 'C:\github\RandomPassword\RandomPassword.psm1' -force

# Set Regex variables
$LCRegex   = 'a-z'
$UCRegex   = 'A-Z'
$NUMRegex  = '0-9'
$NANRegex = '!£$%^&*()=+@#?'
$fullregex = $LCRegex,$UCRegex,$NUMRegex,$NANRegex

Describe Get-NonAlphaChars {

    [int]$length = 10
    [int]$ratio = 3
    [int]$listlen = $length / $ratio

    $CharList = Get-NonAlphaChars -length $length -ratio $ratio

    It "Returns a list of non alphanumeric characters" {
        $CharList | ForEach-Object {
            [regex]::match($_,$NANRegex) | Should -be $true
        }
    }
    It "Should not contain any spaces" {
        $CharList -match '\s' | Should -Be $false
    }
    It "Length of array returned should be between 1 and $listlen" {
        $CharList.count -gt 0 -and $CharList.count -le $listlen | Should -be $true
    }
}
Describe Get-UpperCaseChars {

    [int]$length = 10
    [int]$ratio = 2
    [int]$listlen = $length / $ratio

    $CharList = Get-UpperCaseChars -length $length -ratio $ratio

    It "Returns a list of uppercase characters only" {
        $CharList | ForEach-Object {
            [regex]::match($_,$UCRegex) | Should -be $true
        }
    }
    It "Should not contain any spaces" {
        $CharList -match '\s' | Should -Be $false
    }
    It "Length of array returned should be between 1 and $listlen" {
        $CharList.count -gt 0 -and $CharList.count -le $listlen | Should -be $true
    }
}
Describe Get-NumericChars {

    [int]$length = 10
    [int]$ratio = 3
    [int]$listlen = $length / $ratio

    $CharList = Get-NumericChars -length $length -ratio $ratio

    It "Returns a list of numbers only" {
        $CharList | ForEach-Object {
            [regex]::match($_,$CharList) | Should -be $true
        }
    }
    It "Should not contain any spaces" {
        $CharList -match '\s' | Should -Be $false
    }
    It "Length of array returned should be between 1 and $listlen" {
        $CharList.count -gt 0 -and $CharList.count -le $listlen | Should -be $true
    }
}
Describe Get-LowerCaseChars {

    [int]$no = 5

    $CharList = Get-LowerCaseChars -no $no

    It "Returns a list of lower case letters only" {
        $CharList | ForEach-Object {
            [regex]::match($_,$LCRegex) | Should -be $true
        }
    }
    It "Should not contain any spaces" {
        $CharList -match '\s' | Should -Be $false
    }
    It "Length of array returned should be $no" {
        $CharList.length | Should -beexactly $no
    }
}
Describe New-RandomPasswordDev {

    [int]$length = 10

    for ($i=1; $i -lt 5; $i++){

        $randomPassword = New-RandomPasswordDev -length $length -Complexity $i

        $regexCombo = '[' + ($fullRegex[0..($i-1)] -join '') + ']'

        It "Complexity $i returns password of length $length" {
            $randomPassword.length | Should -beexactly $length
        }
        It "Password should not contain any spaces" {
            $CharList -match '\s' | Should -not -be $true
        }
        It "Complexity $i should only include the correct character types" {
            $randomPassword | ForEach-Object {
                [regex]::match($_,$regexCombo) | Should -be $true
            }
        }
        <#
        if($i -eq 3){
            It "Complexity $i should not include the wrong character types" {
                [regex]::matches($randomPassword,$NANRegex) | Should -be 0
            }
        }
        elseif($i -eq 2){
            It "Complexity $i should not include the wrong character types" {
                [regex]::match($randomPassword,$NANRegex) | Should -not -be $true
                [regex]::match($randomPassword,$NUMRegex) | Should -not -be $true
            }
        }
        elseif($i -eq 1){
            It "Complexity $i should not include the wrong character types" {
                [regex]::match($randomPassword,$NANRegex) | Should -not -be $true
                [regex]::match($randomPassword,$NUMRegex) | Should -not -be $true
                [regex]::match($randomPassword,$UCRegex) | Should -not -be $true

            }
        }
        #>
    }
}