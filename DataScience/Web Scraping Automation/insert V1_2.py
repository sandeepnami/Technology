"""
72 charaters limit

  INSERT INTO LMPLCSSA.CLIENT_OCCUP_CD                                  
  VALUES ('CC0013 ','010015','580','146','S',                           
          'AMUSEMENT CENTER - INCLUDING VIDEO GAMING MACHINES       '); 
  INSERT INTO LMPLCSSA.CLIENT_OCCUP_CD                                  
  VALUES ('CC0013 ','010026','269','269','L',                           
          'ANTIQUE STORE                                            '); 

"""
import pandas as pd
import textwrap

def pre_processing(df,column_map_dict):
    df = df.rename(columns=column_map_dict)
    df['CLIENT_OCC_CD'] = df['CLIENT_OCC_CD'].apply(lambda x: str(x).zfill(6))
    df['HSB_OCC_CD'] = df['HSB_OCC_CD'].apply(lambda x: str(x).zfill(3))
    df['CLIENT_OCCUP_DESC'] = df['CLIENT_OCCUP_DESC'].apply(lambda x: x.replace("'", "''"))
    return df


def gen_query(row,sql_line1):
    if "INSERT" in sql_line1:
        values_to_insert = f"'{row['CLIENT_OCC_TYPE_CD']} ', '{row['CLIENT_OCC_CD']}', '{row['HSB_OCC_CD']}', '{row['RANKING_CD']}', '{row['SHORT_LONG_IN']}', '{row['CLIENT_OCCUP_DESC']}'"
        sql_line2 = f"VALUES ({values_to_insert});"        
    elif "DELETE" in sql_line1:
        sql_line2 = f"WHERE CLIENT_OCC_TYPE_CD = '{row['CLIENT_OCC_TYPE_CD']} ' AND CLIENT_OCC_CD = '{row['CLIENT_OCC_CD']}' AND HSB_OCC_CD = '{row['HSB_OCC_CD']}' AND SHORT_LONG_IN = '{row['SHORT_LONG_IN']}';"

    lines = []
    while len(sql_line2) > 72:
        lines.append(sql_line2[:69]) # write data till 72nd column
        sql_line2 = sql_line2[69:]
    lines.append(sql_line2)
    sql_line2 = "'||\n'".join(lines)
    # print('sql_line2:', sql_line2) 
    query = '\n'.join([sql_line1, sql_line2])
    return query.upper()



counter = 0
column_map_dict = {"Client_Occ_type_cd": "CLIENT_OCC_TYPE_CD",
                        "Client_occ_cd": "CLIENT_OCC_CD",
                        "HSB_Occ_cd": "HSB_OCC_CD",
                        "Ranking_cd": "RANKING_CD",
                        "Short_Long_IN": "SHORT_LONG_IN",
                        "Client_Occ_Description": "CLIENT_OCCUP_DESC"
                        }
my_sheet = 'CC0013'
del_sql1 = "DELETE FROM LMPLCSSA.CLIENT_OCCUP_CD"
ins_sql1 = "INSERT INTO LMPLCSSA.CLIENT_OCCUP_CD"
# Specify the path to your excel file
file_path = r'C:\Users\ny4007991\OneDrive - Munich Re\Professional\Technology\Updated ERIE Mapping EB and Cyber.xlsx'



# Read the Excel file
df = pd.read_excel(file_path,sheet_name=my_sheet,dtype=str)
df = pre_processing(df,column_map_dict)
# Filter out rows that contain single quotes
df = df[df['CLIENT_OCCUP_DESC'].str.contains("'", na=False)]
print(df)
print(df.size)


queries = []    
for index, row in df.iterrows():
    query = gen_query(row,ins_sql1)
    queries.append(query)


with open('output.txt', 'w') as f:
    for query in queries:
        f.write(query + '\n')
