# PiAnalysis

[![Build status](https://ci.appveyor.com/api/projects/status/0h38q955ip7p7y6a?svg=true)](https://ci.appveyor.com/project/CourtA96/pianalysis) [![Build Status](https://travis-ci.org/CourtA96/PiAnalysis.svg?branch=master)](https://travis-ci.org/CourtA96/PiAnalysis)

## Introduction

PiAnalysis checks the accuracy of pi in Julia, counts the number of recurrences of the digits of pi in a given interval, compares the recurrences in two given intervals and plots the recurrences as a pie chart.

## Functions

### chud(prcsn::Int)

Function to compute pi using the Chudnovsky algorithm. The algorithm was found at [Wolfram MathWorld](http://mathworld.wolfram.com/PiFormulas.html).

chud(prcsn) takes the desired precision of BigFloat (prcsn) as input.

#### Example code:

```
julia> chud(1024)

3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724586975

```

### piAccurate(prcsn::Int)

Function to test the accuracy of Julia's pi by comparing it to the result of the Chudnovsky algorithm.

piAccurate(prcsn) takes the desired precision of BigFloat (prcsn) as input.

#### Example Code:

```

julia> piAccurate(1024)
2.225073858507201383090232717332404064219215980462331830553327416887204434813918195854283159012511020564067339731035811005152434161553460108856012385377718821130777993532002330479610147442583636071921565046942503734208375250806650616658158948720491179968591639648500635908770118304874799780887753749949451580452e-308

julia> piAccurate(2048)
1.23773841895303131019207334798847914155702252155398761838163938328680854587649199257054117862250391810129657517016072470087867463518994332006894734725549325007442442971385749479618839407491882182171971233827496621282634764287010730944596563196778059935870328068785390110748652831457215353961903358853051592648048230281704557912767239226880204041705222071078553939703220630529136887768204221128799209819801880224640514584916488064014098868520606321821389132296167075800734678410700962370805812193014100267245294523990995150267171707445262244433800441738535148242223885270476332617247948193852462757955270935911162744595e-616

```

### numDig(a::Int,b::Int,prcsn::Int)

Function to find the number of recurrences of each digit of pi.

numDig(a,b,prcsn) takes the place number of the first and last digit in the desired interval (a,b), as well as the desired precision of BigFloat (prcsn), as input.

Returns an array with the digits in the first column and the number of recurrences in the second column.

#### Example code:

```
julia> numDig(1,100,1024)
10×2 Array{Float64,2}:
 0.0   8.0
 1.0   8.0
 2.0  12.0
 3.0  11.0
 4.0  10.0
 5.0   8.0
 6.0   9.0
 7.0   8.0
 8.0  12.0
 9.0  14.0

 ```

### digCompare(a::Int,b::Int,c::Int,d::Int,prcsn::Int)

Function to compare the number of recurrences in two different intervals.

Takes the takes the number of the first and last digit in both desired intervals (a,b) and (c,d), as well as the desired precision of BigFloat (prcsn),as input.

Returns an array with the digits in the first column and the difference in the number of recurrences in the second column.

#### Example code:

```

julia> digCompare(1,100,101,200,1024)
10×2 Array{Float64,2}:
 0.0  -3.0
 1.0  -4.0
 2.0   0.0
 3.0   3.0
 4.0  -2.0
 5.0  -4.0
 6.0   2.0
 7.0   4.0
 8.0  -1.0
 9.0   5.0

 ```

### piPlot(a::Int,b::Int,prcsn::Int)

Function to plot the recurrences as a pie chart

Takes the number of the first and last digit in the desired interval (a,b), as well as the desired precision of BigFloat (prcsn) as input

Uses Plots and pyplot()

#### Example code

```

julia> piPlot(1,100,1024)

```

![piPlot(1,100,1024) output](https://raw.githubusercontent.com/CourtA96/PiAnalysis/master/pi%20chart%20example%20image.png)

## Tests

The tests check that chud(prcsn) is calculating pi accurately by comparing the result of chud(prcsn) to that of Julia's pi then check piAccurate(prcsn) by comparing the difference to the result of piAccurate(prcsn). If the tests pass, either they're both right or they're both wrong, and most likely they're both right.

The tests also check that the first 10 digits of numDig(a,b,prcsn) are correct and then check that the results of numDig(a,b,prcsn) and digCompare(a,b,c,d,prcsn) don't vary outside statistical probability

The digits of pi are randomly distributed, so the count for each digit shouldn't vary outside (+/-)sqrt(N) of 1/10th of N where N is the length of the interval. By the same reasoning, the result for each digit in digCompare(a,b,c,d,prcsn) should be within (+/-)sqrt(2) * sqrt(N) since errors add in quadrature.

## Author

 - Courtney Allen

## License

Apache License 2.0

see [LICENSE](https://github.com/CourtA96/PiAnalysis/blob/master/LICENSE) for more information.
