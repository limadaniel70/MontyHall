import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sb

df = pd.read_csv("montyhall.csv")
sb.barplot(df)
plt.savefig("montyhall.png")