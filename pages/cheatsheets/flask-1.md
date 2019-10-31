Title: Making RESTful APIs in Python

## What makes a web API RESTful
 - separation between client and server
 - server should not remember previous actions of the client (stateless)
 - each request from client should be treated independently and as if it is the first request
 - use of `tokens` allows for a stateless design, but gives users a stateful experience (such as a shopping website remembering what user added to shopping cart)
 - responses from server can be marked as cacheable or non cacheable. This way, client does not have to talk to server for the same requests
 - Server should provide a uniform interface, no matter what the client is (mobile vs desktop vs another server)

**Some advanced features of RESTful APIs**
 - if the logic is complex, you can implement a *layered* system where clients interact with Server A. Server A would interact with many other servers to fulfil the request and give results back to client. Client does not have to know how to talk to the rest of the servers to accomplish this.
 - *code on demand*: Server might optionally send executable code (like JS) to run on client to fulfil a request.

### HTTP Request structure
A request consists of 3 parts
    
    1. header - this header contains
       1. Header consists of a request line. This line contains a HTTP verb, a URI and HTTP version number. An example syntax of request line is `GET /index.html HTTP 1.1`
       2. optional request headers which appear as kvp. For instance `Accept: image/gif, image/jpeg, */*`, `Accept-Language: en-us`.
    2. blank line
    3. body (optional) - body can contain any additional information, such as auth info etc.
       1. for instance `puppyId=12345&name=Fido+Lava`

### HTTP Response structure
Similar to a request, the response consists of 3 same parts

    1. a header, which contains
       1. status line which has the status code, HTTP version
       2. optional response headers
    2. blank line
    3. body (optional). The body contains what the client asked for. For instance a mp3 file, image file or html page.

## Making elegant RESTful APIs
FAQ, Quickstart, Hello World, Payground & Sandbox for sample API requests.

**URI design**
 * URI should take name of resource, not the action to take on them. For instance, `/tickets/4` is good, while `getTicketInfo/4` is not.
 * URI should plural form for each resource name. For instance, `/puppies`, `/tickets`
 * Use HTTP verbs to indicate action. The verbs are `GET`, `POST`, `PUT`, `DELETE`, `HEAD`, `OPTIONS`, `TRACE`, `CONNECT`.
     * `HEAD` and `GET` can be called by web crawlers and search engines, so ensure these resources can only get information and not modify.
 * Use HTTP status codes such as `404`, `401` along with error messages appropriately.

**API versioning**
 * Versioning allows to maintain backward compatibility when you build a permanent web API.
 * You can either add version in the URI, as `/puppies/v2/resource` or in the header of the call.