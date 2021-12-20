import pandas as pd
import matplotlib.pyplot as plt

threads = ['1', '2', '4', '8', '16']
NUM = '8'
df_dynamic = pd.read_csv(NUM + '_dynamic.csv')
df_guided = pd.read_csv(NUM + '_guided.csv')
df_static = pd.read_csv(NUM + '_static.csv')

for thr in threads:
    for num in df_dynamic.index:
      df_dynamic[thr][num] = round(sum(list(map(float, df_dynamic[thr][num].split(' ')))), 5)
df_dynamic = df_dynamic.set_index('size')
df_dynamic.to_csv(NUM + '_dynamic_agr.csv')

for thr in threads:
    for num in df_guided.index:
      df_guided[thr][num] = round(sum(list(map(float, df_guided[thr][num].split(' ')))), 5)
df_guided = df_guided.set_index('size')
df_guided.to_csv(NUM + '_guided_agr.csv')

for thr in threads:
    for num in df_static.index:
      df_static[thr][num] = round(sum(list(map(float, df_static[thr][num].split(' ')))), 5)
df_static = df_static.set_index('size')
df_static.to_csv(NUM + '_static_agr.csv')

i = 1
for size in df_static.index:
    plt.subplot(2, 2, i)
    plt.title(str(size))
    plt.plot(threads, df_static.loc[size].values, label='static')
    plt.plot(threads, df_guided.loc[size].values, label='guided')
    plt.plot(threads, df_dynamic.loc[size].values, label='dynamic')
    plt.legend()
    i += 1
plt.show()
