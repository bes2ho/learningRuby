# coding: utf-8

require 'libui'

UI = LibUI

def main()

  UI.init

  # ウィンドウを作成
  main_window = UI.new_window('Sipmle Text Replace', 1000, 500, 0)
  # ×ボタンでウィンドウを消せるようにする
  UI.window_on_closing(main_window) do
    puts 'Close window'
    UI.control_destroy(main_window)
    UI.quit
    0
  end

  # 全体のbox
  box  = UI.new_vertical_box
  # 入力/結果用のbox
  box_inout = UI.new_vertical_box
  # 正規表現とボタン入れる用のbox
  box_regexp_button = UI.new_horizontal_box

  # 全体のboxに追加
  UI.box_append(box, box_regexp_button, 0)
  UI.box_append(box, box_inout, 1)

  # 全体のboxをウィンドウに追加
  UI.window_set_child(main_window, box)

  # 入力欄の作成
  entry_label = UI.new_label("テキスト")
  input_entry = UI.new_multiline_entry

  # 結果出力の領域
  result_label = UI.new_label("結果")
  result_entry  = UI.new_multiline_entry
  ## 結果なので入力できないようにする
  UI.multiline_entry_set_read_only(result_entry, 1)

  # 正規表現と置換文字列
  regexp_label = UI.new_label("正規表現")
  regexp_entry = UI.new_entry 
  replace_label = UI.new_label("置換文字列")
  replace_entry = UI.new_entry

  # 実行ボタン
  button = UI.new_button('実行')

  # クリアボタン
  clear_button = UI.new_button('クリア')

  # ボックスに追加
  UI.box_append(box_inout, entry_label, 0)
  UI.box_append(box_inout, input_entry, 1)
  UI.box_append(box_inout, result_label, 0)
  UI.box_append(box_inout, result_entry, 1)
  UI.box_append(box_regexp_button, regexp_label, 0)
  UI.box_append(box_regexp_button, regexp_entry, 1)
  UI.box_append(box_regexp_button, replace_label, 0)
  UI.box_append(box_regexp_button, replace_entry, 1)
  UI.box_append(box_regexp_button, button, 0)
  UI.box_append(box_regexp_button, clear_button, 0)

  # 実行ボタン押された
  UI.button_on_clicked(button) do
    text    = UI.multiline_entry_text(input_entry).to_s
    regexp  = UI.entry_text(regexp_entry).to_s
    replace = UI.entry_text(replace_entry).to_s
    if (text.empty? || regexp.empty? || replace.empty?)
      UI.msg_box(main_window, 'Error', "テキスト/正規表現/置換文字列のいずれかが入力されていません")
    else
      result  = replace(main_window, regexp, replace, text)
      UI.multiline_entry_set_text(result_entry, result)
    end
    0
  end

  # クリアボタン押された
  UI.button_on_clicked(clear_button) do
    UI.multiline_entry_set_text(input_entry, "")
    UI.entry_set_text(regexp_entry, "")
    UI.entry_set_text(replace_entry, "")
  end

  # ウインドウを表示
  UI.control_show(main_window)
  UI.main
  UI.quit
end

def replace(main_window, regexp, replace, text)
  result = ''
  begin
   result = text.gsub(/#{regexp}/, replace)
  rescue => e
   UI.msg_box(main_window, 'Error', e)
  end
  return result
end

main()