# `gpg`

GPG is plain unusuable shitty crap.  But we do not have something better.

> Why?  Because even the most simple thing is implemented the worst way you can imagine.
>
> There is not even any trace of an explanation of what GPG does if called as `gpg file`.
> Anything can happen.  It even might run things, which you cannot express on commandline
> with options.
>
> **Hence you are required to build your scripts on the hope that gpg guesses correctly**
> as nothing is guaranteed nor provided nor granted for sure, now and in eternity.
>
> What I want to write are scripts.  Which can run today.  And can run in 50 years from now.
> Because they are based on a STANDARD.  `gpg` is not a standard.  `gpg` is the problem to solve.
>
> WTF!?!

## Signing fails?

When signing fails there are, at least, 2394230o9320590239420394293840923749023797209374802384239023498239428349823 possibilities why it can go wrong.
You are in bad company, as zillions of people out there have exactly the same problem.  Trust me.

See also:

- https://github.com/keybase/keybase-issues/issues/2798
- https://superuser.com/questions/520980/how-to-force-gpg-to-use-console-mode-pinentry-to-prompt-for-passwords

### GnuPG fails because it cannot read the passphrase

Here is what I need to do to get it working (note that I hate the mouse, so I always bring things back to where they belong:  The good old tty):

	apt install pinentry-tty
	update-alternatives --set pinentry /usr/bin/pinentry-tty

> This probably changes behavior of other programs, too!

Another way is to use in your `.profile`:

	export GPG_TTY=$(tty)

> This probably only affects GPG


## Create a key

See also:

- https://alexcabal.com/creating-the-perfect-gpg-keypair
  - Note that the master signing key is called a subkey there.  Don't get puzzled.

You want to create a key from scratch.  Puzzled due to the zillion of possibilities to do it wrong?  Crying out loud?  You are not alone.  Here is a short note:

	gpg --full-generate-key

> Sorry, I did not find out how to do this noninteractively like with `ssh-keygen`.

- Choose "RSA and RSA".
  - You should not use DSA because you cannot be sure your local random is good enough, as they already mixed that up in the past.
  - If GPG offers post quantum asymmetric encryption, probably chose that.  Hopefully this will be available in 2024.
- For the master key use the maximum RSA bits they offer.
  - Note that higher does not mean much better.  For each doubled number of bits (which quadruples the calculation time) the key gets only approx. 8 years stronger.
  - 4096 should be safe until 2035.  Which means - encryption wise - doomsday is next week.
  - Note that the NSA is probably 10 years ahead of us, hence RSA 4096 can be broken by them in 2025.
  - But not on a large scale.  I expect that NSA can only break 1 RSA 4096 per month in 2025 with eats up all their ressources.
  - But this rate doubles each year, so in 2035 NSA can probably break a hundred RSA 4096 per day.
  - As soon as Quantum Computers reach around 10K Qbits, they will break RSA 4096 within seconds.  And a few hundredthousand of RSA-Keys in parallel.
  - This can already happen before 2035.  If so, Quantum Computers will reach general availability before 2050, thus breaking DSA and RSA forever.
- Your master key should never expire.
  - It's ridiculous, as they will go out of use in the next decade anyway.

The rest should be self explaining.  Next step is important:


### Create a backup

	gpg --output revocation.txt --gen-revoke KEY
	gpg --output secret.txt --export-secret-keys --armor KEY

where `KEY` is the mail address you entered with `gpg --full-generate-key`.

Backup the revocation certificat and secret.txt somewhere.  **Different locations, of course.**


### Add a signing subkey!

The master key should be kept safe.  Even that it is Passphrase protected.  As there is only a single passphrase, so typing that in would expose your master key.

> The master key is something like an identity which should not change.
>
> I did not find the correct way how to just export subkeys with an new Passphrase.  Why are even the most basic things that difficult with GPG?

	gpg --edit KEY

where `KEY` is the mail address you entered with `gpg --full-generate-key`.

- `addkey`
- Choose `RSA (sign only)`
- You can use the default here
- Validity can be set lower, but I think no expiry is ok here, too
- `save`


### Now create a new keyring with just the subkeys

T.B.D.  (Sorry. timeout)



## How to diagnose keys

Use `gpg --list-packets`

Example:

	git clone https://github.com/nodejs/release-keys
	cd release-keys
	git log --follow --oneline keys/DD8F2338BAE7501E3DD5AC78C273792F7D83545D.asc | cat

