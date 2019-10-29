```python
import pandas as pd
import numpy as np
import re
from collections import Counter
import nltk
from textblob import TextBlob
nltk.download('wordnet')
nltk.download('punkt')
from nltk.stem import WordNetLemmatizer 
```

    [nltk_data] Downloading package wordnet to
    [nltk_data]     C:\Users\justf\AppData\Roaming\nltk_data...
    [nltk_data]   Package wordnet is already up-to-date!
    [nltk_data] Downloading package punkt to
    [nltk_data]     C:\Users\justf\AppData\Roaming\nltk_data...
    [nltk_data]   Package punkt is already up-to-date!
    

## 2.


```python
data = pd.read_csv("tweets.csv", encoding='utf-8')
lemma_array = []
lemmatizer = WordNetLemmatizer()
polarity = []
lem_polarity = []
subjectivity = []
lem_subjetivity = []
```

## 3.


```python
new_data = data.replace(to_replace='[^\sa-zA-Z0-9]@', value = "", regex=True)
```


```python
final_data = new_data.replace(to_replace='RT', value="", regex=True)
```


```python
final_data.rename(columns={'screenName':'Handler'}, inplace=True)
final_data['Handler'] = final_data['Handler'].replace(to_replace='[^\sa-zA-Z0-9]', value='', regex=True)
```


```python
final_data['statusSource'] = final_data['statusSource'].replace('<.*?>', value='', regex=True)
```


```python
final_data.rename(columns={'statusSource':'Source'}, inplace=True)
final_data['Handler'] = '@' + final_data['Handler'].astype(str)
```

## 5.


```python
def ligma(lemma, lemma_array):
    word_list = nltk.word_tokenize(lemma)
    lemmatized_output = ' '.join([lemmatizer.lemmatize(w) for w in word_list])
    lemma_array.append(lemmatized_output)
    
```


```python
for x in final_data['text']:
    ligma(x, lemma_array)
final_data['lem_text'] = lemma_array
```


```python
final_data = final_data.sort_values(by=['Handler'])
```

## 4.


```python
sub_data = pd.DataFrame({'Handler':final_data['Handler'], 'retweetCount':final_data['retweetCount'], 'Source':final_data['Source'], 'Text':final_data['text'], 'Lem_text':final_data['lem_text']})
```


```python
sub_data
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Handler</th>
      <th>retweetCount</th>
      <th>Source</th>
      <th>Text</th>
      <th>Lem_text</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>182</td>
      <td>@0123Steven77</td>
      <td>39</td>
      <td>Twitter for Android</td>
      <td>@PapaSmithy: Very interesting to see how Grif...</td>
      <td>@ PapaSmithy : Very interesting to see how Gri...</td>
    </tr>
    <tr>
      <td>602</td>
      <td>@0123Steven77</td>
      <td>134</td>
      <td>Twitter for Android</td>
      <td>@lolesports: The 2019 World Championship Quar...</td>
      <td>@ lolesports : The 2019 World Championship Qua...</td>
    </tr>
    <tr>
      <td>603</td>
      <td>@0123Steven77</td>
      <td>118</td>
      <td>Twitter for Android</td>
      <td>@lolesports: No perfect predictions for the f...</td>
      <td>@ lolesports : No perfect prediction for the f...</td>
    </tr>
    <tr>
      <td>9003</td>
      <td>@0Trashcan2</td>
      <td>0</td>
      <td>Twitter for Android</td>
      <td>Doesn't seem like Fnatic have any sort of game...</td>
      <td>Does n't seem like Fnatic have any sort of gam...</td>
    </tr>
    <tr>
      <td>7795</td>
      <td>@0eixa</td>
      <td>145</td>
      <td>Twitter for Android</td>
      <td>@lolesports: The Garen hover from @RekklesLoL...</td>
      <td>@ lolesports : The Garen hover from @ RekklesL...</td>
    </tr>
    <tr>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <td>5192</td>
      <td>@zynerva</td>
      <td>126</td>
      <td>Twitter for Android</td>
      <td>@aliciaouteiralf: Fnatic: pierde 2 partidos i...</td>
      <td>@ aliciaouteiralf : Fnatic : pierde 2 partidos...</td>
    </tr>
    <tr>
      <td>4911</td>
      <td>@zyranugu</td>
      <td>15</td>
      <td>Twitter Web App</td>
      <td>@HajinsunTV: FPX Tian just said during the pr...</td>
      <td>@ HajinsunTV : FPX Tian just said during the p...</td>
    </tr>
    <tr>
      <td>6271</td>
      <td>@zyrcadia</td>
      <td>0</td>
      <td>Twitter Web App</td>
      <td>@FNATIC ggs guys. y'all tried. was a rough one...</td>
      <td>@ FNATIC ggs guy . y'all tried . wa a rough on...</td>
    </tr>
    <tr>
      <td>808</td>
      <td>@zzzzmoore27</td>
      <td>20</td>
      <td>Twitter Web App</td>
      <td>@HextechThinker: Hey Fnatic, what have we lea...</td>
      <td>@ HextechThinker : Hey Fnatic , what have we l...</td>
    </tr>
    <tr>
      <td>3554</td>
      <td>@zzzzmoore27</td>
      <td>3</td>
      <td>Twitter Web App</td>
      <td>@Elynescence_: DID QIYANA JUST TAKE 90% HEALT...</td>
      <td>@ Elynescence_ : DID QIYANA JUST TAKE 90 % HEA...</td>
    </tr>
  </tbody>
</table>
<p>10000 rows × 5 columns</p>
</div>



## 6.


```python
for tw in sub_data['Text']:
  tw = TextBlob(tw)
  ann = tw.sentiment
  polarity.append(ann[0])
  subjectivity.append(ann[1])
