Title:Twitter自動投稿あれこれ
Date: 2019.04.14
Tags: python
Slug: twitter_automation
Author: 川崎
Summary:

突如TwitterのBotを作ってみたくなり試行錯誤した結果をまとめてみました。

<h2>☆きっかけ</h2>

<ol>
    <li>講義棟の音出し禁止時間を毎日6時に通知してくれるBOTが欲しい。</li>
    <li>幸い音出し禁止時間はネット上に記載されているので、毎日取得して呟くだけなら実装は簡単そう。</li>
    <li>何よりPython会の記事のネタになる。</li>
</ol>

<h2>☆Twitter APIの取得</h2>

Botを作るにはAPI （アプリケーション・プログラミング・インタフェイス）が必要です。

まあアカウント作ったら一発やろーと高を括っていたのですが、最近Twitter APIの使用申請が厳格化されたらしくなんだか不安。

https://developer.twitter.com/

とりあえずここにアクセスし、利用登録を進めていきます。

慣れない英語を読みすすめるとどうやら必要なのが

・使用用途を英語で入力(400字程度)

大学入試以来の英作文です。

しかしそんな英語力は無いので適当に文章作ってGoogle翻訳(https://translate.google.co.jp/?hl=ja)にぶち込みます。小学生並みの文章が出来上がりました。

<em>1.I decided to use the Twitter API to study programming.In order to know what many people are interested in, I would like to learn what kind of program to write. 2....</em>

若干嘘が混じっている気もしますが気にしません。早速フォームに入力して送信しました。

なお事前に調べた情報ではここでTwitter社からなかなか返信が返って来ず断念するケースが多いみたいです。緊張します。

しかしドキドキする間もなく一瞬で申請が通りました。どうしてでしょうか。

実は「chat bot」など自動化に関する単語が含まれていると検閲に引っかかりやすいらしく、婉曲表現を用いて危険なワードを巧みに回避していたのでした。下調べは大切ですね。

晴れて使用権限を得たので早速使っていきます。BOT作成に必要な値は次の4つです。ログインすれば見ることができます。

<table>
<tbody>
<tr>
<td width="602">CONSUMER_KEY = "***********************************************"
CONSUMER_SECRET = "********************************************"
ACCESS_TOKEN = "**********************************************"
ACCESS_TOKEN_SECRET = "******************************************"</td>
</tr>
</tbody>
</table>

上のようにしてconfig.pyとしてまとめておくと後々楽です。

<h2>☆書く</h2>

事前にpip install requestsとpip install requests_oauthlibしておきます。

先ほど取得した4つのKeyはconfig.pyとして同じ階層に忘れずに置いておきます。

内容は1.取ってきて 2.整形して 3.ツイートする という流れです。シンプルですね。

<table>
<tbody>
<tr>
<td width="602">import requests　#スクレイピング
import json, config #jsonモジュールとconfig.pyの読み込み
from requests_oauthlib import OAuth1Session #OAuthのライブラリの読み込みURL = "hoge"
UserAgent = "huga"

headers = {"User-Agent": UserAgent}
s = requests.Session()
resp = s.get(URL, timeout=10, headers=headers) #HTML取得

lines = resp.text.split("\n")

(中略)(HTMLから整形する作業)

CK = config.CONSUMER_KEY
CS = config.CONSUMER_SECRET
AT = config.ACCESS_TOKEN
ATS = config.ACCESS_TOKEN_SECRET
twitter = OAuth1Session(CK, CS, AT, ATS) #認証処理

url = "https://api.twitter.com/1.1/statuses/update.json"

tweet = u"おはようッピ！\n{}月{}日({})の音出し禁止時間をお知らせするッピ！\n\n『{}』\n\n今日も一日がんばるッピ！！".format(m,d,w,notify)

params = {"status" : tweet}

res = twitter.post(url, params = params) #post送信
#print(tweet) #テスト表示

if res.status_code == 200: #成功した場合
print("Success.")
else:
print("Failed. : %d"% res.status_code)</td>
</tr>
</tbody>
</table>

<h2>☆実行結果</h2>

<img class="alignnone size-full wp-image-458" src="https://pythonoum.files.wordpress.com/2019/01/picture1.png" alt="picture1" width="939" height="527" />

成功です。語尾は適当です。

(この後自動投稿するまでの流れがありますが締め切りが来てしまったので一旦提出します。)