```
7a9f254 Rebuild GPG keychain and keys list from latest documented Release Keys
de13f37 🌈 Initial commit of Node.js release signing keys
```

	gpg --verbose --list-packets keys/DD8F2338BAE7501E3DD5AC78C273792F7D83545D.asc > A
	git checkout de13f37
	gpg --verbose --list-packets keys/DD8F2338BAE7501E3DD5AC78C273792F7D83545D.asc > B
	diff B A

My interpretation of this diff (perhaps I am mistaken, because I am not a `gpg` Guru) is,
that the key did not change, only some unnecessary signatures were deleted:

```
22,45c22
< # off=607 ctb=89 tag=2 hlen=3 plen=435
< :signature packet: algo 1, keyid 475D819F84128D74
< 	version 4, created 1528335148, md5len 0, sigclass 0x10
< 	digest algo 10, begin of digest d1 94
< 	hashed subpkt 33 len 21 (issuer fpr v4 D8B9874806B402C7F79C3FEB475D819F84128D74)
< 	hashed subpkt 2 len 4 (sig created 2018-06-07)
< 	subpkt 16 len 8 (issuer key ID 475D819F84128D74)
< 	data: 2DD6AC39CD6A9D5F7E212E5DA6F8655CA5BB3A464D426773A61F08AD2DD50152A4CAAD394495E8D86890F56589FCE14A0CA4BE88702C835CD469AC990C691816FD53F9C20C603FFB0D0FE79D6EA3A7D568426D70FF83AFC7D1E7FF041020B4C794576515A9C3B57E98E5D95C20E841E192F8B5DF2554F6420B77C75424ED6A1686E5947026AB6755C93A69537CE4CB8C86E404DE0821093C074840A0C4A2FFA67AD89F26D4AD78CBC43BC72F361E5A2B908E66A4A589989A6236B3189B881AD0D50FA8EF24E5BC5B1D90645DE90F53600EA8270AA57BECC7C31769D7AFA564C2D84740B639B40AC5E43A2AC732DFBC8569C255CB7421B7D34D99071346D1FFFA888503913E1B5CD3E7F503968A11DC26632EE91B0A55C7F3F3EF550B141B3F8DF0AB06568EE13EAC3CB9BF38C787A7FAECE24A54AF8113D2BCA963CC12E584B5A087BC747955D786B80668D407B2A30EFA898BB954C2F81A41C70BC465E4007ED31B17C4320C2FFAF49DDB03D4D46F111E558A54E59C6F3A2B33352C3B897DE9
< # off=1045 ctb=89 tag=2 hlen=3 plen=540
< :signature packet: algo 1, keyid 9551A0B1A6E297CE
< 	version 4, created 1488906916, md5len 0, sigclass 0x10
< 	digest algo 2, begin of digest 8a c9
< 	hashed subpkt 2 len 4 (sig created 2017-03-07)
< 	subpkt 16 len 8 (issuer key ID 9551A0B1A6E297CE)
< 	data: 9BF7A96C6326AF5093AC15DEB0F2980E10D263C5917AE094740F1D6B4AC0B856051A9B9CD555AB09DBDA009F3A5E090CEDD2C6B34E02D8AF3C40E1163F82E23B141988DE9D67C21502A6B1B940CB84D6267E3D756F9133673560E5A46192903CA20B4111DE459594409A2610E64831F154D97E2305E077A266C78ED11D8BFAE2B38D1444477CC8F30948B9B8BB3ECE8214D95F2CCB78FB1EFD74FBFCD41814B2DF049A52598D2BEEF0908F564B7064710FF5E807DEB7E0DEE5749574326ED93C211121325C71605EFF544006E3E5EF3F7C6F12FE43DA9502A7CD0C69E1E62D802EDA72AD4B18E5F9052D1E15DC029F236465486E1E48D262A83A1A31219A0121526A30F45CDA003D893BC9573185ED8974D753755E63DD9BEE012DEFA1DD79FB8084F151A360E9A52401D9087577AF964568F17C871565C3236F2DDC0F305866F7E3261CF1BFEDEA4A5CDE61E0D22D9524C80451B212DC7752EF9598879EDBDE88CBAF7A17A654B710D97B42261EA609F1491F091196802CC125B55E20C46B26DC73F0A893968F8E4FECA335421F583D9727904C843B402610CC0D93ADF08B3AF2F4F6982E4C64450B6DA2919CE03C3F5D0B9BE8D4CBE345CCD3DA0DE00F1AAB8EFB77E6FDFE665438649F94D86F44C3E5C5267F5BA38657C5F7E3EA33E716210B65F4B02063FD11468F5CC5E1FE5A2FF0831FAF7EDC42C137EB403CD9144077
< # off=1588 ctb=89 tag=2 hlen=3 plen=546
< :signature packet: algo 1, keyid E73BC641CC11F4C8
< 	version 4, created 1460489162, md5len 0, sigclass 0x13
< 	digest algo 8, begin of digest 73 0d
< 	hashed subpkt 2 len 4 (sig created 2016-04-12)
< 	critical hashed subpkt 3 len 4 (sig expires after 4y1d0h0m)
< 	subpkt 16 len 8 (issuer key ID E73BC641CC11F4C8)
< 	data: 3A615D37D44CF064BEBB87E64249691AF5247EA355C7556BE32C639C48E7819C3FBC0B5EF4437D0D615304812C2D17C918D0CE64E86944A4828DB8E62A36985790D7E7D34CACA89D46F162069869EC03F83FE0B6121ADE2DB4BF2BA16E7CD8FB3721301847F39580705C72CB0BE907729608565BAC0A62CE72A0E9F9D69AF415FD16C8045F43189A14DB70AD9B1E491AC59600A05F4F87ADF8A7D621F397C9BF23C048CB033E7D6FA493A8B18AD9053ECCEF4FEF6C80B8F9BE2525EFEA49CCB22CDC6C0E0E42D509609EB4B7CE5CFED70EB70142953A384C69682E2E6B8B5585F89A4C9918141E3765AD2B3FC7A0C7CBBBB41B3D582EAB537C3282C2C9B83F6C75A8451D8E1CE7678145D22F010A30D68123DD65B724837BD938923856C232214D475B759DECDAA2479FF3DA4D2CC9499F327A05E2969A248CB2639C4F752AF1C9A642999B177374719C8ECB630CAE706D9B4888C18E0D27F6252DB023D5FE2EAEB016905227CD609D13F2FA54EF775B00FBB072CE72AF1F296BFFDBF418EE418FF026EEB79F627BAC14AF9DD220433B076D7FCDD72B236343ED1F41768D21F3AECD808BAF7BA10DFD6D3C41B0AC4C0BBCBA476D28E212A6BA815D0EF2EC21141911651DB88B7E1C9A36CD481ED483569B7A46AFD4E57DF9664DCC4AC2F8E19B93A92EC713F40C8D0CBCA10D94B49CA166B9CE92A1E34FE83F933D5B299F893D
< # off=2137 ctb=b4 tag=13 hlen=2 plen=23
---
> # off=607 ctb=b4 tag=13 hlen=2 plen=23
47c24
< # off=2162 ctb=89 tag=2 hlen=3 plen=312
---
> # off=632 ctb=89 tag=2 hlen=3 plen=312
60,91c37
< # off=2477 ctb=89 tag=2 hlen=3 plen=435
< :signature packet: algo 1, keyid 475D819F84128D74
< 	version 4, created 1528335147, md5len 0, sigclass 0x10
< 	digest algo 10, begin of digest 12 6f
< 	hashed subpkt 33 len 21 (issuer fpr v4 D8B9874806B402C7F79C3FEB475D819F84128D74)
< 	hashed subpkt 2 len 4 (sig created 2018-06-07)
< 	subpkt 16 len 8 (issuer key ID 475D819F84128D74)
< 	data: 5D92ED5CB112FE415DBA46A5172C6F4073137CF38395E1D0927AADB1B1CCBCF6BC72BACC6AC7D1895D35B58F277B5449A1BD7967F2A1D83477A1FF13386E375F16CFD68B534D9E4EECDBF9FFBD24BC3FD407C24163639BB6B8646D1744BCAC461C33799E6E1BD559B00D0BCE7CCB2B071E337D385541686DAF1F9FF158437AAD5A90A8201419B589F9400D199A780BB38A12A6A9F9AB33E07BA8A28355106A82FF554021B4CAED53D477B92A2AB3E6E9856A2DBF84963C61FBF4628F15497ED879852E685AE1BAFF3FEAF89E15A291255CFA65C9BB941569A6E1DDAB26BF69A9533551D20C304754A1244A2E5D19C278965B79648C915F7F8A38F2CD461AA82AC1FDDF0916AC6CC1FC33F6668974F2F9A58E38F836537A81D82D62C7508CA85C4C57B681F2DBEE0F42C77EB69C4F39C378725A5F4F3853F7E9A57A426FA7AFDE8FFD014A46AC1DE34499C71D313B71C6458A6095B4D7FD7DD3135DEDE84209063A0F06C60DD2B70AD07D101E2E5FD2B5E33FFB1C4A1D7253B62428C4B7AF476C
< # off=2915 ctb=89 tag=2 hlen=3 plen=540
< :signature packet: algo 1, keyid 9551A0B1A6E297CE
< 	version 4, created 1488906916, md5len 0, sigclass 0x10
< 	digest algo 2, begin of digest 37 65
< 	hashed subpkt 2 len 4 (sig created 2017-03-07)
< 	subpkt 16 len 8 (issuer key ID 9551A0B1A6E297CE)
< 	data: B0F5CDD2A7799E307371230E4D2C1854E5F9FF534D588E1A73491BB5D821F5BBDC5B12F53AD4749E4880E9EBE64ED0BB1EE3122ADBE232DA47C081E9D5356EE27BA8B0550968B464C6FE3753B45E41293C9F115605CB9C2C868BF3F57CF5898B1FA2C0584AFACDA3F62A84700CB26BE667E953C18B681562B6D1B3C4DF6596498F440D76B92EC71E046A8B50FC6DC6558F8107A01E0B8F95342FF1A9AA053F522B54477D9F9A67EFCD014C59544C7C91CFDFCF58DA545B72A0BFAD95DAD94487E560BEA037A3851AB9D12DC1FEFD6307C8ED62D5995E66100A4F7C282501FB8724F2E48B6191AD669B7895BD994856F7221180CC94790C181923A62B7F09C17CEC5DB74556BFFA54D0FCCD19B97F88B456148D5A20E708B16915D3E5C37A075EF244DD86FAE56C4F83B2DF2C05D20A37EE01271906565BA02859E52DC4CF88C02CCF55B76F4C13DCF800CD26207F7D8A502B714A024EEEB90A39FD6FCDCB87F0BFCC607E97DC257D666E195D76D34B2329D382C225930EDCAFCBE2573EB18B3F2852429799ADEF3097B39EAD6B9DB64C5820FB8255ED9C88FBBE193C0F8C241EB8EDC74788D60C221DEB1548B3E0F251402BB735D7B20A4B4284048529A83600C20A10A7A8C39CFE7B7104EB3472EC4AC104B6FD4FFD780413E7E45452BF40378A2415C3BEE2DF40ECD58B91397EEC5AC37BE2C8097F2B4B8B2F6F753DC98B3F
< # off=3458 ctb=89 tag=2 hlen=3 plen=546
< :signature packet: algo 1, keyid E73BC641CC11F4C8
< 	version 4, created 1460489147, md5len 0, sigclass 0x13
< 	digest algo 8, begin of digest a2 cc
< 	hashed subpkt 2 len 4 (sig created 2016-04-12)
< 	critical hashed subpkt 3 len 4 (sig expires after 4y1d0h0m)
< 	subpkt 16 len 8 (issuer key ID E73BC641CC11F4C8)
< 	data: E4868559EDCBD5372475A22EFB3FCE97112C2FC8C53495425DD8D4A0E524E0F29FD81A4C6D65CCF4DF89AD9C37923C965FFFD2E839790E8FED3BD253317D1BB7021F859524BAFC7B1F83A1DFC50AC240E5DB4EC317D24C0DE53AFE1FEBB168C09B354BC4C85D6C41880D09618D882C65B2630B96DE643B987C328EC9EEB91D46BEF8EEA1E44381776A8B465FE91891CB9408863CBB706378DEC046650AB94EF79F1A4E43E5007C61FA5B5158B776CD8174C6705A5AFA4539502B8C33644D2BB261836D05AE8E98A3D9E0190F41BE40BFD6FD182C09D9DC5D9547FB19EC411E500D45B01CC3491798224E60BC713B1F234119D0F132E22FD45DB3873E5E596825F62C0FF471BC8BD400A32A1445E63250673BD5497A2C38AF417BA4D1FA558A7B6E7CF53625B73229A4D0A8F3D934CE5697D1FA486D84C14EFA80A925286C7EAABD5965F6F8C33F742D75A0819FAFF906A8AE834A421B7E592A16704456E33EB947B439E0D5216AC41793B6DBEA46782D187B3AF3A78C7EDE52FC39BB052865B0C537666E921C478CD3F84AF774F01D2C115C9BF2DED0E763BF5B23FCB2CE0BA14A83BA8A1BBADA82591048C105F0302D5A41361F53F6CB0BE4CBC1C0AE4E4E3342D7731B9B328F38F6466B2E119B96DF3ECE9DF67DA7EC40422C340CE8A82479D1748726131BD3398F9AF5C201FB24D7058A96016033BBE8D335D260B83C89F6
< # off=4007 ctb=89 tag=2 hlen=3 plen=563
< :signature packet: algo 1, keyid E73BC641CC11F4C8
< 	version 4, created 1542733275, md5len 0, sigclass 0x10
< 	digest algo 8, begin of digest b4 ba
< 	hashed subpkt 33 len 21 (issuer fpr v4 C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8)
< 	hashed subpkt 2 len 4 (sig created 2018-11-20)
< 	subpkt 16 len 8 (issuer key ID E73BC641CC11F4C8)
< 	data: 64D9803FA87E4A0A4DC3D74D303C58CEBEAC7DC7C4A36437397BF9969CC4541CD8939234DFB6C928BA838B3850977FFD4C741F6176771D3FE5B16B3731912DD47A4D920E0C1803A514E00756DEF9737C8DCC64369B8E793E3503499ACB8B7D82030DA3510D72BFB3AAFB1878E9BF0F28A31EFD4A8D302D15EDD7FFF4F41A3AC8D2ABB0B7BE58A268A6FB25018F5A5B8EE0E53D6D60E631FF471BCFAEFFE2178E92067D7701176CD2E8D0A591674B60F8EFC4C495DCB0A65187B2977C8371D51113CE6F24B8DC37B090B4268AB8BFDFAF836C35B15531827AAFE2C0060F0FF1739899005795E47681E9774E63B07B5BD993DF65FF5E656C24F06F13CFE93590E1D36BF497FD65F7103D57282DA9DF515883F26360A7C45E10BCD03DFBE9DA76A579030B33378B22842BDFDB4101AA8D8643C31789B05EA983728B29EBBCB37AAA15BC5046160ADD391D857EE819F8474038556DB76F1CD5A16CDE97688114A3A59364F59FA3096507909161F71919D821C2F168170A788134D62B4A23CE369268B5EEBB7C8969E52620C6BB38A6482EC70C2E56390570CCC803769684226D4EDEA81075DB4EC882F1F4E256AF93F5E01290DBACEF186EC631AB681217D526DEC513981408A03C48D84A6772EADC2123673A2D9FB6A4BB7E1C79310B337F7FF152CF5CFCC9F72ACA879E428B0CBC9D6F2C8ED6DA036164DA9603B936B099ADB2FC
< # off=4573 ctb=b9 tag=14 hlen=3 plen=269
---
> # off=947 ctb=b9 tag=14 hlen=3 plen=269
97c43
< # off=4845 ctb=89 tag=2 hlen=3 plen=287
---
> # off=1219 ctb=89 tag=2 hlen=3 plen=287
```


