# R-programming
R Programming lessons from Coursera

# Overview and History of R
R is an implementation of  S language, initiated in 1976 as an internal statistical analysis environment.
R was created in New Zealand in 1991 and made public in 1993.

# R Console Input and Evaluation
Assignment operator and evaluation

    > x <- 5
    > print(x)
    [1] 5
    > x
    [1] 5

Simply typing the object name also works. 
The [1] indicated that `x` is a vector and 5 the first element.

Use the : operator to create integer sequences

    > x <- 1:20
    > x
    [1] 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
    [16] 16 17 18 19 20
    
# Data Types
## Objects and attributes
R has five basic or "atomic" classes of objectfs :
- character
- numeric (real numbers)
- integer
- complex
- logical (True/False)

The most basic object is a vector which can only contain objects of the same class.

## Numbers
By default, R treated numbers as numeric objects (double precision real numbers).
If you need an integer you need to use L suffix like 1L.

## Attributes
R can have the following attributes :
- names, dimnames
- dimensions
- class
- length
- other user-definited attributes/metadata

Attributes of an object can be found using function attributes()

## Vectors and lists
The `c()` function ca be used to create vectors of objects

    > x <- c(0.5, 0.6)
    > x <- c("a", "b", "c")

To initiate a vector use the `vector()` function

    > x <- vector("numeric", length = 10)
    > x
    [1] 0 0 0 0 0 0 0 0 0 0

When mixing objects, like numeric and character in a vector, numeric is converted to character.
To explicit coercion use the `as.*` function

    > x <- 0:6
    > class(x)
    [1] "integer"
    > as.logical(x)
    [1] FALSE TRUE TRUE TRUE TRUE TRUE TRUE
    
When coercion is not possible, NA is displayed.

List are a special type of vector that can contain elements of different classes. Very useful in R.

    > x <- list(1, "a", TRUE)
    > x
    [[1]]
    [1] 1
 
    [[2]]
    [1] "a"
    
    [[3]]
    [1] TRUE

## Matrices
Matrices are vectors with a dimension attribute. They are filled column first.

    > m <- matrix(1:6, nrow = 2, ncol = 3)
    > m
        [,1] [,2], [,3]
    [1,] 1     3    5
    [2,] 2     4    6

Matrices can be created from a vectors by modifying the dimension attribute

    > m <- 1:10
    > m
    [1] 1 2 3 4 5 6 7 8 9 10
    > dim(m) <- c(2, 5)
    > m
        [1,] [2,] [3,] [4,] [5,]
    [1,] 1    3    5    7    9
    [2,] 2    4    6    8    10

Matrices can also by created by column-binding or row-binding using `cbind()` and `rbind()`.

    > x <- 1:3
    > y <- 10:12
    > cbind(x, y)
         x  y
    [1,] 1  10
    [2,] 2  11
    [3,] 3  12
    > rbind(x, y)
        [,1] [,2] [,3]
    x    1    2    3
    y    10   11   12

## Factors
Factors are used to represent categorical data, like an integer vector where each integer has a label.

    > x <- factor(c("yes", "yes", "no", "yes", "no"))
    > x
    [1] yes yes no yes no
    Levels : no yes
    > table(x)
    x
    no yes
    2  3
    > unclass(x)
    [1] 2 2 1 2 1
    attr(, "levels")
    [1] "no" "yes"

To order the levels

    > x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
    > x
    [1] yes yes no yes no
    Levels : yes no

## Missing Values
They are denoted by NA or NaN (Not a Number)
- `is.na()` is used to tests objects if they are NA
- `is.nan()` is used to test for NaN
Those functions can be used directly on vectors or matrices

## Data Frames
They are used to store tabular data
They are represented as a list where every element as the same length. Data frames also have a special attribute
called `row.names`. They are usually created by calling `read.table()` or `read.csv()`.

    > x <- data.frame(foo = 1:4, bar = c(T, T, F, F))
    > x
      foo  bar
    1   1  TRUE
    2   2  TRUE
    3   3  FALSE
    4   4  FALSE
    > nrow(x)
    [1] 4
    > ncol(x)
    [1] 2

## Names attribute
Very useful for writing readable code and self-describing objects.

    > x <- 1:3
    > names(x)
    NULL
    > names(x) <- c("foo", "bar", "norf")
    > x
    foo bar norf
      1   2    3
    > names(x)
    [1] "foo" "bar" "norf"

