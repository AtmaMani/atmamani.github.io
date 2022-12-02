title: Goroutines - concurrency in Golang

Writing concurrent programs is fairly easy in Go lang. This is one of the highlights of Go lang over interpreted languages like Python.

Goroutines in Go run on thread abstractions. These are not OS-level threads, instead are a higher-level abstraction of them. There can be multiple goroutines running in a single thread and Go takes care of their lifecycle. Using the abstractions allow faster creation and removal of concurrent code without the overhead of creating threads. Further, in other languages, inter-thread communication is a problem. However, in Go, you can create **channels** to communicate between goroutines.

## Quickstart
In go lang, you can easily run a function concurrently by simply prefixing `go` where you call the function.

```go
func someSlowLogic() {
    //statements
}

func main(){
    someSlowLogic() // calls the func to run synchronously

    go someSlowLogic()  // calls the same func in a separate thread.
}
```
### WaitGroups
In the simple pattern, the main thread will **not wait** for worker thread is done. So, it is possible for the main to exit even before worker is done. To solve this we need to **establish dependency** of one thread to another. This is accomplished using **`WaitGroup`s**.

```go
import "sync"   //sync pkg provides thread synchronization functionality

var wg = sync.WaitGroup{}   //this is a struct

func main(){
    //statements
    wg.Add(1)   //number of goroutines to add. One for each func
    go someFunc()   //func is added to wg WaitGroup

    //statements
    wg.Wait()   // waits for all goroutines to finish
}

func someFunc(){
    //statements
    //last line
    wg.Done()       // indicates that a WG can be released.
}
```

