import pandas as pd
import matplotlib.pyplot as plt

threads = ['1', '2', '4', '8', '16']
NUM = '5'
df_reduction = pd.read_csv(NUM + '_reduction.csv')
df_lock = pd.read_csv(NUM + '_lock.csv')
df_critical = pd.read_csv(NUM + '_critical.csv')
df_atomic = pd.read_csv(NUM + '_atomic.csv')

for thr in threads:
    for num in df_lock.index:
      df_lock[thr][num] = round(sum(list(map(float, df_lock[thr][num].split(' ')))), 5)
df_lock = df_lock.set_index('size')
df_lock.to_csv(NUM + '_lock_agr.csv')

for thr in threads:
    for num in df_reduction.index:
      df_reduction[thr][num] = round(sum(list(map(float, df_reduction[thr][num].split(' ')))), 5)
df_reduction = df_reduction.set_index('size')
df_reduction.to_csv(NUM + '_reduction_agr.csv')

for thr in threads:
    for num in df_critical.index:
      df_critical[thr][num] = round(sum(list(map(float, df_critical[thr][num].split(' ')))), 5)
df_critical = df_critical.set_index('size')
df_critical.to_csv(NUM + '_critical_agr.csv')

for thr in threads:
    for num in df_atomic.index:
      df_atomic[thr][num] = round(sum(list(map(float, df_atomic[thr][num].split(' ')))), 5)
df_atomic = df_atomic.set_index('size')
df_atomic.to_csv(NUM + '_atomic_agr.csv')

i = 1
for size in df_reduction.index:
    plt.subplot(2, 2, i)
    plt.title(str(size))
    plt.plot(threads, df_reduction.loc[size].values, label='reduction')
    plt.plot(threads, df_lock.loc[size].values, label='lock')
    plt.plot(threads, df_critical.loc[size].values, label='critical')
    plt.plot(threads, df_atomic.loc[size].values, label='atomic')
    plt.legend()
    i += 1
plt.show()
