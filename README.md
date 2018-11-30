# RandomPassword

Random password generator for PowerShell

## Overview

This module enables you to generate random passwords of varying length and complexity.

## Compatibility

The module is intended for use in PowerShell 6.0 +

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
