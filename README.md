# RandomPassword

Random password generator for PowerShell

## Overview

This module enables you to generate random passwords of varying length and complexity.

## Compatibility & Requirements

The module is intended for use in PowerShell 6.0 +

Also requires the clipboard ClipboardText: 

```PowerShell

Install-Module -Name ClipboardText
``` 

## Instructions

The main command is New-RandomPassword, which accepts 2 parameters:

### Length

This is the length of the final generated password.

### Complexity

There are 4 levels of complexity:

1. Lowercase letters only
2. Lowercase and uppercase letters only
3. Lowercase, uppercase, and numbers.
4. Lowercase, uppercase, numbers and special characters.

The password output by the function will be a mix that contains at least one of each type of character specified.

### Nojumble

Use this parameter if you would like to group together characters of the same type. This will result in a slightly less secure password that may be easier to remember.

## Examples

Generate a random password 10 characters long, with lowercase, uppercase, numbers and special characters:

```PowerShell
New-RandomPassword -length 10 -complexity 4
cn0£t#QvEa
```

Note the parameters are positional so you can omit the parameter names:

```PowerShell
New-RandomPassword 10 3
04pkb2PeiG
```


The default complexity is 4, so you can omit this parameter altogether for a password containing a mix of all available characters:

```PowerShell
New-RandomPassword 12
dy&2z1vPf7em
```

Use the parameter 'Nojumble' if you would like to group together characters of the same type for slightly more human friendly passwords:
```PowerShell
New-RandomPassword 10 -Nojumble
RQgufhq$83
```