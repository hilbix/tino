# JsFuck

JsFuck is a minimal subset of JS which allows to express all JS programs: `[]()!+`

My thoughts about that why this is unusable:

- It uses `eval`, but strict CSP forbids to use `eval`, `new Function` or injection of `<script>` tags
  - Hence to be able to transpile all sorts of JS, we need a variant, which allows to express all JS programs without using these!

# Q0: [JSF code does not work if CSP forbids `eval`/`new Function`](https://github.com/aemkei/jsfuck/issues/131)

If CSP forbids `eval` and `new Function` (and `<script>` injection) for safety, then code transpiled into JSF does no more work.  As JSF transpiles the code into a string which must be evaluated.

> I think this is a big flaw.  Also I consider the use of `eval` to be cheating, as this way JSF just only does a string conversion and leaves the real dirty part to `eval`.

Is there a (known) subset (or variant/mode) which would make it able to transpile things into code, which does not need to be `eval`ed?  Is this even possible?  Of course I think the character set must be slightly extended (like allow of `=` or some idiomatic `function ($){` with a closing `}`, only used for direct function definition which is allowed under such CSP).

> Sorry if this is a FAQ, but I tried myself a few hours and failed even with try to Google for something like that.  Am I really the first one to ask?


# Q1: Can't we reduce even more?  (not asked yet)

> This question was unfinished, copied here FTR

Can we get rid of `()` in favor of `` ` ``?

This would reduce the characterset to even one less.

We are able to call functions with something like `` console.log`a` ``.  However this only gives strings.  But if we are able to find some function which converts the string into some another object (we could define or own function like tonum`string`) we possibly can get around.  As we already do not have `,`, the limitation of only a single parameter can be circumvented, too.  Also we can use `[]` instead of `()`.

> Note that I tried, but did not find a good solution yet.

See also my other question about getting rid of `eval`


# Q2: Can we make it more compatible? (not asked, see Q0)

> This question was unfinished, copied here FTR

Can we avoid `eval`?

The problem for me is, that due to CSP, JSFuck does not work at my side.
This is because `eval`, `Function` (and `<script>`-injection) is outlawed with my CSP.
AFAICS JSF needs those two, as we do not get `function` the other way.

Arrow functions without `eval` or class constructor either need `()` or some character (like `$` or `_`) for ``` [_=>[expr]][0]``[0] ```.
And the two characters `=` and `>`, of course.

As we can replace `!` probably with `==` and `>` and getting rid of `()` in favor of `` ` `` (see my other question),
this would only extend the character set by 1 character (`` !() `` replaced by `` `=>_ `` ) to make it `eval`-free.
This also gives the benefit, that we can use `=` for assignment, so we probably could get arround somehow for using `eval` here, too.

> I am not sure about scoping, but if we are able to do something like `asm.js` we possible can create some metapreter,
> which is able to evaluate the code.  As 

However I am not completely sure that arrow-functions can replace "real" functions,
as they are lacking a bound `this`.  Perhaps there is some clever way to re-introduce `this`-binding to arrow functions (I do not know one).  If this is *not* possible, then I'd vote for one exception, that we are allowed to use  `function($){code}` where `function($){` and `}` are idioms which are only allowed to create a function context.- 

