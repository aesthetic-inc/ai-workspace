# マルチデバイス開発ガイド

## 概要

このガイドでは、複数のデバイス間で開発環境を同期する方法を説明します。

---

## 初回セットアップ（新しいデバイス）

このリポジトリは非公開です。ファイルの取得には GitHub CLI（`gh`）のログインが必要です。

### 0. GitHub CLI でログイン（初回だけ）

```bash
brew install gh        # 未インストールの場合
gh auth login          # aesthetic-inc にアクセスできるアカウントで
gh auth setup-git      # git clone / pull でもこのログインを使う
```

### 1. 全プロジェクトをクローン

```bash
gh api repos/aesthetic-inc/ai-workspace/contents/bootstrap.sh -H "Accept: application/vnd.github.raw" | bash
```

### 2. sync.shをダウンロード

```bash
mkdir -p ~/dev
gh api repos/aesthetic-inc/ai-workspace/contents/sync.sh -H "Accept: application/vnd.github.raw" > ~/dev/sync.sh
chmod +x ~/dev/sync.sh
```

### 3. 環境変数を設定

`.env.local` ファイルは手動で復元が必要です（セキュリティのためGitHubにはpushしていません）。

**space-rental-platform用**:
```bash
cp ~/dev/space-rental-platform/.env.example ~/dev/space-rental-platform/.env.local
# その後、実際の値を設定
```

### 4. 依存関係をインストール

```bash
cd ~/dev/space-rental-platform && npm install
cd ~/dev/ai-workspace && npm install
```

---

## 日常のワークフロー

### 作業開始時

```bash
~/dev/sync.sh pull
# または
~/dev/sync.sh  # pullがデフォルト
```

### 作業終了時

```bash
~/dev/sync.sh push
```

### 状態確認

```bash
~/dev/sync.sh status
```

---

## コマンド一覧

| コマンド | 説明 |
|----------|------|
| `~/dev/sync.sh pull` | 全プロジェクトの最新を取得 |
| `~/dev/sync.sh push` | 変更のある全プロジェクトをpush |
| `~/dev/sync.sh status` | 全プロジェクトの状態を確認 |

---

## プロジェクト一覧

| プロジェクト | 説明 | GitHub |
|-------------|------|--------|
| ai-workspace | AI開発ワークスペース | PUBLIC |
| space-rental-platform | スペースレンタルプラットフォーム | PRIVATE |
| chatgpt-export | ChatGPTエクスポートツール | PRIVATE |
| mf-cloud-auth | MoneyForwardクラウド認証 | PRIVATE |
| clawd | AIエージェント設定 | PRIVATE |

---

## トラブルシューティング

### コンフリクトが発生した場合

```bash
cd ~/dev/[プロジェクト名]
git status
git stash        # 一時的に変更を退避
git pull
git stash pop    # 変更を復元
# コンフリクトを解決してコミット
```

### 強制的にリモートに合わせる場合

```bash
cd ~/dev/[プロジェクト名]
git fetch origin
git reset --hard origin/main
```

---

## 環境変数の管理

`.env.local` はGitHubにpushされません。以下のいずれかで管理してください：

1. **1Password** - セキュアノートとして保存
2. **iCloudメモ** - ロック付きメモに保存
3. **暗号化ファイル** - `gpg -c` で暗号化

---

*最終更新: 2026-01-28*
