Title: HTML - files that make up the web

**TOC**
<!-- MarkdownTOC -->

- [HTML skeleton](#HTML-skeleton)
- [HTML tags](#HTML-tags)

<!-- /MarkdownTOC -->

## HTML skeleton
 - HTML - this is the opening and ending tag. All fills within these tags
  - `<!-- comment -->` in html
 - Head - consider like header, import region. It links to important resource files like CSS, JS scripts.
 - Body - main content of the web page
 - Divisions `<div> </div>` constitute the various segments of the page. It is common to nest the divisions.
 - Scripts - scripts are generally at the end because browsers load the page in the order they see the html. Hence if the scripts modify the html, they need to follow the html regions they modify.

## HTML tags
You write content between the tags
```HTML
<html> </html>
<head> </head>
<!-- --> for comments
<meta charset='utf-8'> tells browser how to read the document
<title> </title> for browser tab text
<link href='path' rel='root path'> for links to other files
<body> </body>
<div id=''> </div> for each section of the path is a division. Divisions can be nested within one another
<p> put new paragraphs </p>
<ul> unordered / bulleted lists </ul>
<ol> ordered / numbered lists </ol>
<li> list item, for both ol and ul </li>
<h1> </h1> for headings. cycle the numbers through. 1 is largest heading
<a href="path">hyperlink text </a>
```
Now to the parts of html pertaining to JS
```HTML
<script src='path to js file'></script>
<script> and between the script tags, you can write JS code. </script>
// for JS single line comments
/* for multi line */
```