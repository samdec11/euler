# Largest palindrome product

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

def run(digits, min=nil, max=nil)
  max -= 1 if max
  x = y = max || ('9' * digits).to_i
  floor = min || (('1' + '0' * (digits - 1)).to_i)
  while y > floor
    break if is_palindrome?(x * y)
    if x > floor
      x -= 1
    else
      x = y
      y -= 1
    end
  end

  this = x * y
  return 0 unless is_palindrome?(this)
  other = run(digits, x, y)
  result =  if this < other
              other
            else
              this
            end
  result
end

def is_palindrome?(num)
  num.to_s.reverse == num.to_s
end

# 906609 = 913 x 993
