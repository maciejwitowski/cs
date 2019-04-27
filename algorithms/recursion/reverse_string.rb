# Reverse a string using recursion
def reverse(s)
  if s.length <= 1
    s
  else
    s[-1] + reverse(s[0..-2])
  end
end

puts("'abcd' reversed equals '#{reverse("abcd")}'")
