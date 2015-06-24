# Largest palindrome product

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

# def run(digits)
#   max = (('9' * digits).to_i * ('9' * digits).to_i)
#   min = (('1' + '0' * (digits - 1)).to_i * ('1' + '0' * (digits - 1)).to_i)
#   while max > min
#     if is_palindrome?(max) && !is_prime?(max)
#       break
#     else
#       max -= 1
#     end
#   end
#   max
# end

# def run
#   x, y = [999, 999]
#   until is_palindrome?(x * y)
#     if y > 99
#       y -= 1
#     else
#       y = x - 1
#       x -= 1
#     end
#   end
#   [x, y]
# end

# def is_palindrome?(num)
#   num.to_s.reverse == num.to_s
# end

# def is_prime?(num)
#   if num == 0
#     false
#   elsif num == 1 || num == 2
#     true
#   else
#     (2..num/2).detect{|i| num % i == 0}.nil?
#   end
# end