For matrices.

    > m <- matrix(1:4, nrow = 2, ncol = 2)
    > dimnames(m) <- list(c("a", "b"), c("c", "d"))
    > m
      c d
    a 1 3
    b 2 4

# Reading Tabular Data
The are a few principal functions reading data into R.
- `read.table`, `read.csv`, for reading tabular data
- `readLines`, for reading lines of a text file
- `source`, for reading R code files (inverse of dump)
- `dget`, for reading in R code files (inverse of dput)
- `load`, for reading in saved workspaces
- `unserialize`, for reading single R objects in binary form

Analogous functions for writing data to files : `write.table`, `writeLines`, `dump`, `dput`, `save`, `serialize`.

The `read.table` function is one of the most commonly used functions for reading data. It has a few important arguments :
- `file`, the name of the file or a connection
- `header`, logical indicating if the file has a header line
- `sep`, a string indicating how the columns are separeted
- `colClasses`, a character vector indicating the class of each column in the dataset
- `nrows`, the number of rows in the dataset
- `comment.char`, a character string indicating the comment character
- `skip`, the umbers of lines to skip from the beginning
- `stringsAsFactors`, should character variable be coded as Factors

`read.csv` is identical to `read.table` except that the default separator is a comma.

# Reading Large Tables
The following tips are useful for reading large datasets :
- Read help page for `read.table`, which contains many hints
- Make a rough calculation of the memory reaquired to store your dataset
- Set `comment.char = ""` if there are no commented lines in your file

Use the `colClasses` argument to make loading MUCH faster.

    > initial <- read.table("datatable.txt", nrows = 100)
    > classes <- sapply(initial, class)
    > tabAll <- read.table("datatable.txt", colClasses = classes)

Here you first look at the 100 first rows, then apply the `class` function to this sub-dataset,
then load the full file with `colClasses` already known.

# Connections : Interfaces to the Outside World
- `file`, opens a connection to a file
- `gzfile`, opens a connection to a gzip file
- `bzfile`, opens a connection to a bzip2 file
- `url`, opens a connection to a webpage

Connection to file can be open and close

    > con <- file("foo.txt", "r")
    > read.csv(con)
    > close(con)
    
But for file, this is not very useful and equivalent to `data.csv("foo.txt")`.

