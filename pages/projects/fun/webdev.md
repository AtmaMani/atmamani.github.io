Title: Fundamentals of web development

## REST constraints
 - separation between client and server
 - server should not remember previous actions of the client (stateless)
 - each request from client should be treated independently and as if it is the first request
 - use of `tokens` allows for a stateless design, but gives users a stateful experience (such as a shopping website remembering what user added to shopping cart)
 - responses from server can be marked as cacheable or non cacheable. This way, client does not have to talk to server for the same requests
 - Server should provide a uniform interface, no matter what the client is (mobile vs desktop vs another server)

**Advanced constraints**
 - if the logic is complex, you can implement a *layered* system where clients interact with Server A. Server A would interact with many other servers to fulfil the request and give results back to client. Client does not have to know how to talk to the rest of the servers to accomplish this.
 - *code on demand*: Server might optionally send executable code (like JS) to run on client to fulfil a request.