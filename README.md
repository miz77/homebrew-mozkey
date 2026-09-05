非公式 macOS 向け配布。

```sh
brew tap miz77/mozkey
brew install --cask miz77/mozkey/mozkey
```


既存の Mozc は置き換わります。インストーラはログイン中ユーザーの Mozc 関連プロセスと
`llama-server` を名前で終了するため、別用途で使っている場合も影響します。

導入後は再ログインが必要です。その後、システム設定 > キーボード > 入力ソースより Mozkey を追加してください。
