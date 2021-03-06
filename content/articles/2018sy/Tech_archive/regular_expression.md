Title:pythonで使える正規表現まとめ
Date: 2019.04.14
Tags: python
Slug: regular_expression
Author: 西垣
Summary:

O'REILLYの著書で「正規表現」について記載されているところをまとめたノートです。
正規表現はCtrl-Fのテキスト検索でも気軽に使えて大変便利なので、以下のまとめはpython3での正規表現の初歩的な使い方をまとめたものですが、知らなかった人は見てみてもいいかもです。

要点
・?は、直前のグループの0回か1回の出現にマッチする。（任意のマッチ）
・<em>は、直前のグループの0回以上の出現にマッチする。
・+は、直前のグループの1回以上の出現にマッチする。
・{n}は、直前のグループのn回の出現にマッチする。
・{n,}は、直前のグループのn回以上の出現にマッチする。
・{,m}は、直前のグループの0~m回の出現にマッチする。
・{n,m}?、</em>?、+?は直前のグループの非貪欲マッチを行う。

▶文字集合
\d：0~9の数字
\D：0~9の数字以外
\w：文字、数字、下線（単語wordのw）
\W：文字、数字、下線以外
\s：スペース、タブ、改行（空白spaceのs）
\S：スペース、タブ、改行以外

▶正規表現マッチのまとめ
・reモジュール
・re.compile()関数
・search()メソッド
・group()メソッド
・findall()メソッド

実践

<pre>In [1]:
#! python 3
#正規表現モジュールのインポート
import re</pre>

<pre>In [2]:
#'\d'は1文字の数字を表す正規表現
#'\d'を用いて、あるtextから、電話番号パターンにマッチする部分を検索しましょう。
#re.compile()に正規表現パターンを表す文字列を渡すと、Regexオブジェクトが返る

phone_num_regex = re.compile(r'\d\d\d-\d\d\d\d-\d\d\d\d')

#文字列の前のrはraw文字列を指定し、文字をエスケープせずに簡潔に表現しています</pre>

<pre>In [3]:
#Regexオブジェクトのsearch()メソッドは、渡された文字列の中から正規表現にマッチするパターンが見つかれば、Matchオブジェクトを返します。
#Matchオブジェクトにはgroup()メソッドがあり、実際にマッチしたテキストを返します

mo = phone_num_regex.search('私の電話番号は080-1111-22222です。')
print('電話番号が見つかりました：' + mo.group())
電話番号が見つかりました：080-1111-2222
</pre>

<pre>In [4]:
#'()'を用いたグルーピング

phone_num_regex = re.compile(r'(\d\d\d)-(\d\d\d\d-\d\d\d\d)')
mo = phone_num_regex.search('私の電話番号は080-1000-2000です。')
</pre>

<pre>In [5]:
mo.group(1)
Out[5]:
'080'</pre>

<pre>In [6]:
mo.group(2)
Out[6]:
'1000-2000'
</pre>

<pre>In [7]:
mo.group(0)
Out[7]:
'080-1000-2000'</pre>

<pre>In [8]:
mo.groups()
Out[8]:
('080', '1000-2000')
</pre>

<pre>In [15]:
#'|'を使って複数のグループとマッチする。
#"r'Batman|Spiderman'"という正規表現は、'Batman'or'Spiderman'にマッチします。

hero_regex = re.compile(r'Batman|Spiderman')
mo1 = hero_regex.search('Batman and Yasmizuman')
mo1.group()
Out[15]:
'Batman'</pre>

<pre>In [16]:
#両方ある場合は最初に出現したほうが返ります。

mo2 = hero_regex.search('The Spiderman fights Batman and Yasumizuman')
mo2.group()
Out[16]:
'Spiderman'</pre>

<pre>In [19]:
#丸カッコと縦線とを応用

yasumizu_regex = re.compile(r'Yasumizu(man|woman|hotel)')
mo = yasumizu_regex.search('Yasumizuman lost his way back to Yasumizuhotel.')
mo.group(1)
Out[19]:
'man'</pre>

<pre>In [20]:
#'?'を用いた任意のマッチ

yasu_regex = re.compile(r'Yasumizu(wo)?man')
mo1 = yasu_regex.search('The Adveture of Yasumizuman')
mo1.group()
Out[20]:
'Yasumizuman'
</pre>

<pre>In [21]:
mo2 = yasu_regex.search('The Adveture of Yasumizuwoman')
mo2.group()
Out[21]:
'Yasumizuwoman'
</pre>

<pre>In [22]:
#'*'を用いた0回以上のマッチ

yasu_regex = re.compile(r'Yasu(mi)*zu')
mo1 = yasu_regex.search('The Adventure of Yasuzu')
mo1.group()
Out[22]:
'Yasuzu'
</pre>

