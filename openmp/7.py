import pandas as pd
import matplotlib.pyplot as plt

threads = ['1', '2', '4', '8', '16']
NUM = '7'
df = pd.read_csv(NUM + '.csv')
for thr in threads:
    for num in df.index:
      df[thr][num] = round(sum(list(map(float, df[thr][num].split(' ')))), 5)
df = df.set_index('size')
df.to_csv(NUM + '_agr.csv')

df_4 = pd.read_csv('4_agr.csv')
df_4 = df_4.set_index('size')

i = 1
for size in df.index:
    plt.subplot(2, 2, i)
    plt.title(str(size))
    plt.plot(threads, df.loc[size].values, label='true')
    plt.plot(threads, df_4.loc[size].values, label='false')
    plt.legend()
    i += 1
plt.show()


