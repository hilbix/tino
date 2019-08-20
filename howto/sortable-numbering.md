# Sortable numbering

What is sortable numbering?

- Something needs to be counted
- Something needs to be sorted
- Sort order must not be affected if it is numeric or ASCII
- You do not know where the count starts or ends

## First try

This recipe here works for numbers which are not directly concatenated.
So between two numbers to sort there must be some nonnumeric separator.

The idea is very easy:

Just use a numeric length prefix, then count.

If the length reaches `9` then continue with `90` instead,
instead `99` use `9900` and instead `9990` use `999000` and so on
(note: `9991` is not LL(1) parsable, because if you see `9` after `99`
you cannot decide if it is `9999` or `9990`).

And if this reaches 8 or more, add 9s to disambiguate.

Hence:

- 0 `0` is number 0
- 1 `10`-`19` numbers 1 to 10
- 2 `200`-`299` numbers 11 to 110
- 3 `3000`-`3999` numbers 111 to 1110
- ..
- 8 `800000000`-`899999999` numbers 11111111 to 111111110
- 9 `90000000000`-`90999999999` numbers 111111111 to 11111111110
- 10 `910000000000`-`919999999999` numbers 1111111111 to 111111111110
- 11 `92X`
- 12 `93X`
- ..
- 17 `98X`
- 18 `9900X`
- 19 `9901X`
- 20 `9902X`
- ..
- 107 `9989` Hint: 18+89
- 108 `999000`
- 109 `999001`
- ..
- 1007 `999899` Hint: 108+899
- 1008 `99990000`
- 1009 `99990001`
- ..
- 10007 `999899` Hint: 1008+8999
- 10008 `99990000`
- ..

Hence sorting works:

- `0 201` is `0 12`
- `0.201` is `0.12`
- `0_201` is `0_12`
- `0a201` is `0a12`
- `10 0` is `1 0`
- `10.0` is `1.0`
- `10_0` is `1_0`
- `10a0` is `1a0`

And concatenated numbers?

- `0 2010` is `0 12` `0`
- `0 20110` is `0 12` `1`
- `0.2010` is `0.12` `0`
- `0.20110` is `0.12` `1`
- `00 201` is `0` `0 12`
- `00.201` is `0` `0.12`
- `00_201` is `0` `0_12`
- `00a201` is `0` `0a12`
- `010 0` is `0` `1 0`
- `010.0` is `0` `1.0`
- `010_0` is `0` `1_0`
- `010a0` is `0` `1a0`
- `0_2010` is `0_12` `0`
- `0_20110` is `0_12` `1`
- `0a2010` is `0a12` `0`
- `0a20110` is `0a12` `1`
- `10 00` is `1 0` `0`
- `10 010` is `1 0` `1`
- `10.00` is `1.0` `0`
- `10.010` is `1.0` `1`
- `100 201` is `1` `0 12`
- `100.201` is `1` `0.12`
- `100_201` is `1` `0_12`
- `100a201` is `1` `0a12`
- `1010 0` is `1` `1 0`
- `1010.0` is `1` `1.0`
- `1010_0` is `1` `1_0`
- `1010a0` is `1` `1a0`
- `10_00` is `1_0` `0`
- `10_010` is `1_0` `1`
- `10a00` is `1a0` `0`
- `10a010` is `1a0` `1`

Expectation depends on what you thing how NUM NUM shall be sorted before, inplace or after ASCII.
Above apparently is sorted inplace (numbers sort after `/` and before `:`):

- `0 12` `0`
- `0 12` `1`
- `0.12` `0`
- `0.12` `1`
- `0` `0 12`
- `0` `0.12`
- `0` `0_12`
- `0` `0a12`
- `0` `1 0`
- `0` `1.0`
- `0` `1_0`
- `0` `1a0`
- `0_12` `0`
- `0_12` `1`
- `0a12` `0`
- `0a12` `1`

- `1 0` `0`
- `1 0` `1`
- `1.0` `0`
- `1.0` `1`
- `1` `0 12`
- `1` `0.12`
- `1` `0_12`
- `1` `0a12`
- `1` `1 0`
- `1` `1.0`
- `1` `1_0`
- `1` `1a0`
- `1_0` `0`
- `1_0` `1`
- `1a0` `0`
- `1a0` `1`

## 2nd try

Now a number is prefixed by the number of digits that follow by a single digit.
If 9 digits are reached, another digit block follows with a new prefix.
Use prefix 0 to end the number in case the digit count is divisible by 9.

Hence:

- `0` see below.
- `10` to `19` is 0 to 9
- `210` to `299` is 10 to 99.  There is no `20x`
- `3100` to `3999` is 100 to 999.
- ..
- `810000000` to `999999999` is 10000000 to 99999999
- `91000000000` to `99999999990` is 100000000 to 999999999 - An addition 0 is introduced at the end!
- `910000000010` to 999999999919` is 1000000000 to 9999999999
- `9100000000200` to 9999999999299` is 10000000000 to 99999999999
- ..
- `9100000000800000000` to 9999999999999999999` is 10000000000000000 to 99999999999999999
- `910000000090000000000` to 999999999999999999990` is 100000000000000000 to 999999999999999999
- `9100000000900000000010` to 9999999999999999999919` is 1000000000000000000 to 9999999999999999999
- ..

Note that this is slightly longer than the first approach but does not have the recalculation problem.
It also is easy to transorm, as you can run this digit by digit with only a memory of 9 digits.

There are ambiguities which must not be used.  These are structural errors and do not cope well:

100 can be expressed as `1110100` or as `31000`.  The latter is the correct one.

- `0 12` becomes `10 2120`
- `0.12` becomes `10.2120`
- `0_12` becomes `10_2120`
- `0a12` becomes `10a2120`
- `1 0` becomes `11 100`
- `1.0` becomes `11.100`
- `1_0` becomes `11_100`
- `1 0` becomes `11 100`

So it sorts correctly as well.

# Extending to negative numbers

This even can be extended to negative numbers:

- output a `0` to indicate negative number follows
- then invert the thingie above, that is negate all digits after the initial `0`.  
  `0` becomes `9`, `1` an `8`, and so on until `9` becomes `0`.
- Hence `09`, `08x` up to `00xxxxxxxxx9` and so on.
- It's easy, because you have to do nothing than just to flip each digit, which archives correct sort order

Notes:

- `09` expresses "no number"
- `089` represents `-0` (note that 089 is the dial prefix of Munich in Germany)

Also there is plenty of room for future change:

- `20`, `30` up to `90` do not exist
- `079`, `069` up to `009` do not exist either
