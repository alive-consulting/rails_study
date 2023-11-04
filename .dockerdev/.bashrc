# プロンプトを水色に変更
export PS1="\[\e[0;36m\]$PS1\[\e[m\]"

# エイリアスとしてllコマンドを設定
alias ll='ls -al'

# 不要なキーバインドを削除
if [[ -t 0 ]]; then
  stty stop undef  # Ctrl+S (これによりCtrl+Sでi-searchが有効に)
  stty start undef # Ctrl+Q
fi

# デプロイ用に、SSHエージェントを起動しgithubの秘密鍵を登録
eval `ssh-agent` &>/dev/null
ssh-add /root/.ssh/github &>/dev/null

# アプリ環境変数読込
set -a # .envの環境変数を全てexport
source .env
set +a

# Rustのセットアップ
. "$HOME/.cargo/env"

