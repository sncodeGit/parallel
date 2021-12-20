import pandas as pd
import matplotlib.pyplot as plt

threads = ['1', '2', '4', '8', '16']
NUM = '6'
df = pd.read_csv(NUM + '.csv')
for thr in threads:
    for num in df.index:
      df[thr][num] = round(sum(list(map(float, df[thr][num].split(' ')))), 5)
df = df.set_index('size')
df.to_csv(NUM + '_agr.csv')

i = 1
for size in df.index:
    plt.subplot(1, 2, i)
    plt.title(str(size))
    plt.plot(threads, df.loc[size].values)
    i += 1
plt.show()
