title: Go lang control flow - iteration and conditionals

In Go lang, loops are simplified. There is no `for`, `foreach`, `while`, `dowhile` etc. There is just a for loop.

## `for` loop

A minimum and an infinite for loop. Ended by `break` statement:
```go
for {
    //statements
    break
}
```

Typical for loop pattern - follows C pattern:
```go
for i=0; i<count; i++{
    //statements
    //executes until i reaches count
}
```

Conditional for loop (like a while loop):
```go
for <condition>{
    // executes until condition remains true
}
```

Foreach style loop:
```go
for index,element := range <slice/array> {
    //statements
    // range is an enumerator keyword
    break
}
```

## `if` statements
Comparison operators commonly used with `if`: `<, >, <=, >=, ==, !=`.
Logical operators: `&&, ||, !` for AND, OR, NOT evaluations.

```go
if <condition> {
    //statements, executes if eval to True
}

//single condition
if remainingTickets < 0 {
    //
}

// complex condition
if (remainingTickets < 0) && (len(bookings) > 10) {
    // two evals using and operator
}
```

## `if-else`, `if-else-if` statements

```go
if <condition> {

}
else {

}
```

```go
if <condition> {

}
else if{

}
else {

}
```

## Switch statements

```go
city := "London"

switch city {
    case "New York":
        //statements
    case "Mumbai":
        //statements
    case "London":
        //statements
    case "Los Angeles", "Pasadena":  //common outcome
        // statments for LA and Pas
    default:
        //statements
}
```