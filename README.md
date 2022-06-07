# SalaryReaderMac

Salary details reader for my company, they only have Windows version lol

Need to decomplier that Window shit (wrote in .NET), than rewrite it in both Python and Swift.

## Preview

What Windows version looks like:
![](/screenshots/AlertReaderWindowsVersion.png)

## How it works?

We are talking about "Alert Reader" (aka salary reader windows version) here.

1. When u select `.enc` file, it will require u to enter the password.
2. Convert that password to md5, than take first 8 letters as `sKey`.
3. 