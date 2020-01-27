Title: Design principles behind RESTful APIs
Date: 2019-10-15 10:25
Category: design
Tags: python
Slug: design-principles-behind-restful-apis

RESTful stands for "Representational State Transfer". Consider this as a concept and a pattern of building client-server APIs. I have been building Python APIs that consume some popular RESTful APIs for the past 5+ years. This article outlines the aspects of a thoughtful and well-designed REST API. Some of the aspects here are from the perspective of a consumer, not the maker of RESTful APIs.

<!-- TEASER_END -->

## What makes a web API RESTful?
 - Presence of a strong separation between client and server
 - Server should not remember previous actions of the client, ergo, be what people call "stateless".
 - Each request from client should be treated independently and as if it is the first request. This goes with the previous point about server being stateless. Thus, the onus of sending context is upon the client, not the server to remember.
 - However, when designing anything for a user, you need to make it as simple as possible. Thus, servers can exchange authentication and context for `tokens` with the client. This allows for a stateless design, but gives users a stateful experience (such as a shopping website remembering what user added to shopping cart) to the client / user.
 - Responses from server can be marked as cacheable or non-cacheable. This way, client does not have to talk to server for the same requests.
 - Server should provide a uniform interface, no matter what the client is(mobile vs desktop vs another server).

**Some advanced features of RESTful APIs**

 - If the logic is complex, you can implement a *layered* system where clients interact with say, 'Server A'. Then, Server A would interact with many other servers to fulfill the request and give results back to client. Client does not have to know how to talk to the rest of the servers to accomplish this.
 - *code on demand*: Server might optionally send executable code (like JS) to run on client to fulfil a request.

### HTTP Request structure
Next, let us talk about what gets exchanged between the client and the server. A request from client to server consists of 3 parts:

  1. header - which contains:
     1. A request line. This line contains a HTTP verb, a URI and HTTP version number. An example syntax of request line is `GET /index.html HTTP 1.1`
     2. optional request headers which appear as kvp. For instance `Accept: image/gif, image/jpeg, */*`, `Accept-Language: en-us`.
  2. blank line
  3. body (optional) - body can contain any additional information, such as auth info etc.
     1. for instance `puppyId=12345&name=Fido+Lava`

### HTTP Response structure
Similar to a request, the response from server to client consists of 3 same parts

  1. a header, which contains
     1. status line which has the status code, HTTP version
     2. optional response headers
  2. blank line
  3. body (optional). The body contains what the client asked for. For instance a mp3 file, image file or an html page.

## Making RESTful APIs elegant
The rules listed above are just the skeleton. Although not strictly needed, when APIs use the the following design patterns, they become easy for the end user to predict and understand the architecture of the backend system they are working with.

**URI design**

 1. URI should take name of resource, **not the action to take on them**. For instance, `/tickets/4` is good, while `getTicketInfo/4` is not. Remember, URIs should be **nouns**, not verbs.
 2. URI should be a plural form for each resource name. For instance, `/puppies`, `/tickets`. Depending on the resource needed for the backend, calling the plural form of a resource (`/items/`) can list all the items, or give a summary info.
 3. Use HTTP verbs to indicate action. The verbs are `GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `OPTIONS`, `TRACE`, `CONNECT`.
    1. `HEAD` and `GET` can be called by web crawlers and search engines, so ensure these resources can only get information and not modify.
    2. `GET`, `POST` resources typically give information to client
    3. `PUT`, `DELETE` resources can add, update, delete resources on the server. Thus we cover the `CRUD` operations using HTTP verbs.
 4. Use HTTP status codes such as `404`, `401` along with error messages appropriately.
 5. Expose child resources progressively. For instance, if `/items/` does not expose all the items and only provides a summary or count, then expose a `/items/search` for client to search the backend database. Finally, ensure `/search/` accepts well known SQL syntax queries, don't make a custom one.
 6. Give the benefit of doubt to the client. Build the REST handler to be fault tolerant, error tolerant by building the validation logic on backend, and not on the client side.

**API versioning**

 1. Versioning allows to maintain backward compatibility when you build a permanent web API.
 2. You can either add version in the URI, as `/puppies/v2/resource` or in the header of the call.

## Conclusion
To learn more about RESTful APIs, go 
 - [restfulapi.net](https://restfulapi.net/)
 - [Udacity course on Flask](https://classroom.udacity.com/courses/ud388)

To look at an example of building RESTful APIs, go to my blog article [Building RESTful APIs with Flask in Python](/blog/building-restful-apis-with-flask-in-python/).