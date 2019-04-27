def palindrome?(s)
  low = 0
  high = s.length - 1

  while(low < high)
    if s[low] != s[high]
      return false
    end

    low += 1
    high -= 1
  end
  return true
end

puts(palindrome?("abcba"))
puts(palindrome?("abba"))
puts(palindrome?("abbca"))
