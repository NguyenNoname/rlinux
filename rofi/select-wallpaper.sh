#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers"

# Kiểm tra thư mục
if [ ! -d "$WALL_DIR" ]; then
    notify-send "Wallpaper Error" "Thư mục $WALL_DIR không tồn tại!"
    exit 1
fi

# Quét tất cả file ảnh bằng find
MENU=""
while IFS= read -r img; do
    [ -n "$img" ] || continue
    filename=$(basename "$img")
    MENU="${MENU}${filename}\0icon\x1f${img}\n"
done < <(find "$WALL_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.webp" \))

# Báo lỗi nếu thư mục không có ảnh
if [ -z "$MENU" ]; then
    notify-send "Wallpaper Error" "Không tìm thấy file ảnh nào trong $WALL_DIR"
    exit 1
fi

# Gọi Rofi
SELECTED=$(echo -e -n "$MENU" | rofi -dmenu -show-icons -p "󰸉 Chọn ảnh nền" -config ~/.config/rofi/config.rasi)

# Đổi wallpaper bằng awww
if [ -n "$SELECTED" ]; then
    awww img "$WALL_DIR/$SELECTED" --transition-type grow --transition-pos center
fi
