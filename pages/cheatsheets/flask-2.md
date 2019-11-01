title: Building RESTful APIs with Flask in Python

# Boiler plate
There is very little boiler plate necessary when defining a flask app. Something as limited as:

```python
from flask import Flask
from datetime

# define a variable to hold you app
app = Flask(__name__)

# define your resource endpoints
app.route('/')
def index_page():
	return "Hello world"

app.route('/time', methods=['GET'])
def get_time():
	return str(datetime.datetime.now())

# server the app when this file is run
if __name__ == '__main__':
	app.run()
```
In the code above, you have defined 2 endpoints - a root / landing page and a `/time` endpoint. You can run this app from terminal as `python -m <filename>` which will start the webserver and give you an IP address to go or call.

## Passing arguments
When calling an endpoint, users can send the server some information. This info can be sent via GET or POST calls. By following HTTP verbs, if user wants to collect info back, they should send it via GET, else if the call is to perform some operation on the server side, then POST.

```python
from flask import request # used to parse payload
app.route('/hello')
def welcome_message():
	"""
	Called as /hello?name='value'
	"""
	name = request.get('name', '') # if user sends payload to variable name, get it. Else empty string
	return f'Welcome {name}'
```
**Note**, sometimes your web app needs to make calls to other resources on the web. For this you can use the `requests` library. The `request` module of Flask used in the snippet is not to be confused with the `requests` library.

## Rendering HTML pages
Flask allows you to define a `templates` directory and put HTML pages into it. In these HTML pages, you can define variables and pass values to be displayed when rendering the HTML pages. This totally expands your possibilities without having to write a line of JS code.

```HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thermos - building webapis with flask</title>
</head>
<body>
<p>
    A little bit about the machine running this site:

    <h4>OS type: {{os_type}}; OS name: {{os_name}}</h4>
</p>
</body>
</html>
```
Put the above HTML page (saved as `index.html`) into a `templates` directory. Then you can render this page as

```python
from flask import render_template
app.route('/welcomePage')
def welcome_page():

	return render_template('index.html',
							'os_type' = sys.platform,
							'os_name' = os.name)
```
