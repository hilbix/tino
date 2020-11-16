> **THIS IS NOT A DOCUMENTATION!**  It's just how to get started with babel (`babeljs` or "babel cli") from commandline.


# HowTo use Babel?

Nomen est omen?  If not, why so many "not documented anywhere"?


## Debian Buster / Debian 10

Nowhere documented and impossible to find if you are not already familiar with Babel:

	sudo apt-get install node-babel7
	babeljs --presets @babel/preset-env --plugins @babel/plugin-proposal-optional-chaining,@babel/plugin-proposal-class-properties input.js -o output.js

Notes:

- Perhaps start with `babeljs --presets @babel/preset-env` (not documented anywhere)
- Then see the error output and add `--plugins` accordingly
- `--plugings` accepts a comma separated list (not documented anywhere)


### Example

`es11.js` source from https://github.com/hilbix/js/tree/es11

```
babeljs --presets @babel/preset-env es11.js -o es6.js
```
```
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db
{ SyntaxError: /home/tino/corona/web/es11.js: Support for the experimental syntax 'optionalChaining' isn't currently enabled (14:39):        

  12 | 
  13 | // <script src="*.js" data-debug></script>
> 14 | var DEBUGGING = document.currentScript?.dataset?.debug;          // you can change this later                                         
     |                                       ^
  15 | 
  16 | const _FPA = Function.prototype.apply;
  17 | const _FPC = Function.prototype.call;

Add @babel/plugin-proposal-optional-chaining (https://git.io/vb4Sk) to the 'plugins' section of your Babel config to enable transformation.  
    at Parser.raise (/usr/share/nodejs/@babel/parser/lib/index.js:6344:17)                                                                   
    at Parser.expectPlugin (/usr/share/nodejs/@babel/parser/lib/index.js:7664:18)                                                            
    at Parser.parseSubscript (/usr/share/nodejs/@babel/parser/lib/index.js:8451:12)                                                          
    at Parser.parseSubscripts (/usr/share/nodejs/@babel/parser/lib/index.js:8437:19)                                                         
    at Parser.parseExprSubscripts (/usr/share/nodejs/@babel/parser/lib/index.js:8426:17)                                                     
    at Parser.parseMaybeUnary (/usr/share/nodejs/@babel/parser/lib/index.js:8396:21)                                                         
    at Parser.parseExprOps (/usr/share/nodejs/@babel/parser/lib/index.js:8283:23)                                                            
    at Parser.parseMaybeConditional (/usr/share/nodejs/@babel/parser/lib/index.js:8256:23)                                                   
    at Parser.parseMaybeAssign (/usr/share/nodejs/@babel/parser/lib/index.js:8203:21)                                                        
    at Parser.parseVar (/usr/share/nodejs/@babel/parser/lib/index.js:10442:26)                                                               
  pos: 666,
  loc: Position { line: 14, column: 38 },
  missingPlugin: [ 'optionalChaining' ],
  code: 'BABEL_PARSE_ERROR' }
```

Then:

```
$ babeljs --presets @babel/preset-env --plugins @babel/plugin-proposal-optional-chaining es11.js -o es6.js
```
```
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db
{ SyntaxError: /home/tino/corona/web/es11.js: Support for the experimental syntax 'classProperties' isn't currently enabled (469:8):         

  467 |   get w()               { return this.$.offsetWidth }
  468 |   get h()               { return this.$.offsetHeight }
> 469 |   _pos = tmpcache(function ()
      |        ^
  470 |     {
  471 |       var o = this._e;
  472 |       var x = o.offsetLeft;

Add @babel/plugin-proposal-class-properties (https://git.io/vb4SL) to the 'plugins' section of your Babel config to enable transformation.   
    at Parser.raise (/usr/share/nodejs/@babel/parser/lib/index.js:6344:17)                                                                   
    at Parser.expectPlugin (/usr/share/nodejs/@babel/parser/lib/index.js:7664:18)                                                            
    at Parser.parseClassProperty (/usr/share/nodejs/@babel/parser/lib/index.js:10796:12)                                                     
    at Parser.pushClassProperty (/usr/share/nodejs/@babel/parser/lib/index.js:10761:30)                                                      
    at Parser.parseClassMemberWithIsStatic (/usr/share/nodejs/@babel/parser/lib/index.js:10700:14)                                           
    at Parser.parseClassMember (/usr/share/nodejs/@babel/parser/lib/index.js:10634:10)                                                       
    at withTopicForbiddingContext (/usr/share/nodejs/@babel/parser/lib/index.js:10589:14)                                                    
    at Parser.withTopicForbiddingContext (/usr/share/nodejs/@babel/parser/lib/index.js:9686:14)                                              
    at Parser.parseClassBody (/usr/share/nodejs/@babel/parser/lib/index.js:10566:10)                                                         
    at Parser.parseClass (/usr/share/nodejs/@babel/parser/lib/index.js:10540:22)                                                             
  pos: 14206,
  loc: Position { line: 469, column: 7 },
  missingPlugin: [ 'classProperties' ],
  code: 'BABEL_PARSE_ERROR' }
```

Then:

```
$ babeljs --presets @babel/preset-env --plugins @babel/plugin-proposal-optional-chaining,@babel/plugin-proposal-class-properties es11.js -o old/es11.js
```
```
Browserslist: caniuse-lite is outdated. Please run:
npx browserslist@latest --update-db
```

Whatever this `Browserslist: caniuse-lite is outdated.` means (not documented anywhere):

```
$ npx browserslist@latest --update-db
```
```
-bash: npx: command not found
```

But I think this can be ignored.  It's just garbage output which I do not know how to squelch.
