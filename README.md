# sns_stopper
SNS利用を禁じるスクリプト。

# Environment
- Mac OS
- Homebrewによってインストールされたdnsmasq
- jqコマンド
- Google chrome
  - [chromeのsiteblock拡張](https://chrome.google.com/webstore/detail/siteblock/pfglnpdpgmecffbejlfgpnebopinlclj?hl=ja)

# 何をするものなのか
![dnsmasq図](http://www.plantuml.com/plantuml/svg/SoWkIImgAStDuIf8JCvEJ4zLK0fmLbAevb9GW0auPnJbvwQ2X80WEZYp9DKf9pyvEnR8h-K2YUG05JeM5CI2EFgf9SdwHQd5-JbbgKMn2ed52Z0EI3ObhpWtiRWmbgkMYolwoUxTprhw7pUkUzoqzN7JaiVD7M3rnK0B3BcYdxSiVDgryt7ZAanP8wve5x_WM2w8pK0wf3opf0He7HSNt7KAkhfs4ADGnH3EWJaRLHJ608j2dSi5fU5c6g4g0pg62uZ1RB2fS1xKOLmEgNafm3060000.svg)

上図の `/etc/resolver` と `SiteBlock` を制御するものです
- 各SNS用のApplicationがSNSのサイトにたどり着けないよう、dnsmasqによって行き先をすり替えます（127.0.0.1に向けます）
- Chromeのsiteblock拡張を制御し、ブラウジング時にSNSにアクセスできないようにします
- SNSの利用が必要な場合には時間制限をつけつつ許可を行うことができます

# Setup
1. Environmentが要求するものをインストールしておきます
1. Google chromeを終了しておきます
1. `sudo ./sns_stopper init` を実行します
1. 下記の例を参考に `settings.json.tmp` から `settings.json` をsns_stopperプロジェクト直下に作成します

```json
{
  "extensionOptionUrl": "chrome-extension://mackolfpcjdnngofjhoklekgeloifkom/html/options.html", // SiteBlockのオプション画面のURLを入力する。
  "targetDomains": [ // 制限したいSNSのドメインを指定する。サブドメインも制限するため、例えばtwitter.comを指定した場合、tweetdeck.twitter.comも制限される。
    "slack.com",
    "twitter.com",
    "facebook.com",
    "discordapp.com"
  ],
  "apps": [ // Macで動作しているアプリケーション名。
    "Discord",
    "Slack",
    "TweetDeck"
  ]
}

```

# 使い方
利用を制限する場合
```
sudo ./sns_stopper forbid
```

利用を許可する場合
```
sudo ./sns_stopper permit 5 # 指定した分数だけ許可する。この場合は5分。
```

利用を永続的に許可する場合
```
sudo ./sns_stopper permit nolimit
```
