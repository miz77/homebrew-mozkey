# MozKey 個人tap

本人と身内向けの非公式macOS配布。daily辞書とZenzを含む上流のPKGを使用します。
Developer ID署名・Appleの公証は行いません。

**初版はdraft準備中です。Release公開までは以下のインストールURLは利用できません。**

```sh
brew tap miz77/mozkey
brew install --cask miz77/mozkey/mozkey
```

macOS 12以降、Apple Silicon / Intel。管理者認証が必要です。
既存Mozcは置き換わります。インストーラはログイン中ユーザーのMozc関連プロセスと
`llama-server` を名前で終了するため、別用途で使っている場合も影響します。

導入後はシステム設定のキーボード・テキスト入力からMozcを追加してください。
必要に応じてログアウト・ログインします。未署名の許可手順は実機未検証です。

```sh
brew update
brew upgrade --cask miz77/mozkey/mozkey
brew uninstall --cask miz77/mozkey/mozkey
```

更新・削除前に入力ソースをABCへ切り替えてください。
ユーザー辞書・学習・設定を削除する `zap` は定義していません。
インストール・更新・削除・ユーザーデータ保持の実機試験は未実施です。

## メンテナンス

```sh
python3 scripts/update-cask.py --release-tag macos-v2026.09.06.1
brew style Casks/mozkey.rb
git diff
```

更新スクリプトは公開済みの `miz77/mozkey` の固定tagだけを取得し、
ZIPのhashと内部PKGのhashを検証します。pushは自動実行しません。
新規tapコードのライセンスはMITです。配布PKGには各同梱物のライセンスが適用されます。
