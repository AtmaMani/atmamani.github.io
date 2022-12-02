title: Go lang - an introduction

## History of Go
[Go](https://go.dev/) was created in 2007 and open sourced in 2009 to take advantage of the changing landscape of server and cloud technology. Increasingly the servers on the cloud were becoming distributed and multi-threaded and a lot more capable. This meant, there was an increasing need for a simpler, higher-level language that was intended for back-ends on the cloud. Thus Go was designed to have a readable syntax as that of a dynamically typed language such as Python, but with the efficiency and speed of a lower-level statically typed language like C++.

Today, Go is popular as a back-end language for cloud based, microservice based architecture. Its characteristics of being a compiled language and platform agnostic runtimes make it highly desirable.

## Setting up Go
To install Go, run `brew install go`. Use `brew install go --dry-run` to check the version using a dry run.

Next, use [VSCode](https://code.visualstudio.com) as the editor. Use the extensions tab to search and install the Go extension by Google. Install all other sub tools that it suggests.

## Quick-start
Go programs are typically thought of as projects. This means, there is a set entry-point and a set of supporting files, each with its own business logic. Thus, your Go programs would be organized as such:

```bash
repo-root
    .gitignore
    readme.md
    project-root
        main.go   # compulsory
        go.mod    # defines project packages and architecture.
        file1.go    # files in same package
        file2.go
        pkg1        # user defined packages
            pkg1file1.go    # files within a package
            pkg1file2.go
        pkg2
            pkg2file1.go
            pkg2file2.go
        ...
    build-dir  # for circle CI, github/gitlab CI etc.
```

### A minimal Go project
At a minimum, a Go project can be a single file application. The snippet below shows the essential components of Go project.

```go
package main // the name of your package

import "fmt" // the package you are importing - from std lib in this case

// main() is the default entry point. Every go project needs an entry point.
func main() {
	fmt.Println("Hello world")
}
```
There can only be **one** `main()` in a Go project. To run this program, use:

```bash
$ go run main.go
Hello world
$
```

## Go lang conventions
Every programming language and community has a conventional way of doing things. Let's what those are for Golang.

1. Variable names use **camelCasing** convention.
2. Declare variables, functions before actual usage. (Just as in an interpreted language)