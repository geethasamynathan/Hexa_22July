import sys

# Read input from command line
st =input('enter the string')

# Define vowels (both lowercase and uppercase)
vowels = "aeiouAEIOU"

# Dictionary to track each vowel count (case-insensitive)
vowel_count = {'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0}

# Count vowels
for char in st:
    if char in vowels:
        vowel_count[char.lower()] += 1

# Total count
total = sum(vowel_count.values())

# Print detailed result
print("Individual vowel counts:")
for v in "aeiou":
    print(f"{v}: {vowel_count[v]}")

print(f"Vowel count: {total}")
