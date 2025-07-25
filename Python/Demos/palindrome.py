import sys

s = input("Enter a string: ")
s_cleaned = s.replace(" ", "").lower()
is_palindrome = s_cleaned == s_cleaned[::-1]
print(is_palindrome)
# def isPalindrome(s):
#      s=s.replace(" ","").lower()
#      return s==s[::-1]
# print(isPalindrome(s))
# Write your logic Here