```


```python
for tw in sub_data['Lem_text']:
  tw = TextBlob(tw)
  ann = tw.sentiment
  lem_polarity.append(ann[0])
  lem_subjetivity.append(ann[1])
```


```python
sub_data['Polarity'] = polarity
sub_data['Subjectivity'] = subjectivity
sub_data['Lem_Polarity'] = lem_polarity
sub_data['Lem_Subjectivity'] = lem_subjetivity
```


```python
sub_data
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Handler</th>
      <th>retweetCount</th>
      <th>Source</th>
      <th>Text</th>
      <th>Lem_text</th>
      <th>Polarity</th>
      <th>Subjectivity</th>
      <th>Lem_Polarity</th>
      <th>Lem_Subjectivity</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>182</td>
      <td>@0123Steven77</td>
      <td>39</td>
      <td>Twitter for Android</td>
      <td>@PapaSmithy: Very interesting to see how Grif...</td>
      <td>@ PapaSmithy : Very interesting to see how Gri...</td>
      <td>0.375000</td>
      <td>0.516667</td>
      <td>0.375000</td>
      <td>0.516667</td>
    </tr>
    <tr>
      <td>602</td>
      <td>@0123Steven77</td>
      <td>134</td>
      <td>Twitter for Android</td>
      <td>@lolesports: The 2019 World Championship Quar...</td>
      <td>@ lolesports : The 2019 World Championship Qua...</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <td>603</td>
      <td>@0123Steven77</td>
      <td>118</td>
      <td>Twitter for Android</td>
      <td>@lolesports: No perfect predictions for the f...</td>
      <td>@ lolesports : No perfect prediction for the f...</td>
      <td>-0.125000</td>
      <td>0.666667</td>
      <td>-0.125000</td>
      <td>0.666667</td>
    </tr>
    <tr>
      <td>9003</td>
      <td>@0Trashcan2</td>
      <td>0</td>
      <td>Twitter for Android</td>
      <td>Doesn't seem like Fnatic have any sort of game...</td>
      <td>Does n't seem like Fnatic have any sort of gam...</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <td>7795</td>
      <td>@0eixa</td>
      <td>145</td>
      <td>Twitter for Android</td>
      <td>@lolesports: The Garen hover from @RekklesLoL...</td>
      <td>@ lolesports : The Garen hover from @ RekklesL...</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <td>5192</td>
      <td>@zynerva</td>
      <td>126</td>
      <td>Twitter for Android</td>
      <td>@aliciaouteiralf: Fnatic: pierde 2 partidos i...</td>
      <td>@ aliciaouteiralf : Fnatic : pierde 2 partidos...</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <td>4911</td>
      <td>@zyranugu</td>
      <td>15</td>
      <td>Twitter Web App</td>
      <td>@HajinsunTV: FPX Tian just said during the pr...</td>
      <td>@ HajinsunTV : FPX Tian just said during the p...</td>
      <td>0.343750</td>
      <td>0.493750</td>
      <td>0.343750</td>
      <td>0.493750</td>
    </tr>
    <tr>
      <td>6271</td>
      <td>@zyrcadia</td>
      <td>0</td>
      <td>Twitter Web App</td>
      <td>@FNATIC ggs guys. y'all tried. was a rough one...</td>
      <td>@ FNATIC ggs guy . y'all tried . wa a rough on...</td>
      <td>-0.216667</td>
      <td>0.450000</td>
      <td>-0.216667</td>
      <td>0.450000</td>
    </tr>
    <tr>
      <td>808</td>
      <td>@zzzzmoore27</td>
      <td>20</td>
      <td>Twitter Web App</td>
      <td>@HextechThinker: Hey Fnatic, what have we lea...</td>
      <td>@ HextechThinker : Hey Fnatic , what have we l...</td>
      <td>0.100000</td>
      <td>1.000000</td>
      <td>0.100000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <td>3554</td>
      <td>@zzzzmoore27</td>
      <td>3</td>
      <td>Twitter Web App</td>
      <td>@Elynescence_: DID QIYANA JUST TAKE 90% HEALT...</td>
      <td>@ Elynescence_ : DID QIYANA JUST TAKE 90 % HEA...</td>
      <td>-0.250000</td>
      <td>0.500000</td>
      <td>-0.250000</td>
      <td>0.500000</td>
    </tr>
  </tbody>
