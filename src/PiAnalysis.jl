module PiAnalysis

# using Plots

# Number of digits in pi = n
n = 100

setprecision(BigFloat,100000)

# Chudnovsky algorithm
export chud
function chud()

  pInvTemp = 0

  for i in 0:30

    pInvTemp = pInvTemp + (-1)^(i)*factorial(BigInt(6*i))*BigInt(545140134*i+13591409)/((factorial(BigInt(3*i))*((factorial(BigInt(i)))^3)*(BigInt(640320)^BigFloat(3*i+(3/2)))))

  end

  pInv = BigFloat(pInvTemp*12)

  p = BigFloat(1/pInv)

  return BigFloat(p)

end

export numDig
function numDig()
  p = BigFloat(pi)

  temp = p*(10^BigFloat(n))
  dig = Base.digits(trunc(BigInt,temp))
  numDgts = zeros(Float64, 10, 2)

  for i in 1:10
    numDgts[i,1] = i-1
  end

  for i in 1:n

    num = dig[i]

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

  return(numDgts)

end

end # module
