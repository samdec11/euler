# Smallest multiple

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

def run(num)
  x = 1
  y = num
  until (1..num).all?{|n| y % n == 0}
    x += 1
    y = num * x
  end
  y
end

# 232792560