# Subsetting
## Basics
- [ always returns an object of the same class as the original, can be used to select more that on element
- [[ is used to extract elements of a list or a data frame. 
- $ is used to extract elements of a list or data frame by name; semantics are similar to hat of [[
    
    > x <- c("a", "b", "c", "c", "d", "a")
    > x[1]
    [1] "a"
    > x[1:4]
    [1] "a" "b" "c" "c"
    > x[x > "a"]
    [1] "b" "c" "c" "d"
    > u <- x > "a"
    > u
    [1] FALSE TRUE TRUE TRUE TRUE FALSE
    
## Lists

    > x <- list(foo = 1:4, bar = 0.6)
    > x[1]
    $foo
    [1] 1 2 3 4
    > x[[1]]
    [1] 1 2 3 4
    > x$bar
    [1] 0.6
    > x[["bar"]]
    [1] 0.6

To subset more that one element use the `c` function

    > x <- list(foo = 1:4, bar = 0.6, baz = "hello")
    > x[c(1,3)]
    $foo
    [1] 1 2 3 4
    
    $baz
    [1] "hello"

To subset nested elements of a list

    > x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
    > x[[c(1,3)]]
    [1] 14
    > x[[1]][[3]]
    [1] 14

## Matrix

Matrices can be subsetted in the usal way with (i,j) type indices.

    > x <- matrix(1:6, 2, 3)
    > x[1, 2]
    [1] 3
    > x[1, ]
    [1] 1 3 5

By default it return a single vector, to turn off the behavior use `drop = FALSE`

    > x[1, 2, drop = FALSE]
        [,1]
    [1,] 3
    
## Data Frame
Use the `subset` function.

    > df <- data.frame(matrix(rnorm(20), nrow=10))
    > df
        X1          X2
    1  -0.45359039 -0.48127468
    2  -0.73025361  1.80813210
    3   0.33582147  0.05181295
    4  -2.78439005 -0.36683257
    5   0.97386398  0.08734192
    6  -0.91068543 -0.71892697
    7   0.98013151  0.61573900
    8   0.17393832 -0.36135419
    9  -0.01983313  2.12184619
    10 -0.49455030  0.58118793
    > subset(df, X1 > 0.2)
        X1         X2
    3 0.3358215 0.05181295
    5 0.9738640 0.08734192
    7 0.9801315 0.61573900

## Partial Matching
Works with [[ and $.

    > x <- list(aardvark = 1:5)
    > x$a
    [1] 1 2 3 4 5
    > x[["a"]]
    NULL
    > x[["a"], exact = FALSE]]
    [1] 1 2 3 4 5

__IMO, never use this ! That's confusing__

## Removing NA Values

    > x <- c(1, 2, NA, 4, NA, 5)
    > bad <- is.na(x)
    > x[!bad]
    [1] 1 2 4 5

Here bad is a logical vector with the same length as x and can be used to retrieve only the valid elements.
What if there are multiple things and you want to take the subset with no missing  values?

    > x <- c(1, 2, NA, 4, NA, 5)
    > y <- c("a", "b", NA, "d", NA, "f")
    > good <- complete.cases(x, y)
    > good
    [1] TRUE TRUE FALSE TRUE FALSE TRUE
    > x[good]
    [1] 1 2 3 4 5
    > y[good]
    [1] "a" "b" "d" "f"
    
## Vectorized Operations

    > x <- 1:4, y <- 6:9
    > x + y
    [1] 7 9 11 13
    > x >= 2
    [1] FALSE FALSE TRUE TRUE
    
    > x <- matrix(1:4, 2, 2), y <- matrix(rep(10, 4), 2, 2)
    > x * y
        [,1] [,2]
    [,1]  10   20
    [,2]  20   40

# Control Structures
## If-else

    if (x > 3) {
        y <- 10
    } else {
        y <- 0
    }

## For

    for (i in 1:10) {
        print(i)
    }
    
    x <- c("a", "b", "c", "d")
    for (i in seq_along(x)) {
        print(x[i])
    }

## While

    count <-0
    while (count < 10) {
        print(count)
        count <- count + 1
    }

## Repeat, Next, Break
Not very useful in statistics.

    x0 <- 1
    to1 <- 1e-8
    
    repeat {
        x1 <- computeEstimate()
        if (abs(x1 - x0) < to1) {
            break
        } ekse {
            x0 <- x1
        }
    }

`next` is used to skip an iteration of a loop

    for (i in 1:100) {
        if (i <= 20) {
            ## skip the first 20 iterations
            next
        }
        ## do something else
    }

## R Function
Functions are created using the `function()` directive and are stored as R objects.
Functioncs can be passed as arguments to other functions. R functions arguments can be matched
positionally or by name (but it's better to respect function signature order). Some arguments
can be optional.

    > mydata <- rnorm(100)
    > sd(mydata)
    > sd(x = mydata)
    > sd(x = mydata, na.rm = FALSE)
    > sd(na.rm = FALSE, x = mydata)

    strangeAdd <- function(a, b, c = 0) {
        a + b + c
    }
    > strangeAdd(1,2)
    [1] 3
    > strangeAdd(1,2,3)
    [1] 6

The "..." argument can be used to extend a function

    myplot <- function(x, y, type = "1", ...) {
        plot(x, y, type = type, ...)
    }

# Loop Functions
Avoid to use for, while... in the command line for exemple

## lapply
lapply take three arguments : a list x, a fonction FUN and other arguments via its... .

    > x <- list(a = 1:5, b = rnorm(10))
    > lapply(x, mean)
    $a
    [1] 3
    
    $b
    [1] 0.0296924

Using ... allow to add argument to the function used. runif function create
N random numbers, it allows also a min or a max value.

    > x <- 1:2
    > lapply(x, runif, min = 0, max = 10)
    [[1]]
    [1] 3.202142
    
    [[2]]
    [1] 6.848960 7.195282

## sapply
sapply will try to simplify the result of lapply if possible
- If the result is a list where every element is length 1, then a vector is returned
- If the result is a list where every element is a vector of the same length (>1), a matrix is returned.
- If it can''t figure things out, a list is returned

## apply
Mostly used to apply a function to the rows or columns of a matrix. Not realy faster than a loop but in one line of code (useful in  the command line).

    > x <- matrix(rnorm(200), 20, 10)
    > apply(x, 2, mean)
    // apply the mean on the columns -> 10 results
    > apply(x, 1, sum)
    // apply the sum on the rows -> 20 results
    
You can already use rowSum, rowMin... which are faster on large matrix.

## mapply
It is a multivariate apply of sorts which applies a function in parallel over a set of arguments.

    list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
    // This will create a list of vectors containing 1 repeat 4 times, 2 repeat 3 times...
    // We can also create this list with :
    > mapply(rep, 1:4, 4:1)
    
## tapply
It is use to apply a function over subsets of a vector.

## split
It takes a vector of other objects and splits it into groups determined by a factor or list of factors.

    > library(datasets)
    > head(airquality)
      Ozone Solar.R Wind Temp Month Day
    1    41     190  7.4   67     5   1
    2    36     118  8.0   72     5   2
    3    12     149 12.6   74     5   3
    4    18     313 11.5   62     5   4
    5    NA      NA 14.3   56     5   5
    6    28      NA 14.9   66     5   6
    // Split this dataframe by month
    > s <- split(airquality, airquality$Month)
    // Apply the colMeans function of Columns Ozone, Solar.R and Wind on our splitted dataframe by month
    > lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
    $`5`
       Ozone  Solar.R     Wind 
          NA       NA 11.62258 

    $`6`
        Ozone   Solar.R      Wind 
           NA 190.16667  10.26667 

Using sapply we can simplify the result. We can also add na.rm = TRUE as second argument of colMeans to avoid NA.

    > sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
                   5         6          7        8        9
    Ozone         NA        NA         NA       NA       NA
    Solar.R       NA 190.16667 216.483871       NA 167.4333
    Wind    11.62258  10.26667   8.941935 8.793548  10.1800

# Debugging Tools

## traceback
Prints out the function call stack after an error occurs.

    > lm(y-x)
    Error in stats::model.frame(formula = y - x, drop.unused.levels = TRUE) : 
      object 'y' not found
    > traceback()
    4: stats::model.frame(formula = y - x, drop.unused.levels = TRUE)
    3: eval(expr, envir, enclos)
    2: eval(mf, parent.frame())
    1: lm(y - x)

## debug
Flags a function for "debug" mode which allows you to step through execution of a function one line at a time

## trace
Allows you to insert debugging code into a function a specific places

## recover
Allows you to modify the error behavior so that you can brows the function call stack

## str
Compactly display the internal structure of an R object. For a list with nested list of arbitrary object 
it will display one line per nested list providing their object type and a truncated content of this 
list.

    x <- rnorm(100, 2, 4)
    > summary(x)
      Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
      -9.2340 -0.9033  1.6700  1.7720  4.1820 10.4300
    > str(x)
     num [1:100] -3.85 -1.59 2.88 9.98 1.71 ...

    > library(datasets)
    > head(airquality)
      Ozone Solar.R Wind Temp Month Day
    1    41     190  7.4   67     5   1
    2    36     118  8.0   72     5   2
    3    12     149 12.6   74     5   3
    4    18     313 11.5   62     5   4
    5    NA      NA 14.3   56     5   5
    6    28      NA 14.9   66     5   6
    > str(airquality)
    'data.frame':    153 obs. of  6 variables:
     $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
     $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
     $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
     $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
     $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
     $ Day    : int  1 2 3 4 5 6 7 8 9 10 ...

Here `str` function provide the number of observations, the number of variables, the type of each
variable and a truncated version of those variables. Also try the following code :

    > s <- split(airquality, airquality$Month)
    > str(s)
    
# Simulation
## Generated Random Numbers
Functions for probability distributions in R
- rnorm : generate random Normal variates with a given mean and standard deviation
- dnorm : evaluate the Normal probability density (with a given mean/SD) at a point (or vector fo points)
- pnorm : evaluate the cumulative distribution function for a Normal distribution
- rpois : generate random Poisson variates with a given rate

d stand for density, r for random number generation, p for cumulative distribution and q for quantile function.

    > rnorm(10, 10, 5)
     [1]  3.829957  1.990528 11.886098  5.898225 11.179007 10.405336  9.510652 16.373442  8.523557 12.446238
    
Here 10 numbers have been generated with mean egual 5 and a standard deviation egual to 5.

For simulation the `set.seed` function ensures reproducibility. Each time you call this function (for
exemple with argument 1) it will reset the random sequence.
    
    > set.seed(1)
    > rnorm(5)
    [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078
    > rnorm(5)
    [1] -0.8204684  0.4874291  0.7383247  0.5757814 -0.3053884
    > set.seed(1)
    > rnorm(5)
    [1] -0.6264538  0.1836433 -0.8356286  1.5952808  0.3295078
    
It also allows people to reproduce what you have done. 

TODO Here missing comprehension of Poisson distribution...

## Simulating a Linear Model
Suppose we want to simulate the following linear model
- y = Beta_0 + Beta_1 * x + epsi
- where epsi ~= Normal(0,2^2). Assume x ~= Normal(0,1^2), Beta_0 = 0.5 and Beta_1 = 2

    > set.seed(20)
    > x <- rnorm(100)
    > epsi <- rnorm(100,0,2)
    > y <- 0.5 + 2 * x + epsi
    > summary(y)
       Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    -6.4080 -1.5400  0.6789  0.6893  2.9300  6.5050 
    > plot(x, y)
    
![alt text](https://github.com/ericfrigot/R-programming/raw/master/images/linear-mode1.png "Linear Model Plot")

We can clearly this that the distribution is linear here.

Now, what if x is binary ?

	> set.seed(10)
	> x <- rbinom(100, 1, 0.5)
	> epsi <- rnorm(100, 0, 2)
	> y <- 0.5 + 2 * x + epsi
	> summary(y)
	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
	-3.4940 -0.1409  1.5770  1.4320  2.8400  6.9410 
	> plot(x,y)
	
![alt text](https://github.com/ericfrigot/R-programming/raw/master/images/linear-mode2.png "Linear Model Plot")

As x is binary, we have only two values for x while y is still continuous.

TODO Here missing comprehension of Poisson model...

## Random Sampling
The `sample` function draws randomly from a specified set of (scalar) objects allowing you to
sample from arbitrary distributions.

	> set.seed(1)
	> sample(1:10, 4)
	[1] 3 4 5 7
	> sample(1:10, 4)
	[1] 3 9 8 5
	> sample(letters, 5)
	[1] "q" "b" "e" "x" "p"
	> sample(1:10) ## permutation since there will be 10 objects
	 [1]  4  7 10  6  9  2  8  3  1  5
	> sample(1:10)
	 [1]  2  3  4  1  9  5 10  8  6  7

# R Profiler
It will help you to answer the question : Why my code is so slow ? The first thing to do is to find
where the code spends most of its time. First design your code, then optimize. "Premature optimisation
is the root of evil" (Donald Knuth).

## Using system.time()
Takes an arbitrary R expression as input and returns the amount of time taken to evaluate the expression.
It return a proc_time object containing a user time (time charged to the CPU) and elapsed time (wall clock
time). They are relatively close (unless you have waiting around for other things to happens or you
are using parallel processing via the parallel package or Multi-threaded BLAS libraries).

	> system.time(readLines("http://www.jhsph.edu"))
	user	system	elapsed 
     0.50	0.21	1.78 

If you don't know where to start there another function for that.

## Rprof
This function starts the profiler in R. `summaryRprof` will be more readable. Don't use both
`system.time` and `Rprof`. This function will keep the trace of time spend in each part of
your R code.

There are two methods for normalizing the data 
- "by.total" divides the time spend in each function by the total run time
- "by.self" does the same but first substract out time spent in functions above in the call stack

The following function try to compute the prime factors of a given number. Note that 1000001699 is prime.

	> primeFactors <- function(x) {
	+     x <- as.integer(x)
	+     div <- seq_len(abs(x))
	+     factors <- div[x %% div == 0L]
	+     return(factors)
	+ }
	> Rprof()
	> primeFactors(1000001699)
	[1]          1 1000001699
	> summaryRprof()
	$by.self
			  self.time self.pct total.time total.pct
	"%%"           6.62    87.57       6.62     87.57
	"seq_len"      0.94    12.43       0.94     12.43

	$by.total
				   total.time total.pct self.time self.pct
	"primeFactors"       7.54     99.74      0.00     0.00
	"%%"                 6.62     87.57      6.62    87.57
	"seq_len"            0.94     12.43      0.94    12.43
	"primeFactors        0.02      0.26      0.00     0.00

	$sample.interval
	[1] 0.02

	$sampling.time
	[1] 7.56

Here we see that seq_len function is quite fast and the most important time is spend in the %% function. 
"by.total" gives 99.74% for primeFactors function because this is the root function while "by.self" do not
mention it since no time is really consume in that function that is not consume by sub-function in it. 
	
It's good to break your code into functions so that the profiler can give useful information.






