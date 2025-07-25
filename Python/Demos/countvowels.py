st = input('Enter the string')
vowels = "aeiou"

# Initialize a counter
count = 0

# Loop through each character in the string
for char in st:
    if char in vowels:
        count += 1

# Correct output format
print(f"Vowel count: {count}")
