Remove-Module RandomPassword
Import-Module 'C:\github\RandomPassword\RandomPassword.psm1' -force

# Set Regex variables
$LCRegex   = 'a-z'
$UCRegex   = 'A-Z'
$NUMRegex  = '0-9'
$NANRegex = '!£$%&*=+@#?'
$fullregex = $LCRegex,$UCRegex,$NUMRegex,$NANRegex


InModuleScope RandomPassword {
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
            $CharList -match '\s' | Should -not -Be $true
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
            $CharList -match '\s' | Should -not -Be $true
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
                [regex]::match($_,$CharList) | Should -BeTrue
            }
        }
        It "Should not contain any spaces" {
            $CharList -match '\s' | Should -not -Betrue
        }
        It "Length of array returned should be between 1 and $listlen" {
            $CharList.count -gt 0 -and $CharList.count -le $listlen | Should -BeTrue
        }
    }
    Describe Get-LowerCaseChars {

        [int]$no = 5

        $CharList = Get-LowerCaseChars -no $no

        It "Returns a list of lower case letters only" {
            $CharList | ForEach-Object {
                [regex]::match($_,$LCRegex) | Should -BeTrue
            }
        }
        It "Should not contain any spaces" {
            $CharList -match '\s' | Should -Not -Betrue
        }
        It "Length of array returned should be $no" {
            $CharList.length | Should -BeExactly $no
        }
    }
    Describe New-RandomPassword {

        [int]$length = 10

        for ($i=1; $i -lt 5; $i++){

            $randomPassword = New-RandomPassword -length $length -Complexity $i

            $regexCombo = '[' + ($fullRegex[0..($i-1)] -join '') + ']'

            It "Complexity $i returns password of length $length" {
                $randomPassword.length | Should -BeExactly $length
            }
            It "Password should not contain any spaces" {
                $CharList -match '\s' | Should -Not -BeTrue
            }
            It "Complexity $i should only include the correct character types" {
                $randomPassword | ForEach-Object {
                    [regex]::match($_,$regexCombo) | Should -Be $true
                }
            }
        }
        It "Should support very short passwords" {
            for ($l=1; $l -lt 5; $l++){
                for ($i=1; $i -lt 5; $i++){
                    $randomPassword = New-RandomPassword -length $i -Complexity $i
                    $randomPassword.length | Should -BeExactly $i
                }
            }
        }
        It "Should throw an error if password length is 0" {
            { New-RandomPassword -length 0 -EA STOP } | Should -Throw "Cannot validate argument on parameter 'length'"
        }
    }
}