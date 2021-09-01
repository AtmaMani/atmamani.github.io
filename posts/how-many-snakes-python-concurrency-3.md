title: How many snakes do you need? - Challenges in parallel computing
date: 03/30/2021
slug: how-many-snakes-python-concurrency-3
categories: technology
tags: parallel processing, python, threads, processes
status: draft

Concurrency and parallelism as seen earlier can speed up your Python application. However, when not careful, they can crop up a bunch of specific bugs and challenges. We will cover some of those in this article.

## Data race
A common problem with concurrency is when multiple workers attempt to read the same location in memory and when at-least one of them is attempting to change the value.

```python
import threading

garlic_count = 0

def shopper():
    global garlic_count
    print('Current garlic count: ', garlic_count)
    for i in range(10_000_000):  # 10 million
        garlic_count += 1

if __name__ == '__main__':
    barron = threading.Thread(target=shopper)
    olivia = threading.Thread(target=shopper)
    barron.start()
    olivia.start()
    barron.join()
    olivia.join()
    print('We should buy', garlic_count, 'garlic.')
```

The script above spawns `2` worker threads that increment the garlic count by `10` million. Ideally, they each are supposed to increment `10` million, resulting in a final count of `20` million. However, when you run it, you end up with this:

```
Current garlic count:  0
Current garlic count:  83186
We should buy 13724492 garlic.
```
which is a classic case of a data race.

## Mutex (Mutual Exclusion)
A **Critical Section** is the part of your code where multiple threads share the same data in memory. To prevent data corruption, the task of updating a critical section needs to be done uninterrupted - meaning as an **atomic transaction**. This ensures all other threads would read the updated value of the critical section and not stale values.

In programming, this is accomplished using **Mutex** or **Mutual Exclusion**. A mutex is a lock and only the thread possessing it will have access to update a shared resource / critical section. Only after the thread in possession releases a mutex, another thread can gain possession.

Acquiring of a mutex (the lock) is atomic, meaning it appears as an indivisible action to other threads even thought it may internally involve multiple steps. Thus no other thread can interrupt the thread acquiring the lock.

To rectify the previous code, we add create a mutex object using `threading.Lock()`. Then we call the `acquire()` and `release()` methods on the Mutex object appropriately when editing a shared resource. The snippet below rectifies the shopping cart code we had earlier.

```python
import threading

garlic_count = 0
pencil = threading.Lock() # create a Mutex

def shopper(pencil):
    global garlic_count
    pencil.acquire()
    for i in range(10_000_000):
        garlic_count += 1
    pencil.release()

if __name__ == '__main__':
    barron = threading.Thread(target=shopper, kwargs={'pencil':pencil})
    olivia = threading.Thread(target=shopper, kwargs={'pencil':pencil})
    barron.start()
    olivia.start()
    barron.join()
    olivia.join()
    print('We should buy', garlic_count, 'garlic.')
```
This has spawn two threads as earlier, but the results prints `20,000,000` correctly:

```python
We should buy 20000000 garlic.
```

### Locks and Reentrant Mutex
What happens when a thread locks a resource, does not unlock and tries to lock again? Well, a thread cannot lock a resource if it is already locked, so it just ends up waiting for its turn to lock, which will never come. This situation is called a **deadlock**.

Deadlocks pose a major limitation when writing recursive code. A **reentrant mutex** solves this problem by allowing a thread to lock a resource multiple times. However, the same thread should **unlock** the resource the corresponding number of times to properly release it.

In Python, you create a reentrant lock using `threading.RLock()` API.  One difference between `Lock()` and `RLock()`, when a resource is locked using `Lock()`, any thread can release it. However, only the thread that locked the reentrant lock can unlock it and it needs to do as many number of times it locked originally.