# Constants found, noted, etc.

## How to parse:

- `0constant COMMENT` line starts with `0` (zero): constant in the first column
- `TAG constant COMMENT` line starts with a letter if short explaining tag is used
- Ignore all lines which neither start with `0` or an ASCII letter (lowercase/uppercase)

----

- `0x` hex
- `0o` octal
- `0b` binary
- else decimal

## Microsoft

```
# MSVC Memory patterns
0xCCCCCCCC      uninitialized stack memory
0xCDCDCDCD      uninitialized heap memory
0xFDFDFDFD      "no man's land" guard bytes before and after allocated heap memory
0xDDDDDDDD      deleted heap memory
0xFEEEFEEE      deleted heap memory
0xBAADF00D      before "no man's land" guard bytes
0xDEADC0DE      after "no man's land" guard bytes
0xFEEDFACE      uninitialized memory
0xDEADBEEF      deleted memory
0x0FF1CE        = Office
0xEFF0FF
0xBADC0FFEE0DDF00D = Bad Coffee Odd Food
```

## empties

```
MD5             0xd41d8cd98f00b204e9800998ecf8427e              empty file MD5
SHA1            0xda39a3ee5e6b4b0d3255bfef95601890afd80709      empty file SHA1
git-blob        0xe69de29bb2d1d6434b8b29ae775ad8c2e48c5391      empty file when stored as a blob
git-commit      0xc05f644e67a4e9fd238f7f9b52e9667e6d2ca8df      see https://github.com/hilbix/empty
git-tree        0x4b825dc642cb6eb9a060e54bf8d69288fbee4904      git tree without anything in it
SHA256          0xe3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
SHA512          0xcf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
```

## valentin.hilbig.de

```
0xACD6          Augusta Computer Dienstleistungsgesellschaft mbH (6 stands for G which stands for Gesellschaft)
0xadc9          Augusta Computer Dienstleistungsgesellschaft mbH (9 stands for g which stands for Gesellschaft)
0x60061E        GOOGLE -- note: If Google ever wants this, they can have it
0x90091e        google -- note: If Google ever wants this, they can have it
```
