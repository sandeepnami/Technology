import pandas as pd
import math

d = {'1': 'Alice','2': 'Bob','3': 'Rita','4': 'Molly','5': 'Ryan'}
S = pd.Series(d)
print(S.iloc[0:2],"\n",S.iloc[0:3],"\n", S.loc[0:3])

pd.DataFrame.rename()