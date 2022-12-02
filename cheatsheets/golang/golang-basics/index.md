title: Go basics

## Creating variables
Create variables by prefixing with `var` keyword:

```go
var variableName = <value>
```
Since a value is assigned to the variable in the same line, go **infers** the datatype automatically. In other cases, you need to specify the data type:

```go
var userName string
var userTickets int

userName = "ponniyinselvan"
userTickets = 800
```

Similarly, you can create constants using the `const` keyword:
```go
const constantName = <value>
```

In certain cases, you may want to override go's default datatypes. In such case, you can instantiate, assign value and still declare the type:

```go
var remainingTickets uint = 50  //switch from default int to uint, to prevent negative values
```

### Short code for creating and assigning vars
Go allows the `:=` short code to create and assign vars:

```go
confName := "go land conf"
```

### Scope of variables (and functions)
In Go, there are 3 levels of scope:

- **local**: only available within the a specific block of code - such as for block, if block, a function
- **package**: available to all files within the same package
- **global**: available across packages. Created with **Capitalized** first letter. Available after importing the package that has the member defined The best practice is to define the variable as local as possible.

```go
import (...)
var varName datatype = {} //values. Defining pacakge level variables

func main(){

}
```

## Printing
You can print statements to standard output using print functions that are available in the `fmt` module. This needs to be imported first.

```go
import fmt

fmt.Print("text here")      //prints a single line. No new line at the end.
fmt.Println("text here")    //prints with a new line at the end
fmt.Println("text", varName, "text", varName, "text")   //mixing vars and text
fmt.Printf("text %v text %v", var1, var2)               //Using formated print output
```

## Getting user input
To get an input from user using std input, use `fmt.Scan()` function. You need to pass a placeholder for the value. For this you use **pointers**. A **pointer** in go is another variable that holds the address of a given variable.

```go
var userName string
fmt.Print("Enter your username: ")
fmt.Scan(&userName)  //user input is saved to userName var
```

## Modularization
### Functions in go
Functions are defined using `func` keyword, using the syntax: `func <name> {...}`. Values are returned using `return` keyword. In golang, you can return **any number of values**.

```go
func <funcname> (arg1 datatype1, arg2 datatype2) return_datatype {
    //statemetnts

    return <variable>
}
```

If returning multiple values, then:

```go
func <funcname> (arg1 datatype1, arg2 datatype2) (returntype1, returntype2){
    //statemnts
    return value1, value2
}
```

```go
func greetUsers(confName string, remianingTx uint) string{
    return fmt.Printf("Welcome to %v .There are %v tix available", confName, remainingTx)
}

//call the fn
greetUsers("goland conf", 50)
```

#### Pass by value vs reference
In Go, functions pass by value. To pass a var by reference do this:

```go
func main(){
    var myVal = make([]map[string]string, 0)
    myVal["keuy"] = "value"

    someFunc(param1, param3, &myVal)    // passes address of myVal
}

func someFunc(param1 type, param2 type, param3 *[]map[string]string){
    //gets pointer to myVal
}
```


### Packages in Go
Go apps can be organized using packages. A package is a collection of go files. The first line in a go file is usually the `package <pkgname>` which indicates which package the file belongs to. Files in the same package can share functions, package level variables etc **without having to import** the same package.

```go
//main.go file
package main
import ()
//statements


//common.go file
package main
//statements
```
Both `main.go` and `common.go` are now part of the `main` package.

### Multiple packages
Larger applications often have multiple packages to organize code. By convention, each package has its own folder within the app's root folder as shown in [Quickstart](../#quick-start). To use code or variables from a different package, you **need to import the package**. However, for go to find the local, user-defined package, you need to import it by **prefixing package with module name** defined in **`go.mod`** file. 

Further, for go to find members from a different package, that package needs to be of **global** scope, for which it should it **start with a Capital letter**. This allows go to **"export"** that member to global scope. If you notice, the functions you use from even std packages such as `fmt` start with capitals, for instance `fmt.Println()`.

```go
//go.mod file
module booking-app

// helper/helper.go file -- helper package
package helper
import "fmt"    //all regular imports

func GreetUsers(){      //starts with Capital letter, so exported

}

// main.go file -- main package
package main
import (
    "fmt"
    "strings"
    "booking-app/helper"    //module name (from go.mod file) / pkg name
)

func main(){
    //statements
    val = helper.GreetUsers()   //calls func from helper package.
}
```