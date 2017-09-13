# Javascript essentials

 - Use `;` to terminate lines. JS supports OO and functional programming. HTML5 is HTML + CSS+ JS.

 - JS can be run in browsers and outside - node.js, windows script host
 - JS cannot access file system since the browser runs it in a sandbox. user needs to give explicit permission.

## Placement
Place `<script></script>` within the end of `<body>` tags. This ensures the page is fully loaded since your JS scripts may have to read elements of the page itself. You can also run a html file with JS in a browser. It loads as a file. This is not scalable for large sites. You need a web server - use `node.js`.

If your JS is in a file, then link to that using the format `<script src="./scripts/site.js">`
**Note** Dont self close the script tag (<script/>)

 - sequence of operation, is by the content of the html page. So if you have two scripts 1, 2 they are executed by their precedence in the html page. This same as a stand-alone python script.

 - more nuance. all contents within the same `<script>` tag is loaded at the same time. If you write a funciton in one `<script>` tag and call it from another tag, then you need to place the scripts in sequence.

 - JS does a 2 pass loading. It first passes to find all the variables, objects and functions. In the second pass it actually executes. However if you are playing with function assignment, it would not happen until execution, so you need to be careful and not call it before it is available.

## Types and programming constructs
 - `var` is dynamic object
 - comments - use `//` for single line and `/*  */` for multiline
 - you can also use html comments `<!-- and -->`
 - ternary operator `condition ? expr1 : expr2`
 - binary operator `1+2`, `false + "it failed"`, `true + true`, `"str1" + "str2"`
 - auto increment `++variable` is prefix increment and `variable++` is postfix increment - which is use and then increment.
 - `a += 10` is same as `a=a+10`
 - string, bool, number are **primitive** types
 - compostite types: objects, arrays, date
 - `undefined` is when a variable is declared but not assigned a value.
 - `null` is not same as Python `None`, it is also different from `undefined`. `null` is the lack of any type.
 - `typeof(obj)` for type inspection
 - `a===1` the triple equals is a script value check
 - checking `"12" == 12` will return true! Also checking `"12.0"==12"` will return true. If you are checking for object type equality, then use triple equals.
 - `arrayobj.pop()` to get remove and get the last element. Use `arrayobj.push(value)` to insert at the end.


### switches
```js
switch(variable){
	case 'a':
		break;
	case 'b':
		statements
		break;
	default:
		statements
		break;
}
```

### loops - while
```js
while(expression){
	statements;
	console.log();
}
```

**Note**: When looping through arrays, dont use `for (element in array)` loop. Always use the regular for loop

### functions
 - JS does not support overloading.
```js
function add(par1, par2){
	//statement
	return value;
}
```
 - when defining a function, dont use `var parameter`, use just the variable name
 - **all parameters are optional**
 - you can also pass more than the declared number of parameters to the function.
 - disambiguate named functions - cannot. Use need to use namespaces and modular pattern.
 - built-in variable `arguments[]` to get all the arguments passed to the function.
 - declare variables within functions using `var`. If you use without `var`, then you are using or overwriting the global version of the same variable!
 - type `"use strict"` in your script to print all errors and break on them. Place the strict within your functions and not at a gobal scope - this is because you will use other folks libraries and they may not be up to high standards of coding.

### Objects
 - In object literal notation, you define an object like a JSON file
 ```js
 var person={
 	firstName:"atma",
 	lastName:"mani"
 };
 ```
 - You can extend an object with new properties and assign them at runtime. (same as in a property map in Python or a dict during runtime)
 - You can use `for in` loop to **reflect** over the kvp of an array
 ```js
 for (var key in object){
 	console.log(key, object[key]);
 }
 ```
 - use `JSON.stringify()` to serialize it to JSON and to hydrate it back, use `JSON.parse()`.

### strings
 - strings are immutable
 - you can call regular methods like `strobj.length`, `str.split()`, `str.trim()` to get another string returned by that method.
 - you can also access individual elements of the string just like in an array `stringobj[index]`

### dates
 - `var rightNow = new Date();`

## JS and DOM
 - You can write JS into `<button>` tags
 - JS can read the elements of the html page. It uses the `id` property of the tags (elements)
 - YOu can debug JS from chrome, set breakpoints, use watch window and variable explorer.
 - the console window of chrome is a good JS sandbox. You can simply type commands in the console and use JS
 - you can do the same from console after starting `node`.

## Appendix - Run web server using node.js
In terminal, after installing node.js, type:
```
npm install http-server -g
```
This installs a server, [help for that server](https://www.npmjs.com/package/http-server). Then to start a web server, navigate to the folder with website and run
```
http-server -p 3000
```
You can run this command either from terminal or from the terminal window in vs code.

## Appendix - documentation
 - w3 school - gives high level documentation
 - mozilla developer network - [mdn js](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

**Typescript** transpiles into Javascript!!