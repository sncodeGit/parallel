import pandas as pd
import matplotlib.pyplot as plt

threads = ['2']
NUM = '3'
df = pd.read_csv(NUM + '.csv')
df = df.set_index('size')

plt.plot(df.index, df['2'], 'ro-')
plt.show()