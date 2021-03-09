title: How many snakes do you need? An introduction to concurrency and parallelism in Python
date: 03/03/2021
slug: how-many-snakes-python-concurrency
categories: technology
tags: parallel processing, python, threads, processes
status: draft

## Performance matters
At some point, every Python developer wonders if it's their program that is slow, or Python that is slow. In most cases, it is their program itself. Although Python gets a bad rap for being slower than compiled languages like C, C++, developers can utilize concurrency and parallelism to see significant gains.
<!--TEASER_END-->

So, what's the difference between **concurrency** and **parallelism**?

- **Concurrency** is the virtue of tasks not holding up one another and letting the program to progress. Think of blocking vs non-blocking.
- **Parallelism** is the practice of breaking a large task into smaller subtasks that can run in parallel, at the same time.

Both concurrency and parallelism share implementation aspects. In general, UI design cares more about concurrency where as big data and scientific data processing cares more about parallelism.

It is also relevant to discuss another paradigm in computing called asynchronous (vs synchronous) processing. A program is set to be **asynchronous**, if does not expect the caller to wait until it finishes execution. Programs accomplish this by providing a `jobid` for each task which the caller can *poll* at intervals to know if the task finished or not. Thus, the caller can submit a job to the async program, proceed to do other stuff and then use the result when it really needs it. **Thus even though a calling program may not implement parallelism, it can now run tasks concurrently by using async programming model.**

Another way to differentiate concurrency from parallelism is to simply say, parallelism involves threads in different processors, which allows them to execute at the same time, whereas concurrency is multiple threads on the same process, which although are non-blocking, they do not strictly execute all at the same time. However, these threads still individually make progress since the process will cycle through them.

### Threads vs Processes
A **process** is an instance of your program that is being executed. It has `3` elements - the code, the data (variables) used by the code and the state of the process (execution context). Each process has its own address space and don't typically talk to each other.

Each process can have one or more **threads**. Threads are lightweight as they share the address space with other threads within the same process and is not treated as a separate entity by the host OS.

Typically, operating systems cycle through threads in a **round-robin** fashion. The thread that gets to execute is called the *main* thread. But how long will it be the main thread? In Python, a thread will execute until

 - it is finished
 - until it is waiting for some IO
 - starts a sleep
 - has been running for `15ms`

after which, the OS will switch to another in its queue before returning back to it.

## Threading
A thread in Python can be created using the `Thread` class from the `threading` module. A thread can be in one of 3 states.

### Thread states
When a thread is created, it just exists, remains in an un-started state. Once you call the `start()` method, it goes to one of 3 states

- Runnable - a state where the processor can execute it
- Running - currently being the `active` thread
- Waiting - where it is blocked by another process or thread. The `join()` method allows you to represent this dependency.

The scheduler moves the thread through these states. The thread remains **alive** until its `run()` method terminates, upon which, it becomes **dead**. The graphic below (from *Hunt J. (2019)*) explains these states quite well.

<img src="/images/concurrency-thread-states.png">

### Instantiating the Thread class

The constructor for Thread looks like below

```python
class threading.Thread(group=None, target=None, 
                      name=None, args=(), kwargs={},
                      daemon=None)
```

`group` is reserved, primarily to be used when `ThreadGroup` class is implemented. `target` accepts a callable object (like a method). The `run()` method of the Thread object will call that that object. `name` is the name of the thread and by convention takes the form `Thread-N` where N is a number. `args` collects the arguments to pass to the callable object and `kwargs` does the same but with named arguments.

So, a simple example could be:

```python
from threading import Thread

def simple_worker(greet='hello'):
    print(greet)

t1 = Thread(target=simple_worker)
print(t1.is_alive())  # prints False
t1.start()  # prints hello
print(t1.native_id)   # prints the thread ID.
```

Typically, when you execute in a separate thread, you will notice the kernel's main becomes free even if the thread you spawned is still running. For example see this:

```python
from time import sleep

def worker():
    for i in range(0,10):
        print('.', end='', flush=True)
        sleep(1)

print('Starting')

t2 = Thread(target=worker, name='t2')
t2.start()
print('\nDone')
```
will print
```cmd
Starting
.
Done
.......
```
See `Done` got printed before all the dots got printed, which means the execution proceeded right along with the next steps. The worker did not block the main thread.

You can make one thread wait for another using the `join()` method. If you add a `t2.join()` after `t2.start()`, it would wait for the worker to finish and then print `Done`.

### Inspecting threads
`threading.enumerate()` will print all the threads that are running:

```python
[<_MainThread(MainThread, started 4515802560)>,
 <Thread(Thread-2, started daemon 123145471606784)>,
 <Heartbeat(Thread-3, started daemon 123145488396288)>,
 <HistorySavingThread(IPythonHistorySavingThread, started 123145506258944)>,
 <ParentPollerUnix(Thread-1, started daemon 123145523585024)>
 <Thread(t2, started 123145540374528)>]  ## -> my thread
```
and `threading.current_thread()` will print the currently active thread:

```python
<_MainThread(MainThread, started 4515802560)>
```

### Multiple threads
You can start multiple threads for the same worker function. Each thread will invoke the function once, but will retain its own local heap space as can be seen below:

```python
from time import sleep
import random

def worker():
    mark = ['a','b','c','d','e','f','g']
    prefix=random.choice(mark)  # will choose a prefix at random

    for i in range(0,10):
        print(prefix+str(i), end=" ", flush=True)
        sleep(1)

print('Starting')

ta = Thread(target=worker, name='ta')
tb = Thread(target=worker, name='tb')
tc = Thread(target=worker, name='tc')
ta.start()
tb.start()
tc.start()
print('\nDone')
```
will print

```python
Starting
a0 d0e0  
Done
a1d1e1   a2d2e2   e3d3a3   e4d4a4   e5 d5a5  e6a6d6   a7e7d7   e8d8a8   e9d9a9
```
In this case, `a`,`d`,`e` are the prefixes each thread chose. As you see in the print, the threads don't go off in sequence as the prefix arrive mixed in the prints. The same thread never prints in succession, which would mean as soon as the sleep is encountered, the main thread switches to the other threads and so on until each thread has to eventually finish the sleep time.


## Multiprocessing


## References

* Hunt J. (2019) Introduction to Concurrency and Parallelism. In: Advanced Guide to Python 3 Programming. Undergraduate Topics in Computer Science. Springer, Cham. https://doi.org/10.1007/978-3-030-25943-3_29 