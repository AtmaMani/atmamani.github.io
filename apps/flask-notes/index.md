post to AWS using zappa.

Server stack
------------

 - **Web server** - load balancing, SLL endpoint, eg: nginx, apache
 - **http server** - forwards dynamic content requests, servers dynamic content, eg: uWSGI, Gunicorn
 - **app server** - communicates with back-end res like db, process dynamic queries. eg: Flask, Django, CherryPy

Ending a REST route with a trailing slash will support whether or not the request comes with a trailing slash.

When accepting a request with parameters from a user, ensure you scrub the inputs before passing it into a db or such. This is because people can inject sql and can damage or hack the backend.

Like `templates`, `static` is a reserved and known folder into which you can store pics and files. Flask will just serve it out.

Use `from flask import url_for` and use it when you need to dynamically compose an internal URL dynamically.

When accepting a POST endoing, use `request.form['password']` instead of `request.args.get('param')`.

Use `redirect(<new_url_here>, 302)` to redirect.

## Login
`pip install Flask-Login` library is a simple one. This library is aware of sessions and can manage that. When storing passwords, use password hashes.

```python
from werkzeug.security import generate_password_hash
secret_pass = generate_password_hash('123')
```
You will compare the hash of user password with a dynamic hash when user presents it.

### Users
`flask_login.UserMixin` find what a Mixin is. Find if subclass is the right term.

## Zappa
Zappa makes is very easy to push to AWS. It will zip up the app, push to S3 bucket, deploy via AWS Lambda, create AWS API Gateway endpoint, adds an AWS Cloudwatch rule that keeps Lambda 'warm'. The cloudwatch will keep the lambda running by pinging it every 4 mins or so.

# Resources
Corey Schafer's 15 part Flask on YouTube.