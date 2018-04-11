# Rants about ES6

## 2018-04-11 weird block level scoping

Today I learned, that scoping of ES6 is a bit weird.  Look at this:

```
let k=-1;
for (let i = 0; i < listItems.length; i++) {
  let element = listItems[i];

  element.addEventListener('click', function() {
    alert('number ' + i + '/'+k)
  });
  k = i;
}
```

I would expect, that there are 3 scopes:

- The scope of `k` (the outer scope)
- The scope of `i` (the scope of the `for` loop)
- The scope of `element` (the scope of the `for` block)

And that these scopes are all different.  But actually this is not the case: **`i` is in the same scope as `element`!**

> Well, this is very helpful, as this do not need to create a closure to pass `i` it individually to the alert.
> In case `listItems` has length 5 you get these alerts: `number 0/4`, `number 1/4` to `number 4/4`
> For more on this see: https://www.sitepoint.com/joys-block-scoping-es6/
>
> From a naive view you would expect, that `i` and `k` will behave the same way, as `let i` is outside the inner block.
>
> So no, `let` does not implements the usual scoping rules found in other languages.
> It introduces yet another puzzling scoping rule in the same tradition of `var`.
>
> Again, this is not a bad thing and comes very helpful.
> However it is something completely different than found in other languages.
