# Sortable numbering

What is sortable numbering?

- Something needs to be counted
- Something needs to be sorted (by something like `sort` without `-n`)
- Sort order must not be affected if it is numeric or ASCII
- You do not know where the count starts or ends

And ideally:

- Numbers can be detected in ASCII streams and distinguished from text which might contain digits as well


## First try

This recipe here works for numbers which are not directly concatenated.
So between two numbers to sort there must be some nonnumeric separator.

The idea is very easy:

Just use a numeric length prefix, then the number.

If the length reaches `9` then continue with `90` instead,
instead `99` use `9900` and instead `9990` use `999000` and so on
(note: `9991` is not LL(1) parsable, because if you see `9` after `99`
you cannot decide if it is `9999` or `9990`).

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

Expectation depends on what you think how NUM NUM shall be sorted before, inplace or after ASCII.
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


### Negative numbers

I have not thought about this deeply yet.

Technically prefixing with `-` means, that it sorts before any other number.
However -1 (`-10`) then sorts before -10 (`-19`) which is not what we want to see.

We can again use the trick (see variant 2 below) to invert the digits:

- -11 (`-799`) sorts before -10 (`-80`)
- -1 (`-89`) sorts after -10 (`-80`)
- -0 (`-9`) sorts after -1

You cannot express -Inf, +Inf, NaN and undefined though.  It also does not work when you want to distinguish between numbers and ASCII (next part).


### Distinguish numbers from ASCII

If we want to be able to distinguish between numbers and ASCII texts containing digits, we need an escape.
As the format above is too dense (we only want to stick to digits `0` to `9`), we need room to add escapes.

The natural escape would be digit `0`.  Hence this changes to:

- `0` is used as escape.  See below.
- `10` to `19` is `0` to `9`
- `200` to `299` is `10` to `109`
- `3000` to `3999` is `110` to `1109`
- and so on
- `800000000` to `899999999` is 11111110 to 111111109
- `90``000000000` to `90999999999` is 111111110 to 1111111109
- `91``0000000000` to `919999999999` is 1111111110 to 11111111109
- and so on
- `98``00000000000000000` to `9199999999999999999` is 11111111111111110 to 111111111111111109
- `9900``000000000000000000` to `9900999999999999999999` is 111111111111111110 to 1111111111111111109
- `9901``0000000000000000000` to `99019999999999999999999` is 1111111111111111110 to 11111111111111111109
- and so on
- `9989`X
- `999000` X
- and so on

This way we have shifted free the `0` as the first digit.  Now we can add things after the `0`:

- `0@` to `0Z` defines an escape of the following characters
  - `0@` means 0 characters.  It is there as a marker which can inform the parser about that escapement may follow.
  - `0A` means 1 byte
  - `0Z` means 26 bytes