## How to find keys

On Ubuntu 20.04 `mmdebstrap buster "$TARGET"` gives:

```
W: GPG error: http://deb.debian.org/debian buster InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 04EE7237B7D453EC NO_PUBKEY 648ACFD622F3D138 NO_PUBKEY EF0F382A1A7B6500 NO_PUBKEY DCC9EFBF77E11517
```

And now?

> Some pages recommend keyservers.  **DO NOT DO THIS.  NEVER NEVER NEVER!**
>
> Using keyservers is like recommending an atomic bomb to open your front door.
> It just blews away all of your protection.  For sure!
>
> Some pages recommend to `curl | apt-key` or similar.  **DO NOT DO THIS.  NEVER NEVER NEVER!**
>
> Using this line is like leaving all your valuables at some lonly place with no protection
> nor survaillace at all and publicly telling every single person on this planet of where those
> valuables are.  Hence you trust every single person on this planet not taking away anything.
>
> Both ist just plain stupid.  Or worse.

Try to find where the key resides on your machine, like:

```
for b in 04EE7237B7D453EC 648ACFD622F3D138 EF0F382A1A7B6500 DCC9EFBF77E11517; do for a in /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/*.gpg /usr/share/keyrings/*.gpg; do gpg --list-keys --keyring "$a" "$b" >/dev/null 2>&1 && echo "===> $b in $a"; done; done
```

