# SalaryReaderMac

Salary details reader for my company, they only have Windows version lol

Need to decomplier that Window shit (wrote in .NET), than rewrite it in both Swift and Go.

## How it works?

We are talking about "Alert Reader" (aka salary reader windows version) here.

1. When u select `.enc` file, it will require u to enter the password
2. Convert that password to md5, than take first 8 letters as `sKey`
3. Convert `sKey` to `[]byte` (aka byte array) as DES's `key` and `IV`
4. Read and convert file from `string` to `[]byte` (aka byte array)
5. Decrypt it, CBC with PKCS7 i guess

## How to open mht file using macOS?

Microsoft Word. no kidding.

200% support.
