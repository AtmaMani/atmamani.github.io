# Building and publishing a fullstack Python webapp on Heroku

**Thermos repo**
Get this project from the [thermos GitHub repo](https://github.com/AtmaMani/thermos)

**Experiments with a Python's Flask based web server.**
![](https://cdn.pixabay.com/photo/2018/08/28/20/21/jug-3638398_960_720.jpg)

This tiny project shows how to build RESTful APIs with Flask. You can define endpoints and the code that needs to be executed when invoked. You can send messages via the REST API and act on it in your Python code.

## Quickstart
### Creating your dev env
To run, first clone this repo and enter its folder in terminal. Then clone  the dev env using the `requirements.txt` file. To do so first create a conda env by running:
```
conda create env --name flask2 python
```
then install the dependencies by running:
```
pip install -r requirements.txt
```

### Running this project
All endpoints are defined in a single `app.py` which is what should be run by the web server. After you activate and install the dependencies, from the terminal run:

```
python -m app
```
which will start the web server (usually at [http://localhost:5000](http://localhost:5000))and give you an address to hit. There is a simple HTML frontpage that you can use as UI or you can interact with the REST endpoints programmatically. You can also hit the production version at [https://atma-thermos.herokuapp.com](https://atma-thermos.herokuapp.com)

## Architecture of this project
The goal of this project is to demonstrate building web apps using Python. It demonstrates using `Flask` to design and implement RESTful APIs, `arcgis` for geocoding, `NASA APIS` to call out to an external process, `HTML templates` to demo injecting content dynamically into web pages and finally `sqlalchemy` to perform CRUD ops on a database and expose those operations via a REST API.

#### 1. `app.py`
This is the main file. The web server runs this file. All REST endpoints and handlers for each are defined here. For simple operations, the business logic is defined right in the handler. For others, it is abstracted away in separate Python files that are imported.

The `/` route defines what happens when the landing page of the app is called. If you send a GET request, then a HTML page is displayed. This page is defined in the `templates/index.html`. As you can see from the code, I am able to use Python to inquire the IP address, machine name, system path etc and pass that to the HTML page. The advantage of this is, which ever server runs this app, the details will be populated at run time. This pattern comes in handy later.

The `eyeFromAbove` resource is probably the most complex. When called via a GET, it returns a HTML page with some UI elements. Users can enter values and hit submit which will send a POST call to the same endpoint. When it receives a POST call, it performs the actual operation of geocoding the address and calling out to NASA and Google Earth Engine apps to get a Landsat satellite image of the coordinates. Once it downloads this image (into `\eye_in_sky_queries`), it returns the user a HTML page which dynamically displays this satellite image.

#### 2. `executor.py` and `geocode_tool.py`
These files abstract the logic needed for generating unique random numbers and geocoding addresses to get coordinate information. The `geocode_tool.py` uses `arcgis` package for this.

#### 3. `address_db_model.py` and `dbops.py`
This part deals with database operations. The model file creates a `sqlite` db on disk, declares a table and its schema. The rest is handled in the `dbops.py` file. This file has logic to Create, Read, Update, Delete (CRUD) records. The db file is called `addresses.db` and the table is called `gAddress`. Neither of these is required to talk to the DB because `sqlalchemy` abstracts DB interaction. Thus, the workflow once DB is created is to create a `session` that connects to this db with a little bit of boilerplate code. Thereafter, I pass around the `session` variable whenever I need to perform CRUD ops. Only the `app.py` file can create the session. All other files will use this session to work with the db.

The `app.py` exposes an `/addresses` endpoint which accepts GET, POST, PUT, DELETE and an index URL endpoint. Ops like geocoding will automatically write a record to the table. In addition, users can call the addresses endpoint via POST to push a bunch of addresses into the db. GET will read all entries. PUT will update and DELETE will remove individual records.

#### 4. `\unittests`
A critical component of this repo is the unittests. Written using Python's built-in `unittest` module, these test each endpoint making REST calls. You can run the tests against development as well as production, just change the `base_address` property.

I cannot emphasize the importance of tests enough. I practically learnt about FLASK and how to read arguments vs form data by debugging my failing tests. It was thrilling to attach debugger to both my server and my client code and see calls made and handled.

## Publishing to Heroku
These are the general steps

1. Install all dependencies using `pip` as conda support is not matured yet.
2. Freeze dependencies using `pip freeze -r requirements.txt`
3. Create a `Procfile` with contents `web: gunicorn app:app`. Here we switch from Flask server to Gunicorn which is a light weight, but production ready server.
4. Install Heroku CLI, create an account, make keys, login to client.
5. Create Heroku app as `heroku apps:create atma-thermos`. Note: you need to name it differently as the name I chose is taken by me.
6. Test locally using `heroku local web`.
7. Commit your changes. Push to both remotes.
```git
git push origin master
git push heroku master
```
The last statement of pushing to heroku triggers the actual job of building your app on serverside. Heroku will unpack this repo, set up the env using requirements.txt, then execute the Procfile instructions. This will lead to your app running at the designated address it gave you when you ran the `create` command.

Look at the appendix at the bottom to see the full terminal build output.

#### Mistakes
1. When authoring the requirements, I forgot to mention that `arcgis` should be a lite install. This resulted in heroku trying to install the full package. But it looks like it had no problems :)

## Appendix - build outputs
```diff
(flask2) thermos (master) $ git push origin master
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 12 threads
Compressing objects: 100% (10/10), done.
Writing objects: 100% (11/11), 171.85 KiB | 10.11 MiB/s, done.
Total 11 (delta 5), reused 0 (delta 0)
remote: Resolving deltas: 100% (5/5), completed with 3 local objects.
To github.com:AtmaMani/thermos.git
   f6304ec..ef5ee7f  master -> master
(flask2) thermos (master) $ git remote -v
heroku	https://git.heroku.com/atma-thermos.git (fetch)
heroku	https://git.heroku.com/atma-thermos.git (push)
origin	git@github.com:AtmaMani/thermos.git (fetch)
origin	git@github.com:AtmaMani/thermos.git (push)
(flask2) thermos (master)* $ git push heroku master
Enumerating objects: 59, done.
Counting objects: 100% (59/59), done.
Delta compression using up to 12 threads
Compressing objects: 100% (52/52), done.
Writing objects: 100% (59/59), 784.82 KiB | 23.78 MiB/s, done.
Total 59 (delta 18), reused 12 (delta 2)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Python app detected
remote: -----> Installing python-3.6.9
remote: -----> Installing pip
remote: -----> Installing SQLite3
remote: -----> Installing requirements with pip
remote:        Collecting arcgis==1.7.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/ef/ae/6d3f73ed54b243584bc9b0b888f7b0751e255737482a1989345747f4d81b/arcgis-1.7.0.tar.gz (1.7MB)
remote:        Collecting certifi==2019.9.11 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 2))
remote:          Downloading https://files.pythonhosted.org/packages/18/b0/8146a4f8dd402f60744fa380bc73ca47303cccf8b9190fd16a827281eac2/certifi-2019.9.11-py2.py3-none-any.whl (154kB)
remote:        Collecting chardet==3.0.4 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 3))
remote:          Downloading https://files.pythonhosted.org/packages/bc/a9/01ffebfb562e4274b6487b4bb1ddec7ca55ec7510b22e4c51f14098443b8/chardet-3.0.4-py2.py3-none-any.whl (133kB)
remote:        Collecting Click==7.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 4))
remote:          Downloading https://files.pythonhosted.org/packages/fa/37/45185cb5abbc30d7257104c434fe0b07e5a195a6847506c074527aa599ec/Click-7.0-py2.py3-none-any.whl (81kB)
remote:        Collecting Flask==1.1.1 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 5))
remote:          Downloading https://files.pythonhosted.org/packages/9b/93/628509b8d5dc749656a9641f4caf13540e2cdec85276964ff8f43bbb1d3b/Flask-1.1.1-py2.py3-none-any.whl (94kB)
remote:        Collecting gunicorn==19.9.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 6))
remote:          Downloading https://files.pythonhosted.org/packages/8c/da/b8dd8deb741bff556db53902d4706774c8e1e67265f69528c14c003644e6/gunicorn-19.9.0-py2.py3-none-any.whl (112kB)
remote:        Collecting idna==2.8 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 7)
remote:          Downloading https://files.pythonhosted.org/packages/14/2c/cd551d81dbe15200be1cf41cd03869a46fe7226e7450af7a6545bfc474c9/idna-2.8-py2.py3-none-any.whl (58kB)
remote:        Collecting itsdangerous==1.1.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 8))
remote:          Downloading https://files.pythonhosted.org/packages/76/ae/44b03b253d6fade317f32c24d100b3b35c2239807046a4c953c7b89fa49e/itsdangerous-1.1.0-py2.py3-none-any.whl
remote:        Collecting Jinja2==2.10.3 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 9))
remote:          Downloading https://files.pythonhosted.org/packages/65/e0/eb35e762802015cab1ccee04e8a277b03f1d8e53da3ec3106882ec42558b/Jinja2-2.10.3-py2.py3-none-any.whl (125kB)
remote:        Collecting MarkupSafe==1.1.1 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 10))
remote:          Downloading https://files.pythonhosted.org/packages/b2/5f/23e0023be6bb885d00ffbefad2942bc51a620328ee910f64abe5a8d18dd1/MarkupSafe-1.1.1-cp36-cp36m-manylinux1_x86_64.whl
remote:        Collecting pytz==2019.3 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 11))
remote:          Downloading https://files.pythonhosted.org/packages/e7/f9/f0b53f88060247251bf481fa6ea62cd0d25bf1b11a87888e53ce5b7c8ad2/pytz-2019.3-py2.py3-none-any.whl (509kB)
remote:        Collecting requests==2.22.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 12))
remote:          Downloading https://files.pythonhosted.org/packages/51/bd/23c926cd341ea6b7dd0b2a00aba99ae0f828be89d72b2190f27c11d4b7fb/requests-2.22.0-py2.py3-none-any.whl (57kB)
remote:        Collecting six==1.12.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 13))
remote:          Downloading https://files.pythonhosted.org/packages/73/fb/00a976f728d0d1fecfe898238ce23f502a721c0ac0ecfedb80e0d88c64e9/six-1.12.0-py2.py3-none-any.whl
remote:        Collecting SQLAlchemy==1.3.10 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 14))
remote:          Downloading https://files.pythonhosted.org/packages/14/0e/487f7fc1e432cec50d2678f94e4133f2b9e9356e35bacc30d73e8cb831fc/SQLAlchemy-1.3.10.tar.gz (6.0MB)
remote:        Collecting urllib3==1.25.6 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 15))
remote:          Downloading https://files.pythonhosted.org/packages/e0/da/55f51ea951e1b7c63a579c09dd7db825bb730ec1fe9c0180fc77bfb31448/urllib3-1.25.6-py2.py3-none-any.whl (125kB)
remote:        Collecting Werkzeug==0.16.0 (from -r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 16))
remote:          Downloading https://files.pythonhosted.org/packages/ce/42/3aeda98f96e85fd26180534d36570e4d18108d62ae36f87694b476b83d6f/Werkzeug-0.16.0-py2.py3-none-any.whl (327kB)
remote:        Collecting ipywidgets>=7 (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/56/a0/dbcf5881bb2f51e8db678211907f16ea0a182b232c591a6d6f276985ca95/ipywidgets-7.5.1-py2.py3-none-any.whl (121kB)
remote:        Collecting widgetsnbextension>=3 (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/6c/7b/7ac231c20d2d33c445eaacf8a433f4e22c60677eb9776c7c5262d7ddee2d/widgetsnbextension-3.5.1-py2.py3-none-any.whl (2.2MB)
remote:        Collecting pandas>=0.23 (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/52/3f/f6a428599e0d4497e1595030965b5ba455fd8ade6e977e3c819973c4b41d/pandas-0.25.3-cp36-cp36m-manylinux1_x86_64.whl (10.4MB)
remote:        Collecting numpy (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/0e/46/ae6773894f7eacf53308086287897ec568eac9768918d913d5b9d366c5db/numpy-1.17.3-cp36-cp36m-manylinux1_x86_64.whl (20.0MB)
remote:        Collecting matplotlib (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/57/4f/dd381ecf6c6ab9bcdaa8ea912e866dedc6e696756156d8ecc087e20817e2/matplotlib-3.1.1-cp36-cp36m-manylinux1_x86_64.whl (13.1MB)
remote:        Collecting keyring (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/b1/08/ad1ae7262c8146bee3be360cc766d0261037a90b44872b080a53aaed4e84/keyring-19.2.0-py2.py3-none-any.whl
remote:        Collecting jupyterlab (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/56/96/5629fec605f0d320f3857241e84704e533ee54eb2aa87c0b69c34bbcc3f2/jupyterlab-1.2.1-py2.py3-none-any.whl (6.4MB)
remote:        Collecting pyshp<2,>=1.2.11 (from arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/c8/ac/8e9adb8e0dadabbb3b708d38a83119ee42115d9f8fd88858261f5bec50f0/pyshp-1.2.12.tar.gz (193kB)
remote:        Collecting traitlets>=4.3.1 (from ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/ca/ab/872a23e29cec3cf2594af7e857f18b687ad21039c1f9b922fac5b9b142d5/traitlets-4.3.3-py2.py3-none-any.whl (75kB)
remote:        Collecting ipython>=4.0.0; python_version >= "3.3" (from ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/81/2e/59cdacea6476a4c21b7c090a91250ffbcd085900f5eb9f4e4d68dd2ee4e3/ipython-7.9.0-py3-none-any.whl (775kB)
remote:        Collecting ipykernel>=4.5.1 (from ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/e1/92/8fec943b5b81078399f969f00557804d884c96fcd0bc296e81a2ed4fd270/ipykernel-5.1.3-py3-none-any.whl (116kB)
remote:        Collecting nbformat>=4.2.0 (from ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/da/27/9a654d2b6cc1eaa517d1c5a4405166c7f6d72f04f6e7eea41855fe808a46/nbformat-4.4.0-py2.py3-none-any.whl (155kB)
remote:        Collecting notebook>=4.4.1 (from widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/f5/69/d2ffaf7efc20ce47469187e3a41e6e03e17b45de5a6559f4e7ab3eace5e1/notebook-6.0.2-py3-none-any.whl (9.7MB)
remote:        Collecting python-dateutil>=2.6.1 (from pandas>=0.23->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/d4/70/d60450c3dd48ef87586924207ae8907090de0b306af2bce5d134d78615cb/python_dateutil-2.8.1-py2.py3-none-any.whl (227kB)
remote:        Collecting pyparsing!=2.0.4,!=2.1.2,!=2.1.6,>=2.0.1 (from matplotlib->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/a3/c4/7828cf9e71ce8fbd43c1e502f3fdd0498f069fcf9d1c268205ce278ae201/pyparsing-2.4.4-py2.py3-none-any.whl (67kB)
remote:        Collecting kiwisolver>=1.0.1 (from matplotlib->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/f8/a1/5742b56282449b1c0968197f63eae486eca2c35dcd334bab75ad524e0de1/kiwisolver-1.1.0-cp36-cp36m-manylinux1_x86_64.whl (90kB)
remote:        Collecting cycler>=0.10 (from matplotlib->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/f7/d2/e07d3ebb2bd7af696440ce7e754c59dd546ffe1bbe732c8ab68b9c834e61/cycler-0.10.0-py2.py3-none-any.whl
remote:        Collecting entrypoints (from keyring->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/ac/c6/44694103f8c221443ee6b0041f69e2740d89a25641e62fb4f2ee568f2f9c/entrypoints-0.3-py2.py3-none-any.whl
remote:        Collecting secretstorage; sys_platform == "linux" (from keyring->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/82/59/cb226752e20d83598d7fdcabd7819570b0329a61db07cfbdd21b2ef546e3/SecretStorage-3.1.1-py3-none-any.whl
remote:        Collecting jupyterlab-server~=1.0.0 (from jupyterlab->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/78/98/5b87b9d38176bd98f23b58a8fb730e5124618d68571a011abbd38ad4a842/jupyterlab_server-1.0.6-py3-none-any.whl
remote:        Collecting tornado!=6.0.0,!=6.0.1,!=6.0.2 (from jupyterlab->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/30/78/2d2823598496127b21423baffaa186b668f73cd91887fcef78b6eade136b/tornado-6.0.3.tar.gz (482kB)
remote:        Collecting decorator (from traitlets>=4.3.1->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/8f/b7/f329cfdc75f3d28d12c65980e4469e2fa373f1953f5df6e370e84ea2e875/decorator-4.4.1-py2.py3-none-any.whl
remote:        Collecting ipython-genutils (from traitlets>=4.3.1->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/fa/bc/9bd3b5c2b4774d5f33b2d544f1460be9df7df2fe42f352135381c347c69a/ipython_genutils-0.2.0-py2.py3-none-any.whl
remote:        Collecting pygments (from ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/5c/73/1dfa428150e3ccb0fa3e68db406e5be48698f2a979ccbcec795f28f44048/Pygments-2.4.2-py2.py3-none-any.whl (883kB)
remote:        Collecting backcall (from ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/84/71/c8ca4f5bb1e08401b916c68003acf0a0655df935d74d93bf3f3364b310e0/backcall-0.1.0.tar.gz
remote:        Collecting jedi>=0.10 (from ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/55/54/da994f359e4e7da4776a200e76dbc85ba5fc319eefc22e33d55296d95a1d/jedi-0.15.1-py2.py3-none-any.whl (1.0MB)
remote:        Collecting prompt-toolkit<2.1.0,>=2.0.0 (from ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/87/61/2dfea88583d5454e3a64f9308a686071d58d59a55db638268a6413e1eb6d/prompt_toolkit-2.0.10-py3-none-any.whl (340kB)
remote:        Collecting pickleshare (from ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/9a/41/220f49aaea88bc6fa6cba8d05ecf24676326156c23b991e80b3f2fc24c77/pickleshare-0.7.5-py2.py3-none-any.whl
remote:        Collecting pexpect; sys_platform != "win32" (from ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/0e/3e/377007e3f36ec42f1b84ec322ee12141a9e10d808312e5738f52f80a232c/pexpect-4.7.0-py2.py3-none-any.whl (58kB)
remote:        Collecting jupyter-client (from ipykernel>=4.5.1->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/13/81/fe0eee1bcf949851a120254b1f530ae1e01bdde2d3ab9710c6ff81525061/jupyter_client-5.3.4-py2.py3-none-any.whl (92kB)
remote:        Collecting jsonschema!=2.5.0,>=2.4 (from nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/ce/6c/888d7c3c1fce3974c88a01a6bc553528c99d3586e098eee23e8383dd11c3/jsonschema-3.1.1-py2.py3-none-any.whl (56kB)
remote:        Collecting jupyter-core (from nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/fb/82/86437f661875e30682e99d04c13ba6c216f86f5f6ca6ef212d3ee8b6ca11/jupyter_core-4.6.1-py2.py3-none-any.whl (82kB)
remote:        Collecting Send2Trash (from notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/49/46/c3dc27481d1cc57b9385aff41c474ceb7714f7935b1247194adae45db714/Send2Trash-1.5.0-py3-none-any.whl
remote:        Collecting pyzmq>=17 (from notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/75/89/6f0ea51ffa9c2c00c0ab0460f137b16a5ab5b47e3b060c5b1fc9ca425836/pyzmq-18.1.0-cp36-cp36m-manylinux1_x86_64.whl (1.1MB)
remote:        Collecting nbconvert (from notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/79/6c/05a569e9f703d18aacb89b7ad6075b404e8a4afde2c26b73ca77bb644b14/nbconvert-5.6.1-py2.py3-none-any.whl (455kB)
remote:        Collecting terminado>=0.8.1 (from notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/a7/56/80ea7fa66565fa75ae21ce0c16bc90067530e5d15e48854afcc86585a391/terminado-0.8.2-py2.py3-none-any.whl
remote:        Collecting prometheus-client (from notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/b3/23/41a5a24b502d35a4ad50a5bb7202a5e1d9a0364d0c12f56db3dbf7aca76d/prometheus_client-0.7.1.tar.gz
remote:        Collecting cryptography (from secretstorage; sys_platform == "linux"->keyring->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/45/73/d18a8884de8bffdcda475728008b5b13be7fbef40a2acc81a0d5d524175d/cryptography-2.8-cp34-abi3-manylinux1_x86_64.whl (2.3MB)
remote:        Collecting jeepney (from secretstorage; sys_platform == "linux"->keyring->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/0a/4c/ef880713a6c6d628869596703167eab2edf8e0ec2d870d1089dcb0901b81/jeepney-0.4.1-py3-none-any.whl (60kB)
remote:        Collecting json5 (from jupyterlab-server~=1.0.0->jupyterlab->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/30/44/062543d4a6718f99d82e5ecf9140dbdee8a03122f2c34fbd0b0609891707/json5-0.8.5-py2.py3-none-any.whl
remote:        Collecting parso>=0.5.0 (from jedi>=0.10->ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/a3/bd/bf4e5bd01d79906e5b945a7af033154da49fd2b0d5b5c705a21330323305/parso-0.5.1-py2.py3-none-any.whl (95kB)
remote:        Collecting wcwidth (from prompt-toolkit<2.1.0,>=2.0.0->ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/7e/9f/526a6947247599b084ee5232e4f9190a38f398d7300d866af3ab571a5bfe/wcwidth-0.1.7-py2.py3-none-any.whl
remote:        Collecting ptyprocess>=0.5 (from pexpect; sys_platform != "win32"->ipython>=4.0.0; python_version >= "3.3"->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/d1/29/605c2cc68a9992d18dada28206eeada56ea4bd07a239669da41674648b6f/ptyprocess-0.6.0-py2.py3-none-any.whl
remote:        Collecting importlib-metadata (from jsonschema!=2.5.0,>=2.4->nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/f6/d2/40b3fa882147719744e6aa50ac39cf7a22a913cbcba86a0371176c425a3b/importlib_metadata-0.23-py2.py3-none-any.whl
remote:        Collecting pyrsistent>=0.14.0 (from jsonschema!=2.5.0,>=2.4->nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/30/86/53a88c0a57698fa228db29a4000c28f4124823010388cb7042fe6e2be8dd/pyrsistent-0.15.5.tar.gz (107kB)
remote:        Collecting attrs>=17.4.0 (from jsonschema!=2.5.0,>=2.4->nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/a2/db/4313ab3be961f7a763066401fb77f7748373b6094076ae2bda2806988af6/attrs-19.3.0-py2.py3-none-any.whl
remote:        Collecting pandocfilters>=1.4.1 (from nbconvert->notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/4c/ea/236e2584af67bb6df960832731a6e5325fd4441de001767da328c33368ce/pandocfilters-1.4.2.tar.gz
remote:        Collecting mistune<2,>=0.8.1 (from nbconvert->notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/09/ec/4b43dae793655b7d8a25f76119624350b4d65eb663459eb9603d7f1f0345/mistune-0.8.4-py2.py3-none-any.whl
remote:        Collecting bleach (from nbconvert->notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/ab/05/27e1466475e816d3001efb6e0a85a819be17411420494a1e602c36f8299d/bleach-3.1.0-py2.py3-none-any.whl (157kB)
remote:        Collecting testpath (from nbconvert->notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/1b/9e/1a170feaa54f22aeb5a5d16c9015e82234275a3c8ab630b552493f9cb8a9/testpath-0.4.4-py2.py3-none-any.whl (163kB)
remote:        Collecting defusedxml (from nbconvert->notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/06/74/9b387472866358ebc08732de3da6dc48e44b0aacd2ddaa5cb85ab7e986a2/defusedxml-0.6.0-py2.py3-none-any.whl
remote:        Collecting cffi!=1.11.3,>=1.8 (from cryptography->secretstorage; sys_platform == "linux"->keyring->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/49/72/0d42f94fe94afa8030350c26e9d787219f3f008ec9bf6b86c66532b29236/cffi-1.13.2-cp36-cp36m-manylinux1_x86_64.whl (397kB)
remote:        Collecting zipp>=0.5 (from importlib-metadata->jsonschema!=2.5.0,>=2.4->nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/74/3d/1ee25a26411ba0401b43c6376d2316a71addcc72ef8690b101b4ea56d76a/zipp-0.6.0-py2.py3-none-any.whl
remote:        Collecting webencodings (from bleach->nbconvert->notebook>=4.4.1->widgetsnbextension>=3->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/f4/24/2a3e3df732393fed8b3ebf2ec078f05546de641fe1b667ee316ec1dcf3b7/webencodings-0.5.1-py2.py3-none-any.whl
remote:        Collecting pycparser (from cffi!=1.11.3,>=1.8->cryptography->secretstorage; sys_platform == "linux"->keyring->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz (158kB)
remote:        Collecting more-itertools (from zipp>=0.5->importlib-metadata->jsonschema!=2.5.0,>=2.4->nbformat>=4.2.0->ipywidgets>=7->arcgis==1.7.0->-r /tmp/build_771006ccbb0075f30cf8bfceed6597e5/requirements.txt (line 1))
remote:          Downloading https://files.pythonhosted.org/packages/45/dc/3241eef99eb45f1def35cf93af35d1cf9ef4c0991792583b8f33ea41b092/more_itertools-7.2.0-py3-none-any.whl (57kB)
remote:        Installing collected packages: six, decorator, ipython-genutils, traitlets, pygments, backcall, parso, jedi, wcwidth, prompt-toolkit, pickleshare, ptyprocess, pexpect, ipython, tornado, jupyter-core, python-dateutil, pyzmq, jupyter-client, ipykernel, more-itertools, zipp, importlib-metadata, pyrsistent, attrs, jsonschema, nbformat, MarkupSafe, Jinja2, Send2Trash, entrypoints, pandocfilters, mistune, webencodings, bleach, testpath, defusedxml, nbconvert, terminado, prometheus-client, notebook, widgetsnbextension, ipywidgets, numpy, pytz, pandas, pyparsing, kiwisolver, cycler, matplotlib, pycparser, cffi, cryptography, jeepney, secretstorage, keyring, json5, jupyterlab-server, jupyterlab, pyshp, arcgis, certifi, chardet, Click, Werkzeug, itsdangerous, Flask, gunicorn, idna, urllib3, requests, SQLAlchemy
remote:          Running setup.py install for backcall: started
remote:            Running setup.py install for backcall: finished with status 'done'
remote:          Running setup.py install for tornado: started
remote:            Running setup.py install for tornado: finished with status 'done'
remote:          Running setup.py install for pyrsistent: started
remote:            Running setup.py install for pyrsistent: finished with status 'done'
remote:          Running setup.py install for pandocfilters: started
remote:            Running setup.py install for pandocfilters: finished with status 'done'
remote:          Running setup.py install for prometheus-client: started
remote:            Running setup.py install for prometheus-client: finished with status 'done'
remote:          Running setup.py install for pycparser: started
remote:            Running setup.py install for pycparser: finished with status 'done'
remote:          Running setup.py install for pyshp: started
remote:            Running setup.py install for pyshp: finished with status 'done'
remote:          Running setup.py install for arcgis: started
remote:            Running setup.py install for arcgis: finished with status 'done'
remote:          Running setup.py install for SQLAlchemy: started
remote:            Running setup.py install for SQLAlchemy: finished with status 'done'
remote:        Successfully installed Click-7.0 Flask-1.1.1 Jinja2-2.10.3 MarkupSafe-1.1.1 SQLAlchemy-1.3.10 Send2Trash-1.5.0 Werkzeug-0.16.0 arcgis-1.7.0 attrs-19.3.0 backcall-0.1.0 bleach-3.1.0 certifi-2019.9.11 cffi-1.13.2 chardet-3.0.4 cryptography-2.8 cycler-0.10.0 decorator-4.4.1 defusedxml-0.6.0 entrypoints-0.3 gunicorn-19.9.0 idna-2.8 importlib-metadata-0.23 ipykernel-5.1.3 ipython-7.9.0 ipython-genutils-0.2.0 ipywidgets-7.5.1 itsdangerous-1.1.0 jedi-0.15.1 jeepney-0.4.1 json5-0.8.5 jsonschema-3.1.1 jupyter-client-5.3.4 jupyter-core-4.6.1 jupyterlab-1.2.1 jupyterlab-server-1.0.6 keyring-19.2.0 kiwisolver-1.1.0 matplotlib-3.1.1 mistune-0.8.4 more-itertools-7.2.0 nbconvert-5.6.1 nbformat-4.4.0 notebook-6.0.2 numpy-1.17.3 pandas-0.25.3 pandocfilters-1.4.2 parso-0.5.1 pexpect-4.7.0 pickleshare-0.7.5 prometheus-client-0.7.1 prompt-toolkit-2.0.10 ptyprocess-0.6.0 pycparser-2.19 pygments-2.4.2 pyparsing-2.4.4 pyrsistent-0.15.5 pyshp-1.2.12 python-dateutil-2.8.1 pytz-2019.3 pyzmq-18.1.0 requests-2.22.0 secretstorage-3.1.1 six-1.12.0 terminado-0.8.2 testpath-0.4.4 tornado-6.0.3 traitlets-4.3.3 urllib3-1.25.6 wcwidth-0.1.7 webencodings-0.5.1 widgetsnbextension-3.5.1 zipp-0.6.0
remote: 
remote: -----> Discovering process types
remote:        Procfile declares types -> web
remote: 
remote: -----> Compressing...
remote:        Done: 131.7M
remote: -----> Launching...
remote:        Released v3
remote:        https://atma-thermos.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/atma-thermos.git
 * [new branch]      master -> master
```