gives

```
===> 04EE7237B7D453EC in /usr/share/keyrings/debian-archive-keyring.gpg
===> 04EE7237B7D453EC in /usr/share/keyrings/debian-archive-stretch-automatic.gpg
===> 648ACFD622F3D138 in /usr/share/keyrings/debian-archive-buster-automatic.gpg
===> 648ACFD622F3D138 in /usr/share/keyrings/debian-archive-keyring.gpg
===> EF0F382A1A7B6500 in /usr/share/keyrings/debian-archive-keyring.gpg
===> EF0F382A1A7B6500 in /usr/share/keyrings/debian-archive-stretch-stable.gpg
===> DCC9EFBF77E11517 in /usr/share/keyrings/debian-archive-buster-stable.gpg
===> DCC9EFBF77E11517 in /usr/share/keyrings/debian-archive-keyring.gpg
```

On your side you probably need `apt-get install debian-archive-keyring` first to be able to see this.

> The interesting part ist that neither `gpg --list-keys` nor `gpg --fingerprint`
> shows these keys such that you can grep for the or create some index database
> of your own.  I haven't found any command which is able to reveal all(!)
> of the keys outside of gpg.  Hence `.gpg` files stay a mystery as you cannot
> dump them in a format like they are used in `gpg`.  `gpg` is not a tool,
> it's just a black box which you only can hope that it works as expected.

