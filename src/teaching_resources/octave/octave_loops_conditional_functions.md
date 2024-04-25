# Octave / MATLAB - lops, conditional processing, functions

[Octave](https://www.gnu.org/software/octave/) is an open source scientific computing package. It has a GUI, kernel and a programming language modeled after MATLAB. File extensions are `.m`. This page is a guide to the octave programming language.

<center><img src="https://www.gnu.org/software/octave/img/example-mesh.svg" width=350></center>

<a id="markdown-general-caveats" name="general-caveats"></a>
### General caveats
 - You end statements with a `;`. If not, the kernel does not throw an error, instead will echo the output of each line.
 - If you do not catch the output of an operation in a variable, a default variable called `ans` is created and that holds the value. At any time, `ans` holds value of latest operation.
 - Matlab / octave functions can return **multiple values**.

<a id="markdown-variables" name="variables"></a>
## Variables
Variables can be assigned without initializing.

```matlab
a = 1;
b = [1,2,4]; % row vector
% Use % for comments
c = [5;6;7]; % col vector
```
2D arrays can be initialized as 

```matlab
>> a2d = [1,2,3;4,5,6;7,8,9] % ';' is used to separate rows.
a2d =
   1   2   3
   4   5   6
   7   8   9
```
<a id="markdown-standard-matrix-creation-functions" name="standard-matrix-creation-functions"></a>
## Standard matrix creation functions
```matlab
>> eye(3)  % identity
ans =
Diagonal Matrix
   1   0   0
   0   1   0
   0   0   1

>> zeros(2,3)
ans =
   0   0   0
   0   0   0

>> rand(2,5)  % uniform random numbers between 1,1
ans =
   0.86289   0.18309   0.48379   0.36600   0.63669
   0.32459   0.89961   0.79682   0.39961   0.15351

>> randn(3,4)
ans =
   1.151159   0.022623  -1.030988   0.460505
  -0.386885  -0.188437   0.339421  -1.131755
   0.573182   0.451552  -0.307362  -1.717639

>> magic(3)  % creates matrix whose each row, col, diagonal sum to same value
ans =
   8   1   6
   3   5   7
   4   9   2
```

<a id="markdown-automatic-map-operations" name="automatic-map-operations"></a>
## Automatic `map` operations
Octave is designed to work primarily with arrays and vectors. Thus when you pass an array or vector to a standard function or operator, it **automatically maps the function on each element and runs it** and returns either an array/vector or scalar, depending on the operation.

```matlab
>> squares = [4,9,16,25,36,49];
>> sqrt(squares) % returns a vector output
ans = 2   3   4   5   6   7

>> min(squares)
ans =  4  % scalar output
```
When you run functions on a 2D matrix, they run on each column vector:
```matlab
>> sum(magic(3)) % default is columnwise operation
ans =
   15   15   15

>> sum(magic(3), 2)  % does a row-wise operation
ans =

   15
   15
   15

>> prod(magic(3))  % multiply each element in the matrix. Here multiplies each in col vector
ans =
   96   45   84

>> max(magic(3))
ans =
   8   9   7
```

Functions in Octave can return multiple values. For instance:
```matlab
>> [val, index] = min(squares)
val =  4
index =  1
>>
```
<a id="markdown-automatic-broadcasting" name="automatic-broadcasting"></a>
### Automatic broadcasting
When you operate a scalar against a vector, matlab will automatically scale up that scalar into a vector and perform an element wise computation as shown below:

```matlab
>> x=-2:0.7:2
x = -2.0000   -1.3000   -0.6000    0.1000    0.8000    1.5000
>> x+10
ans = 8.0000     8.7000     9.4000    10.1000    10.8000    11.5000
>>
```
Similarly when you multiply, subtract or divide a scalar from a vector, it is automatically broadcasted.

## Looping through a matrix
The automatic map operations should have most things covered for you. Still, you might need to write a loop. Below is syntax of `for` loop.

```matlab
for iterator=<range>,
   operation1;
   operation2;
   condition check
      operation3;
      break;
   condition check2
      operation4;
      continue;
end;
```
Note the `,` at end of the line with `for`.

```matlab
>> indices=1:10;
>> for i=indices,
       disp(i);
   end;
 1
 2
 3
 .
 .
 .
```

### While loop
The syntax for while loop is

```matlab
while condition,
   operation;
end;
```
Once again, note the `,` at line 1.


<a id="markdown-array-multiplication" name="array-multiplication"></a>
### Array multiplication
There are two types of multiplication
 - element wise - which is accomplished by prefixing the operator with `.` such as: `.<operator>` or `.*`
 - matrix multiplication - which will happen when you use `*`.

Thus:
```matlab
>> x
x = -2.0000   -1.3000   -0.6000    0.1000    0.8000    1.5000

>> x2 = [1,2,3,4,5,6]
x2 = 1   2   3   4   5   6

>> x.*x2
ans = -2.00000  -2.60000  -1.80000   0.40000   4.00000   9.00000
>>
```
When you want to multiply two matrixes, you do:
```matlab
>> x*transpose(x2)
ans =  7.0000
```

<a id="markdown-transposing-a-matrix" name="transposing-a-matrix"></a>
## Transposing a matrix
You can call the built-in `transpose()` function (shown previously) or use the `'` operator.

```matlab
>> x2'
ans =
   1
   2
   3
   4
   5
   6
```

<a id="markdown-reshaping-matrixes" name="reshaping-matrixes"></a>
## Reshaping matrixes
You can reshape using the `reshape(<arr>, nrows, ncols)` function. Note, it flows elements **column wise, followed by rows** as shown below:

```matlab
>> vec = 1:16;
>> reshape(vec, 2,8)
ans =
    1    3    5    7    9   11   13   15
    2    4    6    8   10   12   14   16

>> reshape(vec, 4,4)  % note how elements flow along columns, not rows.
ans =
    1    5    9   13
    2    6   10   14
    3    7   11   15
    4    8   12   16
```

<a id="markdown-range-functions" name="range-functions"></a>
## Range functions
You can generate uniformly spaced vectors, using 2 methods. If you want uniformly spaced vectors, use the `:` operator. If you want a specific number of elements within a range, then use the `linspace` function.

The `:` operator takes syntax `start:spacing:end`
```matlab
first_10_even_numbers = 0:2:21
first_10_even_numbers = 0    2    4    6    8   10   12   14   16   18   20
```

The `linspace` function takes arguments `linspace(start, end, numPoints)` where start and end are included.

```matlab
>> linspace(1,10,7)
ans = 1.0000    2.5000    4.0000    5.5000    7.0000    8.5000   10.0000
```
<a id="markdown-conditional-processing" name="conditional-processing"></a>
## Conditional processing
Logical operators in octave are `<, >, <=, >=, ~, ==, ~=, &, |`. Matlab returns `1` for True and `0` for False. Thus

```matlab
>> heat = 74
heat =  74
>> heat < 100
ans = 1
>> heat > 100
ans = 0
>> heat == 74
ans = 1
```

Conditional operators also `map` on all elements of the vector. Thus to find elements in a vector greater than a threshold, do:

```matlab
>> v1 = linspace(1,10,7);
>> ind = v1 > 5  % returns truth vector
ind = 0  0  0  1  1  1  1 
>> vals = v1(ind) % use truth vector as index
vals = 5.5000    7.0000    8.5000   10.0000
```
To find values that fall between a range:
```matlab
>> v1(v1<8 & v1>3)
ans = 4.0000   5.5000   7.0000
```

<a id="markdown-if-elseif-else-blocks" name="if-elseif-else-blocks"></a>
### `if-elseif-else` blocks
Jump to defining functions if you want to read that first.
```matlab
function charge = parkingRates(hours)
  %Calculates parking charge based on number of hours%
  if hours <=1
    charge = 2;
  elseif hours<=8 && hours>1
    charge = hours*0.75;
  else
    charge = 9;
  end
end
```
The `&&` operator is a performance opt that Matlab editor suggested. Else I would use only one of it.

<a id="markdown-styling-print-outputs" name="styling-print-outputs"></a>
## Styling print outputs
Use `disp` to display. You can style print outputs with `sprintf` and sending the string composed to `disp()`.

```matlab
>> vec1 = [2,3,4,5];
>> disp(vec1)
   2   3   4   5
```

```matlab
>> disp(sprintf("Mean of the array is %0.3f", mean(vec1)))
Mean of the array is 3.500
```
Use `C` style statements within `sprintf`.

<a id="markdown-array-indexing-slicing-dicing" name="array-indexing-slicing-dicing"></a>
## Array indexing, slicing, dicing
Consider this `4x4` matrix:
```matlab
>> readings=linspace(1,10,16);
>> readings = reshape(readings, 4,4)
readings =

    1.0000    3.4000    5.8000    8.2000
    1.6000    4.0000    6.4000    8.8000
    2.2000    4.6000    7.0000    9.4000
    2.8000    5.2000    7.6000   10.0000
>>
```
To get the first column vector, use `:,n` where `:` means all rows here and replace `n` with column number, starting with `1` instead of `0`.:
```matlab
>> readings(:,1)  % Note: matlab is 1 indexed, not 0 indexed
ans =
   1.0000
   1.6000
   2.2000
   2.8000
>>
```
Also note, I am using **`()` to index arrays, not `[]`** as in Python and other languages.

To dice the array by pulling 2nd, 3rd rows, 2nd, 3rd columns, do the following:

```matlab
>> readings([2,3], [2,3])
ans =
   4.0000   6.4000
   4.6000   7.0000
```
<a id="markdown-array-concatenation" name="array-concatenation"></a>
## Array concatenation
You can concatenate along rows or columns using the `,` or `;` operators:

```matlab
>> [eye(3), randn(3)]  % use , to concatenate along columns
ans =
   1.00000   0.00000   0.00000   0.68098  -1.07370  -1.99950
   0.00000   1.00000   0.00000   0.19421   0.06390   0.29864
   0.00000   0.00000   1.00000  -0.03696  -0.24735  -0.18180

>> [eye(3); randn(3)]  % use ; to concatenate along rows
ans =
   1.00000   0.00000   0.00000
   0.00000   1.00000   0.00000
   0.00000   0.00000   1.00000
   0.78756  -0.22399   0.59963
  -0.93718   0.34779   0.27082
  -2.00364  -0.45362  -1.47926
>>
```
<a id="markdown-statistical-operations-on-arrays" name="statistical-operations-on-arrays"></a>
## Statistical operations on arrays
Let us start with an array as below:
```matlab
>> vec45 = reshape(linspace(1,10,20), 4,5)
vec45 =
    1.0000    2.8947    4.7895    6.6842    8.5789
    1.4737    3.3684    5.2632    7.1579    9.0526
    1.9474    3.8421    5.7368    7.6316    9.5263
    2.4211    4.3158    6.2105    8.1053   10.0000
>>
```
**Find mean of each column**
```matlab
>> mean(vec45)
ans =   1.7105   3.6053   5.5000   7.3947   9.2895
```
**Find mean of each row**
```matlab
>> mean(vec45,2)  % pass the dimension arg. Set it to 2 for mean along rows
ans =
   4.7895
   5.2632
   5.7368
   6.2105
```
Another way of doing this is to transpose the matrix and take regular mean.

**Find mean of entire matrix**
Turn the matrix into a column vector and pass that to the mean.
```matlab
>> mean(vec45(:))
ans =  5.5000
```

<a id="markdown-writing-functions" name="writing-functions"></a>
## Writing functions
You call functions as 
```matlab
y = func_name(arg1, arg2);
```

The syntax to write functions is:
```matlab
function [out1, out2...] = functionName(in1, in2, ...)
    %Doc string%
    statement1;
    statement2;
    out1 = statement;
    out2 = statement;
    ...
end
```
There is no `return` statement. All variables you define in the out parameter array (or scalar) will get returned. Matlab allows you to **return more than one variable**.

```matlab
function result = hmean(vec1)
  %calculates harmonic mean of the given vector%
  vec1 = vec1(:)'; %convert to vectors
  reciprocals = 1./vec1;  %convert to reciprocals
  sum_reciprocals = sum(reciprocals); % sum of reciprocals - the denominator
  
  result = size(vec1)(2) / sum_reciprocals;
endfunction

>> hmean([2,3,4,5])
ans =  3.1169
>>
```

<a id="markdown-reusing-functions" name="reusing-functions"></a>
### Reusing functions
A quick and easy way to reuse functions in other scripts is to put just the function (not anything else) in a separate `.m` file with the same name as the function. Matlab will automatically search for it and import it.

To hack the search path, use `addpath('full_path')` to add a folder to Octave path. This way, you can load a function or module from a different directory.