- Lowercase is the same (`` ` `` is not used!)
  - The idea behind that is that you still can apply uppercase/lowercase conversions without problem

#### Inf, NaN, undefined

The above escape is clumsy, as it does not allow us to express things like Negaive, Inf, NaN and undefined numbers
which then also sort correctly (what ever this means to you).

We want the number blocks to stick in the same sort area.  This is given with the above,
with one exception:  Usually ASCII letters sort after numbers, while escaped letters sort before.

We can mitigate this by using `9` as the escape, this is we substract 1 from the first digit, such that `0` becomes `9`.

- `00` to `09` define 0 to 9
- `89` is what `99` was before
- `899` is what `999` was before
- and so on
- Hence `9@` to `9Z` defines the escapes
  - This makes sure, escapes are always sorted after numbers, too
  - As long as you do not escape things which sort before numbers naturally, sorting order is preserved

Now we can also express Infinity:

- `9:` can be used as `Inf`, because this sorts after any other number
- `9=` can be used as `NaN`
- `9?` can be used as `undefined`


#### Negative numbers

Negative numbers should sort before any other positive number and `-Inf` should sort before any other number.

The problem here is that `00` is the `0`.  We can, again fix that by shuffling free the `0`.

That is, `0` and `9` both become an escape.  This leaves `1` to `8` for the first digit (and the full range after them).

- `0` is the "negative" sign
- `10` to `19` express 0 to 9
- `200` to `299` express 10 to 109
- and so on
- `70000000` to `79999999` express 1111110 to 111111109
- `80``00000000` to `80``99999999` express 11111110 to 111111109
- `88`X
- `8900`X
- ..
- `8989`X
- `899000`X
- ..
- `899899`X
- `89990000`X
- `9` is the escape as above

Note that `0X` where `X` is not a digit, again, acts as the same escape as with `9`.


## 2nd try

Now a number is prefixed by the number of digits that follow by a single digit.
If 9 digits are reached, another digit block follows with a new prefix.
Use prefix 0 to end the number in case the digit count is divisible by 9.

Hence:

- `0` Ends a 9er block and (see below) is the negative prefix.
- `1``0` to `1``9` is 0 to 9
- `2``10` to `2``99` is 10 to 99.  There is no `20x`
- `3``100` to `3``999` is 100 to 999.
- ..
- `8``10000000` to `8``99999999` is 10000000 to 99999999
- `9``100000000``0` to `9``999999999``0` is 100000000 to 999999999 - The `0` at the end ends the 2nd block
- `9``100000000``10` to `9``999999999``1``9` is 1000000000 to 9999999999
- `9``100000000``200` to `9``999999999``2``99` is 10000000000 to 99999999999
- ..
- `9``100000000``8``00000000` to `9``999999999``8``99999999` is 10000000000000000 to 99999999999999999
- `9``100000000``9``000000000``0` to `9``999999999``9``999999999``0` is 100000000000000000 to 999999999999999999
- `9``100000000``9``000000000``1``0` to `9``999999999``9``999999999``1``9` is 1000000000000000000 to 9999999999999999999
- ..

Note that this is slightly longer than the first approach but does not have the recalculation problem.
It also is easy to transorm, as you can run this digit by digit with only a memory of 9 digits.

There are ambiguities which must not be used.  These are structural errors and do not cope well:

99 can be expressed as `3099` and `299`.  The latter is the correct one.  Else `3098` (98) sorts after `299` (99)

- `0 12` becomes `10 212`
- `0.12` becomes `10.212`
- `0_12` becomes `10_212`
- `0a12` becomes `10a212`
- `1 0` becomes `11 10`
- `1.0` becomes `11.10`
- `1_0` becomes `11_10`
- `1 0` becomes `11 10`

So it sorts correctly as well.


### Extending to negative numbers

This can be extended to negative numbers:

- output a `0` to indicate negative number follows
- then invert the thingie above, that is negate all digits after the initial `0`
  - the length digits are inverted, too!
  - `0` becomes `9` (which then also acts as the end of block marker)
  - `1` becomes `8`
  - and so on until
  - `9` becomes `0`
- Hence `08x` up to `00xxxxxxxxx9` and so on.
- It's easy, because you have to do nothing than just to flip each digit, which archives correct sort order


### Unused space

There is plenty of room for future change.  Following prefixes do not exist:

- `20`, `30` up to `90`
- `09` is "negative" "inverted 0"
- `089` would represent "negative" "zero" -0 (note that 089 is the dial prefix of Munich in Germany)
- `079`, `069` up to `009`


## +-Inf NaN -0 undefined

- -0 can already be expressed naturally as `089`.  And as `09` does not exist, it sorts right before `10`
- `09` can act as some `undefined`.  It then sorts right in between -0 and +0

If -Inf and +Inf is needed, this cannot be correctly expressed:

- -Inf should sort before any other number.  That is it must start with `00`
  - `00` means "negative" "9 digits"
  - `0``0``000000000``0` means "negative" "9 digits" 999999999 "9 digits"
  - Hence we have a problem, as we need to output an infinite number of `0` to express `-Inf`
- Similar is true with `+Inf`, which needs an infinite number if `9`

In that case we need to make some room for infinity.  As we only want to use the digits `0` to `9`

> T.B.D. (timeout)


## 3rd try (single escape character)

Above we escaped ASCII.  This here is the other way round, we mark numbers but such, that they sort where we want to have them.


### Step 1: Chose where to sort the numbers

First, decide the escape character.  This is the character, where we want to place numbers.
For example, if we want numbers to sort before any normal ASCII, the escape character can be the SPC.
In binary save streams we can even use NUL.

- So if a number is in the text, we replace it by this "escape" with "escaped number".
- If the "escape" shows up in the text, we replace it by "escape" plus another character (which cannot be the first character of "escaped number")

We have to chose this character, too.

### Step 2: Chose the escaped escape character

If we see the "escape" it might be because we want to define the "escape".  The idea is a variant of above:

- `escape` `@` stands for the escape character itself (`ESC` becomes `ESC @`)
- `escape` `A` stands for a single escape character plus 0 additional character plus ESC (`ESC ESC` becomes `ESC A`)
- `escape` `B` stands for a single escape character plus 1 additional character plus ESC (so `ESC A ESC` becomes `ESC B A`)
- `escape` `C` stands for a single escape character plus 2 additional character plus ESC (so `ESC A B ESC` becomes `ESC C A B`)
- and so on
- Again uppercase and lowercase are the same.

If the escape code is SPC, you usually want to sort numbers before anything else.  This is what you want.

However, if the escape code is `~` or DEL, you usually want to sort numbers after anything else (this is why you have chosen this escape).

- In that case you should move the `@` to SPC, and the `A` to `!` and so on.  And you should make sure not to exceed `,`.
- Also it might be, that you do not want to use special characters like `"`, as they usually have a different meaning (JSON).

In the latter case I recommend following:

- Stick to `ESC SPC`, `ESC !` and `ESC %`
- Depending on your expectation `ESC !` can be used as `ESC ESC` and `ESC %` as extended escape use
  - Extended escape use can mean something like `ESC x ESC` is escaped to `ESC % A x`
- Or you might want to use them as mode switching:
  - `ESC !` outputs stands for ESC plus "run until ESC % is found" where `ESC %` then outputs an ESC again.
- Or, if you expect very many ESCs to show up in sequence, you can do some Run Length Encoding:
  - `ESC SPC` gives 1 ESC
  - `ESC !` gives 2 ESC
  - `ESC % A` gives 3 ESC up to `ESC % Z` gives 28 ESC
- Or if you expect a lot of repetitive characters you can define some generic RLE:
  - `ESC SPC` gives 1 ESC
  - (perhaps have a special `ESC ,` which gives ESC ESC)
  - `ESC ! A` gives 2 ESC up to `ESC ! Z` gives 27 ESC
  - `ESC % B u` gives 3 times u (this is a bit redundant, but for simplicity)
  - `ESC % 0 B uv` gives 3 times uv
  - `ESC % 1 A uvw` gives 2 times uvw (`ESC % 1 A ESC a ESC` is shorter than `ESC SPC a ESC , a ESC SPC`)
  - `ESC % 2 A uvwx` gives 2 times uvwx
  - `ESC % 3 A uvwxy` gives 2 times uvwxy (`ESC % 3 @ ESC a ESC b ESC` is longer than `ESC SPC a ESC SPC b ESC SPC`)
  - `ESC % 4 A uvwxyz` gives 2 times uvwxyz
  - `ESC % 7 @ rstuvwxyz` gives 1 times rstuvwxyz (`ESC % 9 @ ESC a ESC b ESC c ESC d ESC` is shorter than `ESC SPC a ESC SPC b ESC SPC c ESC SPC d ESC SPC`)
  - and so on
  - Note that if the u..z contains some ESC it is used literally and does not need to be escaped


### Step 3: Chose the number encoding

Above the `-` was carefully left unused by purpose.  That is how you can express negative numbers such that you can still recognize them.
However to allow negative numbers to sort correctly, you need also to invert all digits which makes them a bit unreadable.

We cannot use `+` as this sorts before `-`, while negative numbers must sort before `+`.

Also note that this here is not for floating point.  With floats:

- `X.0` is equivalent to `X` and should sort at the same position
- `X.1` must sort after `X` and `-X.1` must sort before `-X`
- `.1` must sort after `0` and `-.1` must sort before `-0` and before `0`
- Hence we need a way to sort somerhing between `0` and `1` but in ASCII there is nothing in between.
- Exponents do not sort anyway
- So to make floating point sortable, we need a special floating point way to express it
- Leave that to future

We also want to express

- `-Inf`, must sort before all other number
- `+Inf`, must sort after all other numbers
- `NaN` and `undefined` which should sort between `-0` and `+0`
  - The other placement would be "between" `+Inf` and `-Inf`, so perhaps `undefined` before `-Inf` and `NaN` after `+Inf`
  - YMMV

> T.B.D. (timeout writing this)
