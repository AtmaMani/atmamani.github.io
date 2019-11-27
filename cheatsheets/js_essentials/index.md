Title: Javascript essentials

 - Use `;` to terminate lines. JS supports OO and functional programming. HTML5 is HTML + CSS+ JS.

 - JS can be run in browsers and outside - node.js, windows script host
 - JS cannot access file system since the browser runs it in a sandbox. user needs to give explicit permission.

**Table of contents**
<!-- MarkdownTOC -->

- [Placement](#placement)
- [Types and programming constructs](#types-and-programming-constructs)
  - [switches](#switches)
  - [loops - while](#loops---while)
  - [functions](#functions)
  - [Objects](#objects)
  - [namespaces](#namespaces)
- [Appendix - documentation](#appendix---documentation)

<!-- /MarkdownTOC -->

## Placement
Place `<script></script>` within the end of `<body>` tags. This ensures the page is fully loaded since your JS scripts may have to read elements of the page itself. You can also run a html file with JS in a browser. It loads as a file. This is not scalable for large sites. You need a web server - use `node.js`.

If your JS is in a file, then link to that using the format `<script src="./scripts/site.js">`
**Note** Dont self close the script tag `(<script/>)`

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
 - JS does **not** support default arguments!!

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

### namespaces
 - while JS does not give you a great namespace construct, you can fashion one by creating an object (of object class) and add your methods, classes to it.
```js
if (!yourNamespace){
	var yourNamespace={}; //this is checked everytime yoru scrip is loaded
}

//extend it
yourNamespace.logic1 = function(){};
yourNamespace.obj1 = {
	property1:'value'
}
 ```

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

## Functional programming
For essential purposes, functional programming is declaring functions and passing them around using their references. You can extend the functionality or modify it.

### Closures
 - closures mean, if you have nested functions, the inner function has access to the arguments and variables created in the outer and also modify them.
 - with closures pattern, you can return an object that points to the nested functions as methods. with this you can instantiate an object from a method (blown mind) and 

## Inheritance
 - `prototyping` concept allows you to not only inherit, but also extend your base class.
```js
classname.prototype.your_extension = function(){logic};
```
 - when inheriting your own objects, you will use the `call()` method to call the super's constructor
```js
function Animal(name){
                this.name=name;
            }
function Person(name, age){
                Animal.call(this, name); //calling the super's constructor
                this.age = age;
            }
```
 - if you extended your base class using a constructor, then you got to also inherit the prototypes like below:
```js
Animal.prototype.speak = function(){
                alert(this.name +  " is barking");
            }
//then you in herit the prototype as
Person.prototype = Object.create(Animal.prototype);
//when you inherit, you overwrite your own constructor, so you set it back.
Person.prototype.constructor = Person;
```
 - when inheriting prototypes, you can inherit from any other object. Thus, you can inherit from one object and inherit the prototypes from another.
 - you can, in this way, have prototype chaining.
 - The concept `defineProperties` allows you to declare some properties as read only, making it not possible for inheriting objects to change some properties. It also gives you getters and setters.

## ECMAScript 6 pattern
 - **ECMAScript 6** makes creating classes way more like a proper OO language. You get `class`, `constructor()` `super` keywords and looses a lot of bad verbage making things simpler
 - You really dont play with prototypes in ecma6.
 - you get `arrow` functions, which are lambda functions, similar to that in C#.
```js
()=> {/*function declaration*/}
(x,y)=> {/*function declaration*/} //for a function wiht one or more args
```
 - you read `=>` as `goes to`.

## DOM
 - tree of nodes. Each tag is a node.
 - JS can parse the DOM, modify it based on event the user is triggering.
 - methods like `createElement`, `getElementById`, `getElementByName`, `getElementByTagName` lets you read DOM or search DOM.
 - You can inject html by setting `<div>` tags `innerHTML` to the html text you need.
 - since the browser support varies a lot, you can use [http://caniuse.com](http://caniuse.com) to find support across browsers.

### jQuery for DOM manipulation
 - jQuery is a library and a very popular one. You can use the Google CDN or download and put it in your server as well. [https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js](https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js) is Google's CDN.
 - If you are installing this locally instead of using the CDN, then use `npm` and `bower`. Bower will install it in the root of your site, so when you host your site, you will not forget to host the dependent libraries.
```
npm install -g bower
bower install jquery
```
 - a couple of two different package managers is `yarn` and `webpack`.
 - jQuery tutorial [https://www.w3schools.com/jquery/](https://www.w3schools.com/jquery/)
 - a case for installing the lib locally is, you can step-in to the jQuery code when needed to understand the implementaiton.
 - when you call jQuery, you **dont** get back a DOM. Instead you get back a jQuery result object.
 - in code, `$` is a shorthand representation of lib name `jQuery`.
```js
$(document).ready(function(){
    console.log("page loaded, ready for JS")
    })

//general syntax is 
$(selector).action()
```
 - it is good to check if the page has fully loaded before running JS. you can check it like above.
 - a programming pattern is to use `$` suffix for jQuery result sets to differentiate from JS variables
```js
var divs$ = $.('div'); //get all the selectors of div
```

### AJAX - jQuery library for IO with backend
 - operations are async. AJAX - Asynchronous Javascript And XML. AJAX is used to make calls to backend server or any remote server via HTTP, REST.
 - AJAX call will return a value called a `promise`, while the rest of the script is executed.
 - AJAX object is a `XHR` - XML HTTP Request object - something microsoft came up. There is no JSON in the name since it was not invented yet. However, today's tech still keeps the name XHR to send and receive JSON.
 - AJAX methods - `$.get(url, data, success, dataType)`, `$.getJSON()`, `$.post()`, `.load(url, data, complete)` are some popular methods. 
 - When doing async work, you use the `$.ajax()` which will give you a `promise` and you will call `$.then(function(){})` which will perform the operation once the async op is complete.
 - use `$.ajaxSetup({})` to declare some defaults like the url prefix, method, dataType etc and this will apply for all calls made.
 - `JSONP` is JSON with padding.

## Node JS
 - With node JS, you can power up a server and a client set up. See the node js example.

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