Now that you found it you can do it:

```
DIR="$(mktemp -d)"
cp /usr/share/keyrings/debian-archive-keyring.gpg "$DIR/"
mmdebstrap --aptopt="Dir::Etc::TrustedParts \"$DIR/\";" buster "$TARGET"
```

# How to verify keys?

Don't try this yourself.

If you ever try to grok this, you'd rather think about start running down the middle marker of a busy street at rush hour, blindfolded, yelling, and naked.  Trust me, that's a far better experience than to try to understand how GPG works when it comes to verify a key to find out you can trust it.

> It should be easy, right?  Nope, wasn't implemented in the last 24 years.  And don't have hope for the next 24 years!

The only thing is that there is somebody you trust, and this one verifies it for you.  However if you are not in the lucky situation to directly know this one, you probably end up on how to trust the key of the one you trust.  Wash, rinse, repeat.  Deadklock.

The sad thing is that the small world phenomenon does not work here.  Keys are usually only signed once.  Hence there is no signing mesh, it's a short signing chain, which suddenly breaks.

The only thing you can rely on is, that if you trusted a key in the passt, you can - probably - trust it in the future, too.  And you can prove this relationship.

> So it's not completely futile.

But there is the bootstrapping problem:  How to trust the key the first time.

## Best property: Time

