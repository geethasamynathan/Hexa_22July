# questions = ["What is Python?", "What is List?"]
# for i, q in enumerate(questions, start=1):
#     print(f"Q{i}: {q}")


students = [("Charlie", 85),("Alice", 90), ("Bob", 70) ]
print(students)
sorted_students = sorted(students, key=lambda x: x[0], reverse=False)
print(sorted_students)