#!/bin/sh

# インプットメソッド環境変数
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# LANG（ロケール）も必要なら
export LANG=ja_JP.UTF-8

# fcitx をバックグラウンドで起動
fcitx &


# enable dbus
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && command -v dbus-launch >/dev/null; then
    eval "$(dbus-launch --sh-syntax)"
fi


# 少しだけ待ってから Fluxbox 起動
$HOME/.fehbg &
sleep 1
exec startfluxbox


