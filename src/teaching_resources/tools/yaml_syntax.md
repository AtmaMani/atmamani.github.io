# Yaml Syntax

## What's YAML
[Yaml](https://yaml.org/) originally stood for "Yet Another Markup Language", but some say it later changed to "YAML Ain't Markup Language". Nonetheless, it is used to serialize config style documents in a human readable form. Contenders for YAML are JSON, TOML, XML etc.

**Characteristics of YAML**
- Compact syntax with Python style indentation.
- Version stable since 2009 at version `1.2.x`
- Files are saved with `.yaml` or `.yml` extension
- Yet this is language agnostic and can be R/W from any prog. language.
- Supports common data types such as `int`, `binary`, `str`, `bool`, `map` or dictionaries, `lists` or collections or sequences and `object`s for higher level organization

## YAML syntax

**Basics**
Below is a simple example with notes:

```yaml
# This is a comment line. Comments begin with #
kind: config-example    # a basic kvp
name: navigator         # example of a string value. No quotes if single word
services:               # example of a list
    - user-auth         # list items start with a -
    - add-to-cart       # indentation is important
    - remove-from-cart
    - checkout-cart
service-definitions:    # example of a list of objects
    - app: user-auth    # list item start with a -
      port: 8000        # int value
      version: 1.7      # float value
      endpoint: "/auth" # string with special char needs to be enclosed within quotes
    - app: add-to-cart
      port: 8000
      version: 1.3
      endpoint: ["/add", "/additems"]   # single line list representation
```

**Writing objects**
Objects can be written using a natural syntax.

```yaml
apiVersion: 1.2
kind: pod
metadata:                   # object
    name: nginx             # simple kvp
    labels:                 # object
        app: nginx
        cost-center: auth
        cluster: dev
spec:                       # object
    containers:             # list of objects
        - name: nginx-container
          image: gcr.io/abcd/nginx
          ports:            # list
          - containerPort: 80
          volumeMounts:
          - name: ngnix-vol
        - name: sidecar-container
```

**Singleline and Multiline strings**

* To word-wrap a long text line, use `>` operator
* To represent an actual multi-line string, use the pipe key `|`

```yaml
# singe line string, wrapped for readability
spec:
    container:
        image: gcr.io/image
        cmd: >
            python
            -m
            http.server
            -name arg1
            --long-name arg2
            --another-long-name arg3
```

Below is an example where a multiline string is meaningful. Here, we specify the actual Python script in the Yaml itself. Uncommon, but still one option.

```yaml
# multiline string
spec:
    script:
      image: python:alpine3.10
      command: [python]
      source: |
        import json, os
        data_file = "somepath/input_args.json"
        with open(data_file) as f:
          run_config = json.load(f)
        print(run_config["somekvp"])
```

## Yaml injection
Yaml allows compile time injection of values. Tools such as Helm templating engine use this technique to insert specific objects (such as secrets, keys etc) into the Yaml at run or compile time. 

The syntax to specify injection placeholders is `{{.variable.name}}`. Below is an example of Helm templates used in a K8s workflow:

```yaml
apiVersion: 1.2
kind: Service
metadata:
    name: {{.Values.service.name}}
spec:
    ports:
        - protocol: http
          port: {{.Values.service.port}}
          node: {{.Values.app.nodeSelector}}
```