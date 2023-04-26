require 'libui'

UI = LibUI

UI.init

# ウィンドウを作成
main_window = UI.new_window('hello world', 300, 50, 1)
# ×ボタンでウィンドウを消せるようにする
UI.window_on_closing(main_window) do
  puts 'Bye Bye'
  UI.control_destroy(main_window)
  UI.quit
  0
end

# 配置用のボックス
hbox = UI.new_horizontal_box
# ボックスをウィンドウに追加
UI.window_set_child(main_window, hbox)

# 入力欄の作成
entry = UI.new_entry
# 文字が入力されたターミナルに表示
UI.entry_on_changed(entry) do
  puts UI.entry_text(entry).to_s
  $stdout.flush # リアルタイムにターミナルに表示
end
# ボックスに追加
UI.box_append(hbox, entry, 1)

# ボタン
button = UI.new_button('Button')
# ボタンが押されたら、ダイアログを出す
UI.button_on_clicked(button) do
  text = UI.entry_text(entry).to_s
  UI.msg_box(main_window, '入力した文字は次の通りです', text)
  0
end
# ボックスに追加
UI.box_append(hbox, button, 0)

# ウインドウを表示
UI.control_show(main_window)
UI.main
UI.quit