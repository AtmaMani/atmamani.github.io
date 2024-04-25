# Grep - an introduction

## Purpose
`grep` is a Linux/Unix shell tool that allows you to search in text files. Through piping, you can also use it to search through the output printed to screen from another command. Most of what I use grep for is that.

## Syntax
General search syntax is 

```sh
grep "<search string>" <file.txt>
```
Grep will return any lines that contain the full or substrings of it.

### Piping
You can pass the output of a previous command to grep using the pipe **`|`** operator, like so:

```sh
$ argo list -n <namespace> --running | grep "fire-season-full"
fire-season-full-ca-nox
fire-season-full-ca-co2
...
```
You can pipe any number of times. You can pipe `grep` to another `grep`, which leads to some very powerful workflows.

```sh
(base) ➜  $ history | grep "git commit -m" | grep "error"
  859  git commit -m "chore(test):[READY-220] fix lint errors"
```
Here, `history` feature of zsh returns the last `1000` commands ran in terminal. We extract just the `git commit` commands. Of the result, we extract any line that spoke about an `error`.

### Options

Task                            | Option    | Example                           
--------------------------------|-----------|----------------------------------
Search whole string             | `-w`      | `grep -w "abc123" log.txt`        
Case insensitive search         | `-i`      | `grep -i "abc123" log.txt`        
Show line numbers               | `-n`      | `grep -n "abc123" log.txt`        
Show `n` lines before match         | `-B` n | `grep -win -B 2 "abc123" log.txt`
Show `n` lines after the match      | `-A` n | `grep -A 2 "abc" log.txt`
--------------------------------|-----------|----------------------------------
Search all text files in a dir recursively  | `-r`  | `grep -r "abc123" ./*.txt`
Search files, but only return number of hits, not every hit in a file | `-c` | `grep -c "abc" ./*.txt`

#### Combining options
Grep allows you to combine options with a single hyphen. Although this makes the command less readable, it is still a valid syntax.

Do case insensitive search of the full search term. Show results with line numbers
```sh
$ grep -win "<search term>" file.logs
> 51:search term
> 99:search TERM
```