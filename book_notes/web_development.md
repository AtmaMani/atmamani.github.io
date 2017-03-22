# Web Development

## Axioms
 - file names - no spaces, all lower case. Use `-` or `_` to separate words
 - file paths - all relative

## Structure of websites
 
 - index.html
 - images folder
 - scripts folder - JS files
 - styles folder - CSS files

## CSS
Cascading Style Sheets. Structure of a CSS `ruleset`:
![mozilla css ruleset](https://mdn.mozillademos.org/files/9461/css-declaration-small.png)

 - use `property : property_value` notation for a rule
 - within a ruleset, separate each rule by a `;`
 - select and apply same set of ruleset on multiple elements like this
 ```CSS
 	p,li,h1{
 			color: red;
 			width: 50px;
 	}
 ```
 - the above are `element selectors` - they select specific html tags to apply the ruleset
 - `ID selectors` - selects a specific ID of a html tag. use as 
 ```CSS
 	#my_id{
 			property: value;
 			other rules;
 	}
 ```
 - `class selectors` - select classes `.my_class`
 - `attribute selectors` - all elements with specified attributes - `img[src]` applies all <img> tags with `src` attribute.
 - `pseudo class selectors` - selects elements in a **specified state**. For instance `a:hover` selects `<a>` anchor tags when mouse pointer is hovering over it.

It is intersting to note that in web development, you can make use of a number of resources that are already hosted. For instance, you can pick a font from Google's font index hosted at [fonts.google.com](http://fonts.google.com/). To do this, add the font source as a resource in the html's `<head>` tags: `<link href="https://fonts.googleapis.com/css?family=Droid+Serif" rel="stylesheet">` and edit the CSS to specify which font from this family: 

	html{
		font-family: 10px;
		font-family: 'Droid Serif', serif;
	}

## JS
You got to link the JS files to the html file, preferably in the end before `<\body>` section like this : `<script src='scripts/main.js'></script>`. This is because JS modifies the contents of this html file and it should be executed last else it would not know of the contents of this page.

 - Variable declaration `var myVariable = value;`
 - statements end with `;`
 - symbols are case sensitive
 - Data types - `String`, `Number`, `Boolean`, `Array`, `Object`.
  - JS is not strongly typed
  - `Number` can hold both integer and float
  - `Boolean` is `true` and `false`, in lower cases
  - `Array` can hold multiple data types `[1, 'bob', 39.45, obj2]`
  - `Object` - everything in JS is an obj.
 - Comments `//` for single line and `/* -- */` for multi line
 - Operators in JS
  - `+ - * /` for math operations
  - `=` for assignment
  - `===` for equality checking, not its triple and not double equals
  - `!`, `!==` for negation