If you do not happen to directly know somebody trustworthy who can verify the key for you, and usually you don't, the probably best solution to the problem is time.  Just dig down into the Internet and try to find when a key first arrived.

> Well, you probably have to trust Google and GitHub and some others like archive.org or mirrors on Universities, too.  But it is unlikely that they all will cheat on you.
>
> But don't trust Keyservers.  Keyservers are connected and if one is infected, the infection can spread easily.  Information there is not trustworthy.
> They are like a phone book where anybody can enter anything and nobody even cares.
>
> Well, wrong.  [They care.  But cannot help.](https://www.heise.de/security/meldung/Angriff-auf-PGP-Keyserver-demonstriert-hoffnugslose-Situation-4458354.html)

So what you can do is:

- Look at the oldest key you can find and read, if something is compromized.  If not, it is probably is safe.
- Then follow the evolution of the key up to the current time and see, what happened to the key.
- If you then find some trustworthy source in the process, fine, then things got better.  But if not, you still get a good idea about the key's history.
- Then, at the end, you must decide if you can trust the latest variant of the key or not.

> Do not forget all the common problems here which erase from RSA.  An old RSA 2048 bit key might got already broken thanks to it's age.
> But that's quite unlikely today.  In 2030 things can look quite different, or, with some breakthrough on Quantum Computing, 2025 can become dangerous already.
>
> Note that RSA 4096 does not buy us much time, so it is not worth to think about it.
> First, factoring the double number of bits does not mean you need double the time,
> but even worse Quantum Computing will expose the usual exponential growth.
> So if Quantum Bits double in 3 years, RSA 4096 will be broken 3 years after RSA 2048.
> Or even less.
>
> So we need quantum safe PKI in the next couple of years, or everything is lost.
>
> Read: **They already have taken too long to create usable crypto.  So they will lose everything archived in the last 30 years!**

## Sorry, I have to stop here

I first must manage all the other insanity before I can come back to this here.


