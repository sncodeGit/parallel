import pandas as pd
import matplotlib.pyplot as plt

threads = ['1', '2', '4', '8', '10', '16']
NUM = 'monte-carlo'
df = pd.read_csv(NUM + '.csv')
df = df.set_index('size')

i = 1
for size in df.index:
    plt.subplot(1, 2, i)
    plt.title(str(size))
    plt.plot(threads, df.loc[size].values)
    i += 1
plt.show()
