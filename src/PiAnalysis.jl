module PiAnalysis

using Plots

# Function to compute pi using the Chudnovsky algorithm
#
# chud() takes the desired precision of BigFloat as input

export chud
function chud(prcsn::Int)

  # Set the precision of BigFloat using the input

  setprecision(BigFloat,prcsn)

  # Begin the summation in the algorithm

  pInvTemp = 0

  for i in 0:ceil(28*prcsn/1024)

    pInvTemp = pInvTemp + (-1)^(i)*factorial(BigInt(6*i))*BigInt(545140134*i+13591409)/((factorial(BigInt(3*i))*((factorial(BigInt(i)))^3)*(BigInt(640320)^BigFloat(3*i+(3/2)))))

  end

  # End the summation and multiply the result by 12

  pInv = BigFloat(pInvTemp*12)

  # Invert pInv to obtain pi

  p = BigFloat(1/pInv)

  return BigFloat(p)

end

# Function to test the accuracy of Julia's pi by comparing it to
# the result of the Chudnovsky algorithm
#
# piAccurate() takes the desired precision of BigFloat as input

export piAccurate
function piAccurate(prcsn::Int)

  # Set the precision of BigFloat using the input

  setprecision(BigFloat,prcsn)

  # Compute pi using Julia's value and chud() and return
  # the absolute value of the difference

  p1 = BigFloat(pi)
  p2 = chud(prcsn)
  diff = abs(p1-p2)

  return diff

end

# Function to find the number of recurrences of each digit of pi
#
# numDig() takes the number of the first and last digit in the
# desired interval, as well as the desired precision of BigFloat,
# as input

export numDig
function numDig(a::Int,b::Int,prcsn::Int)

  # Return errors if the input interval doesn't make any sense,
  # or if the precision of the desired interval is too small.

  if a>=b
    return error("The first input cannot be greater than or equal to the second input")
  end

  if b > prcsn/3.5
    return error("The precision must be higher for this interval (Try a precision that is at least 3.5 times the end bound)")
  end

  # Set the precision of BigFloat using the third input

  setprecision(BigFloat,prcsn)

  # Compute pi

  p = BigFloat(pi)

  # Convert pi into an array of digits

  temp = p*(10^BigFloat(b))
  dig = Base.digits(trunc(BigInt,temp))

  # Create an array to hold the numbers of recurrences the
  # first column contains the digit, and the second contains
  # the number of recurrences

  numDgts = zeros(Float64, 10, 2)

  for i in 1:10
    d = i-1
    numDgts[i,1] = d
  end

  # Count the recurrences

  for i in a:b

    num = dig[b+1-i]

    if num == 0
      numDgts[1,2] = numDgts[1,2] + 1
    elseif num == 1
      numDgts[2,2] = numDgts[2,2] + 1
    elseif num == 2
      numDgts[3,2] = numDgts[3,2] + 1
    elseif num == 3
      numDgts[4,2] = numDgts[4,2] + 1
    elseif num == 4
      numDgts[5,2] = numDgts[5,2] + 1
    elseif num == 5
      numDgts[6,2] = numDgts[6,2] + 1
    elseif num == 6
      numDgts[7,2] = numDgts[7,2] + 1
    elseif num == 7
      numDgts[8,2] = numDgts[8,2] + 1
    elseif num == 8
      numDgts[9,2] = numDgts[9,2] + 1
    elseif num == 9
      numDgts[10,2] = numDgts[10,2] + 1
    end
  end

# return the array of digits

  return(numDgts)

end

# Function to compare the number of recurrences in two different
# intervals

export digCompare
function digCompare(a::Int,b::Int,c::Int,d::Int,prcsn::Int)

  # Return errors if the intervals are not equal or overlap

  if (b-a) != (d-c)
    return error("The intervals are not equal")
  end

  if c<=a
    return error("The intervals cannot overlap")
  end

  # Use numDig() to compute the recurrences in each interval

  dig1 = numDig(a,b,prcsn)
  dig2_temp = numDig(c,d,prcsn)

  # Subtract out the first column of the second array so
  # that the first column will remain when the arrays are
  # subtracted

  dig2 = dig2_temp-[0 0;1 0;2 0;3 0;4 0;5 0;6 0;7 0;8 0;9 0]

  # Return the result of subtracting the arrays

  return dig1-dig2

end

# Function to plot the recurrences as a pie chart
#
# Takes the number of the first and last digit in the
# desired interval, as well as the desired precision of BigFloat
# as input
#
# Uses Plots and pyplot()

export piPlot
function piPlot(a::Int,b::Int,prcsn::Int)

  pyplot()

  values = numDig(a,b,prcsn) # Compute the recurrences

  # Put the values and the labels into two arrays and plot

  x = ["0","1","2","3","4","5","6","7","8","9"]

  y = values[:,2]

  pie(x,y,title="Digits in pi from $a to $b",l=0.5)

end


end # module
