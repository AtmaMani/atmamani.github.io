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