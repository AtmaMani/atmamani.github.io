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

## Getting user input via HTML pages
Not only are HTML pages good to display content on a UI, they are good to collect user input for processing. The snippet below defines a resource that when called via `GET`, will show an HTML page with form controls. If accessed via `POST`, it performs the actual processing defined by the resource.

```python
@app.route('/eyeFromAbove', methods=['GET', 'POST'])
def eye_from_above():
    """
    If GET request - Displays a html page with box to enter address
    if POST request - renders output html with image from satellite
    :return:
    """
    if request.method == 'POST':
        # User could have used the web UI or called the endpoint headless

        # If user used the web UI, then address comes as form data
        if request.form is not None:
            address = request.form.get('address', None)
            date = request.form.get('date', None)
        else:
            # request data comes via args
            address = request.args.get('address', None)
            date = request.args.get('date', None)
        if address:
            geocode_dict = geocode_address_executor(address)
            lon = geocode_dict['location']['x']
            lat = geocode_dict['location']['y']

        else: # when no address is loaded
            flash('No address specified')
            return redirect(request.url)

        base_url = 'https://api.nasa.gov/planetary/earth/imagery'
        # for some reason, NASA server rejects the GET request if I send data over payload
        if date:
            full_url = f'{base_url}/?lat={lat}&lon={lon}&date={date}&cloud_score=False&api_key={key}'
        else:
            full_url = f'{base_url}/?lat={lat}&lon={lon}&cloud_score=False&api_key={key}'


        # construct the query and get download url
        # resp = requests.get(base_url, params)
        resp = requests.get(full_url)

        if resp.status_code == 200:
            resp_dict = json.loads(resp.text)
        else:
            return json.dumps({'error':resp.text})

        # Download the image from Google Earth Engine API.
        img_resp = requests.get(resp_dict['url'])
        if img_resp.status_code == 200:
            img_filename = address.replace(' ','_').replace('-','').replace('.','').replace('*','').replace(',','')
            with open(f'eye_in_sky_queries/{img_filename}.png', 'wb') as img_handle:
                img_handle.write(img_resp.content)
        else:
            return json.dumps({'error':img_resp.text})

        # render the HTML page
        return render_template('eye_from_above.html',
                               media_type='image',
                               media_url = os.path.join('/','eye_in_sky_queries',img_filename+'.png'),
                               img_date = resp_dict['date'],
                               img_id = resp_dict['id'],
                               img_dataset = resp_dict['resource']['dataset'])

    elif request.method == 'GET':
        # case when page is loaded on browser
        return '''
            <!doctype html>
            <title>Enter address to view</title>
            <h1>Enter the address to get image of</h1>
            <form method=post enctype=multipart/form-data>
              <input type=text name=address value=address>
              <input type=text name=date value='2013-12-17'>
              <input type=submit value=Submit>
            </form>
            '''

# this resource is needed to render images from disk. Needed for the template HTML pages
@app.route('/eye_in_sky_queries/<filename>')
def uploaded_file(filename):
    return send_from_directory('eye_in_sky_queries',
                               filename)
```

Now, to display the image, we need this part in the template HTML file
```HTML
<body>
    {% if media_type == 'image' %}
        <img src={{media_url}} class="img-fluid" alt="Responsive image">
</body>
```

## Database CRUD operations
One of the popular use cases of RESTful web services is, to perform operations on backend database via the web. In the snippet below, I am using `sqlalchemy` library to  create an in-memory `sqlite` database and perform CRUD - Create, Read, Update, Delete operations on it.

### An intro to `sqlalchemy`
Sqlalchemy library is an ORM (Object Relatinal Mapper) which allows representing database elements as Python objects. In addition, it allows you to connect to a DB and perform CRUD ops in addition to others.

Connecting to a DB. In this case a sqllite db is created. If you want the db in-memory, then specify `memory` as location.

```python
from sqlalchemy import create_engine
engine = create_engine('sqlite:///filename.db')
```

The next step is to establish a session to this newly created db.
```python
from sqlalchemy.orm import sessionmaker
DBSession = sessionmaker(bind=engine)
my_session = DBSession()
```

The next step is a little boiler plate and can be seen in many examples using sqlalchemy.
```python
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()
```

Next step is to create a Model - this represents the table, columns, rows as Python objects.
```python
from sqlalchemy import column, Integer, Numeric, String

class Puppy(Base): #must inherit from declarative base
	__tablename__ = 'puppy'

	puppy_id = Column(Integer, primary_key=True)
	puppy_name = Column(String[30])
	# ... other columns
```

Finnaly, we need to create the table define above on the db.
```python
Base.metadata.create_all(engine)
```

#### Inserting rows
Create an instance of the class you created that inherited the `declarative_base`.
```python
puppy1 = Puppy(puppy_name = 'nemo') #pass the columns info to the constructor

# insert row
session.add(puppy1)
session.commit()
```
Since, we did not pass `puppy_id`, the Primary key, the session knows this is a new row and it has to be created. Else, to edit an existing row, you still do an `add` but have the primary key specified.