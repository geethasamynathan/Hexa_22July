
import matplotlib.pyplot as plt

# # Line Plot
# x=[1,2,4,6,8]
# y=[10,34,21,78,56]

# plt.plot(x,y)
# plt.title("Demo Line Plot")
# plt.xlabel("X-axis")
# plt.ylabel("Y- axis")
# plt.show()


categories=['Fruits','Bread','Jam','Yogurt']
values=[230,56,45,34]
# # # Bar Chart
# plt.bar(categories,values)
# plt.title("Grossary gragh")
# plt.xlabel("categories")
# plt.ylabel("Values")
# plt.show()


## Pie cahrt
plt.pie(values,labels=categories,autopct='%1.1f%%')
plt.title("Grossary Ratio")
plt.show()
