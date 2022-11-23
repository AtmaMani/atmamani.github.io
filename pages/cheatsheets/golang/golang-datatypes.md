title: Go Lang DataTypes

Go lang data types:

- **Basic type**: Numbers (integer variety, float variety, complex variety), strings, and booleans come under this category.
- **Aggregate type**: Array and structs come under this category.
- **Reference type**: Pointers, slices, maps, functions, and channels come under this category.
- **Interface type**

## Aggregate types
### Arrays
Arrays can store multiple values of **same** datatype. Arrays must be declared by specifying type and size. Arrays are `0` indexed as in other languages.

```go
var arrayName = [length]dataype{value1, value2}     // size is declared & initialized, cannot expand
var arrayName = [...]datatype{values,values}        // size is expandable, length is inferred
var arrayName = [length]datatype{}     // if size is declared and initliazied empty
var arrayName [length]datatype         // declared, not initialized

// can also use the short notation
arrayName := [<length>]datatype{values}

// initialize specific indices
arr1 := [5]int{1:10,2:40}   // sets 2nd element to 10 and 3rd element to 40 = [0 10 40 0 0] 
```

Array elements can be accessed using their index number:

```go
var prices = [10]int{10,30,40,80}

prices[2] = 100     //modify value
```

### Strings
String functions

**Contains**

## Reference types
### Slices
Slice is an abstraction of an Array. It is more flexible and can grow as it is of variable length. It is also index based. You create a slice using `var sliceName []string` to create a slice of type String.

```go
var sliceName []datatype
sliceName = append(sliceName, value)    // to add values
```

### Maps
Maps are like dicts in Python. Maps are created using the syntax **`var mapName = make(map[key-datatype]value-datatype)`**

```go
var userData = make(map[string]string)     //use make to create empty map

//populate values
userData["firstName"] = "adhitha"
userData["lastName"] = "karikalan"
```

Sometimes, you would like to create a list or slice of maps:

```go
var userData = make(map[string][string])    //stores info about 1 user

// create a slice of maps. The 2nd parameter is the initial size of the slice
//slices grow dynamically. So the init size is just syntactical.
var allUsers = make([]map[string][string], 10)  //stores all users
```

#### Features of a map
- Unlike dicts in Python, Maps can only store values that match the data type specified during declaration

### Structs
Structs hold values of mixed or multiple data types. It is built on arrays and maps. Structs are actually a custom `type`. To create a struct:

```go
type structName struct {    //use type keyword to create new struct type
    key1 <datatype>
    key2 <datatype>
    key3 <datatype>
}
```
for example you can define a `User` type as below:

```go
type UserData struct {
    firstName string
    lastName string
    address string
    age uint
    previousAddresses []string  //slice
    flightsBooked []map[string]string   //slice of maps
    mvp bool
}
```
You can create an instance as shown below:
```go
var phoenixUsers = make([]UserData, 0)  //use make to create a slice of UserData types

var u1 = UserData {
    firstName: "aditha",
    lastName: "karikalan",
    address: "chola kingdom",
    age: 40
}

phoenixUsers = append(phoenixUsers, u1)

// to query the struct var, use . notation
fmt.Println(u1.age)     // using . notation
```