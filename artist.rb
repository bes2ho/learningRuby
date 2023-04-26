# Artist ID からAlbum、ID　一覧取得
require 'rspotify'
require 'open-uri'

#結果を日本語で取得するために設定しています。
# ENV['ACCEPT_LANGUAGE'] = "ja"
client_id = '867b44de07d8409ab56d3e5dbbdb1931'
client_secret = 'd4b39a519c90446e87a38c4015a1806b'
#実際に実行する場合には、第一引数にクライアントID, 第二引数にクライアントシークレットを入れてください。
RSpotify.authenticate(client_id, client_secret)

artist_id = ARGV[0]
artist = RSpotify::Artist.find(artist_id)
# puts artist.genres # => ["anime", "j-pop", "j-poprock"]
for album in artist.albums
    puts sprintf("%s\t%s", album.name, album.id)
end