</table>
<p>10000 rows × 9 columns</p>
</div>



## 7.


```python
rows = ['Polarity', 'Subjectivity', 'Lem_Polarity', 'Lem_Subjectivity']

for i in rows:
    print(sub_data[i].mean())
```

    0.07441329728084317
    0.27430918216736944
    0.07420374701629287
    0.27494183659858634
    

## 8.

#### La lematización afecta muy poco la evalución de polaridad y subjetividad


```python
sub_data['Source'].value_counts().head()
```




    Twitter for Android    5063
    Twitter Web App        2539
    Twitter for iPhone     1862
    TweetDeck               247
    Twitter Web Client      127
    Name: Source, dtype: int64



## 9.

#### La mayoría de tweets se originan de Twitter for Android


```python
sub_data.sort_values(by=['retweetCount'], inplace=True, ascending=False)
```


```python
sub_data.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Handler</th>
      <th>retweetCount</th>
      <th>Source</th>
      <th>Text</th>
      <th>Lem_text</th>
      <th>Polarity</th>
      <th>Subjectivity</th>
      <th>Lem_Polarity</th>
      <th>Lem_Subjectivity</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>9598</td>
      <td>@leonakali</td>
      <td>4470</td>
      <td>Twitter for iPhone</td>
      <td>@OGTVLoL: G2, FNATIC et Splyce durant ces #Wo...</td>
      <td>@ OGTVLoL : G2 , FNATIC et Splyce durant ce # ...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <td>3922</td>
      <td>@isuda74zem10</td>
      <td>3542</td>
      <td>Twitter for Android</td>
      <td>@T1LoL: Never intended, but here we go - good...</td>
      <td>@ T1LoL : Never intended , but here we go - go...</td>
      <td>0.7</td>
      <td>0.6</td>
      <td>0.7</td>
      <td>0.6</td>
    </tr>
    <tr>
      <td>3890</td>
      <td>@kledis25323538</td>
      <td>3139</td>
      <td>Twitter for Android</td>
      <td>@G2esports: Gear up for Worlds! \r\n\r\nTo ce...</td>
      <td>@ G2esports : Gear up for Worlds ! To celebrat...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <td>1552</td>
      <td>@zeynhrj</td>
      <td>2797</td>
      <td>Twitter for iPhone</td>
      <td>@Cloud9: G2 is looking really good\r\n\r\n#Wo...</td>
      <td>@ Cloud9 : G2 is looking really good # Worlds2...</td>
      <td>0.7</td>
      <td>0.6</td>
      <td>0.7</td>
      <td>0.6</td>
    </tr>
    <tr>
      <td>2314</td>
      <td>@Buji19</td>
      <td>2756</td>
      <td>Twitter Web App</td>
      <td>@OGTVLoL: Team Liquid, Clutch Gaming &amp;amp; Cl...</td>
      <td>@ OGTVLoL : Team Liquid , Clutch Gaming &amp; amp ...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
</div>



#### El tweet más popular del corpus es de @leonakali


```python

```