<pre>In [24]:
mo2 = yasu_regex.search('The Adventure of Yasumimimimimimimizu')
mo2.group()
Out[24]:
'Yasumimimimimimimizu'
</pre>

<pre>In [26]:
#'+'を用いた1回以上のマッチ

yasu_regex = re.compile(r'Yasu(mi)+zu')
mo1 = yasu_regex.search('The Adventure of Yasumimimimimizu')
mo1.group()
Out[26]:
'Yasumimimimimizu'
</pre>

<pre>In [28]:
mo2 = yasu_regex.search('The Adventure of Yasuzu')
mo2 == None
Out[28]:
True</pre>

<pre>In [30]:
#'{}'を用いて繰り返し回数を指定する
#(Ha){3} = (HaHaHa) , (Ha){3,5} = (HaHaHa|HaHaHaHa|HaHaHaHaHa)

ha_regex = re.compile(r'(Ha){3,5}')
mo1 = ha_regex.search('HaHaHaHaHa')
mo1.group()
Out[30]:
'HaHaHaHaHa'
</pre>

<pre>In [34]:
mo2 = ha_regex.search('Ha')
mo2 == None
Out[34]:
True</pre>

<pre>In [35]:
#貪欲マッチ：ジャガビーは一番長いものをとる
#Pythonの正規表現は、デフォルトでは貪欲マッチです。つまり、複数の可能性があると最も長い方にマッチします。

greedy_Ha_regex = re.compile(r'(Ha){3,5}')
mo1 = greedy_Ha_regex.search('HaHaHaHaHaHaHaHaHaHaHa')
mo1.group()
Out[35]:
'HaHaHaHaHa'</pre>

<pre>In [36]:
#非貪欲マッチ：遠慮して一番短いものをとる
#閉じカッコの後に'?'

nongreedy_Ha_regex = re.compile(r'(Ha){3,5}?')
mo2 = nongreedy_Ha_regex.search('HaHaHaHaHaHaHaHaHaHaHa')
mo2.group()
Out[36]:
'HaHaHa'</pre>

<pre>In [38]:
#findall()メソッド
#search()が最初に見つかった文字列を返すのに対し、findall()は見つかったすべての文字列を返します。
#findall()はタプルのリストを返すことに注意
phone_num_regex = re.compile(r'\d\d\d-\d\d\d\d-\d\d\d\d')
phone_num_regex.findall('Cell: 415-5555-9999 Work: 212-5555-0000')
Out[38]:
['415-5555-9999', '212-5555-0000']
</pre>

<pre>In [39]:
phone_num_regex = re.compile(r'(\d\d\d)-(\d\d\d\d)-(\d\d\d\d)')
phone_num_regex.findall('Cell: 415-5555-9999 Work: 212-5555-0000')
Out[39]:
[('415', '5555', '9999'), ('212', '5555', '0000')]
</pre>

続きはありますが、あまり出しすぎるとネタが無くなるので、今回はここまでにしておきます。
また書きます。

↑をうまく利用して、自分で電子メールアドレスの正規表現を作ってみてもおもしろいと思います。

正規表現について、さらに詳しく↓

<a href="https://docs.python.jp/3/library/re.html">6.2. re — 正規表現操作 — Python 3.6.3 ドキュメント</a>
6.2.1. 正規表現のシンタックス ¶ (原文) 正規表現 (すなわち RE) は、表現にマッチ (match) する文字列の集合を表しています。このモジュールの関数を使えば、ある文字列が指定の正規表現にマッチするか (または指定の正規表現がある文字列にマッチするか、つまりは同じことですが) を検査できます。 正規表現を連結すると新しい正規表現を作れます。 A と B がともに正規表現であれば AB も正規表現です。一般的に、文字列 p が A とマッチし、別の文字列 q が B とマッチすれば、文字列 pq は AB にマッチします。ただし、この状況が成り立つのは、 A と B との間に境界条件がある場合や、番号付けされたグループ参照のような、優先度の低い演算を A や B が含まない場合だけです。かくして、ここで述べるような、より簡単でプリミティブな正規表現から、複雑な正規表現を容易に構築できます。正規表現に関する理論と実装の詳細については上記の Friedl 本か、コンパイラの構築に関する教科書を調べて下さい。 以下で正規表現の形式に関する簡単な説明をしておきます。より詳細な...

<a href="https://qiita.com/dongri/items/2a0a18e253eb5bf9edba">よく使う正規表現はもうググりたくない！ - Qiita</a>
タイトル通りによく使う正規表現を毎回ググるのが効率悪いのでまとめてみました。各言語で正規表現のサンプルを書いてみました。 # 正規表現式 * Emailアドレス `^\w+([-+.]\w+)<em>@\w+([-.]\w+)</em>.\w...
