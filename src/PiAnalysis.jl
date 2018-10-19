module PiAnalysis

using Plots

# Compute pi using the Chudnovsky algorithm
export chud
function chud(prcsn::Int)

  setprecision(BigFloat,prcsn)

  pInvTemp = 0

  for i in 0:ceil(28*prcsn/1024)

    pInvTemp = pInvTemp + (-1)^(i)*factorial(BigInt(6*i))*BigInt(545140134*i+13591409)/((factorial(BigInt(3*i))*((factorial(BigInt(i)))^3)*(BigInt(640320)^BigFloat(3*i+(3/2)))))

  end

  pInv = BigFloat(pInvTemp*12)

  p = BigFloat(1/pInv)

  return BigFloat(p)

end

# Test Accuracy of Julia's pi

export piAccurate
function piAccurate(prcsn::Int)

  setprecision(BigFloat,prcsn)

  p1 = BigFloat(pi)
  p2 = chud(prcsn)
  diff = abs(p1-p2)

  return diff

end

# Find recurrences of each digit of pi

export numDig
function numDig(a::Int,b::Int,prcsn::Int)

  if a>=b
    return error("The first input cannot be greater than or equal to the second input")
  end

  if b > prcsn/3.5
    return error("The precision must be higher for this interval (Try a precision that is at least 3.5 times the end bound)")
  end

  setprecision(BigFloat,prcsn)

  p = BigFloat(pi)

  temp = p*(10^BigFloat(b))
  dig = Base.digits(trunc(BigInt,temp))
  numDgts = zeros(Float64, 10, 2)

  for i in 1:10
    d = i-1
    numDgts[i,1] = d
  end

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

  return(numDgts)

end

export digCompare
function digCompare(a::Int,b::Int,c::Int,d::Int,prcsn::Int)

  if (b-a) != (d-c)
    return error("The intervals are not equal")
  end

  if c<=a
    return error("The intervals cannot overlap")
  end

  dig1 = numDig(a,b,prcsn)
  dig2_temp = numDig(c,d,prcsn)
  dig2 = dig2_temp-[0 0;1 0;2 0;3 0;4 0;5 0;6 0;7 0;8 0;9 0]

  return dig1-dig2

end

export piPlot
function piPlot(a::Int,b::Int)

  pyplot()

  values = numDig(a,b)

  x = ["0","1","2","3","4","5","6","7","8","9"]

  y = values[:,2]

  pie(x,y,title="Digits in pi from $a to $b",l=0.5)

end


end # module
