require 'tk'

button = TkButton.new   ### TkButtonというRuby/Tkのウィジェットをインスタンス化。
button.text = 'exit' ### ボタンに表示するテキストを設定
button.command = proc { exit }   ### ボタンが押されたときに終了する
button.pack   ### ボタンをウインドウにパッキングする(ウインドウにボタンを載せる)

Tk.mainloop ### Tkのメインループを実行