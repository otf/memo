# 📝 memo

メモする最小限のコマンド

```bash
memo 電球を買う
```

たったこれだけで、指定した内容を Notion に新規ページとして保存し、ブラウザで開きます。

![output](https://github.com/user-attachments/assets/e8654f4e-0349-4ad5-8761-86cc589d4e45)


---

## 🚀 インストール

[Nix](https://nixos.org/) を使っているなら、ワンライナーでインストールできます：

```bash
nix profile add github:otf/memo
```

---

## ✨ 特長

- 🧠 **Notion にワンコマンドでメモ**
- 💬 **初回のみ対話形式で設定完了**
- 🌐 **作成されたページは自動でブラウザで開く**
- 🪶 **依存最小、軽量シェルスクリプト**

---

## ⚙️ 初回セットアップ

初回実行時に以下の情報を聞かれます。 順に入力していくだけで設定が完了します！

1. 🔗
   [Notion Integration を作成](https://www.notion.so/profile/integrations/form/new-integration)
2. 🔑 **Internal Integration Token** を入力
3. 🗂️ **Notion データベース ID** を入力 URL 例:

   ```
   https://www.notion.so/workspace-name/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx（Notion データベース ID）?v=yyyyy
   ```

✅ 設定内容は `~/.config/memo/config` に保存され、2回目以降は自動で使われます。

---

## 🧪 使い方

```bash
memo 電球を買う
```

実行すると以下が自動で行われます：

1. Notion にタイトル「電球を買う」のページを作成
2. ブラウザでそのページを開く 🧭

---

## 📁 設定ファイルの場所

```
~/.config/memo/config
```

中身は以下のようになります：

```dotenv
NOTION_INTERNAL_SECRET=your-secret
NOTION_DATABASE_ID=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

💡 _アイデアや改善提案は Issues や PR でお気軽に！_

```
```
