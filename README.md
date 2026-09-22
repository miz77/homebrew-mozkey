非公式 macOS 向け配布。

```sh
brew install --cask miz77/mozkey/mozkey
```


既存の Mozc は置き換わります。インストーラはログイン中ユーザーの Mozc 関連プロセスと
`llama-server` を名前で終了するため、別用途で使っている場合も影響します。

導入後は再ログインが必要です。その後、システム設定 > キーボード > 入力ソースより Mozkey を追加してください。

更新前に設定・ユーザー辞書・学習データをバックアップし、入力ソースをABCなどへ切り替えてください。

```sh
brew update
brew upgrade --cask miz77/mozkey/mozkey
```

過去版ではApple Siliconでインストール、日本語入力、更新、削除・再導入を確認しています。
各新版の検証結果は [Releaseの説明](https://github.com/miz77/mozkey/releases) を参照してください。
IntelでのGUI入力と多日間の安定性は未検証です。
