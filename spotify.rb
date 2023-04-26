# ruby spotify.rb 0:2 5ahEd7berYIgjRYsIHZa8Y
require 'rspotify'
require 'open-uri'

#結果を日本語で取得するために設定しています。
# ENV['ACCEPT_LANGUAGE'] = "ja"
client_id = '867b44de07d8409ab56d3e5dbbdb1931'
client_secret = 'd4b39a519c90446e87a38c4015a1806b'
#実際に実行する場合には、第一引数にクライアントID, 第二引数にクライアントシークレットを入れてください。
RSpotify.authenticate(client_id, client_secret)

# # 「いきものがかり」で検索し、一番上に出てきたアーティストを取得対象とする。
# artist = RSpotify::Artist.search('いきものがかり').first
# puts artist.genres # => ["anime", "j-pop", "j-poprock"]
# artist.albums.map(&:name)
# puts album.tracks.first.name

album_id = ARGV[1]
start_time = ARGV[0]
h_total = 0
m_total = 0
s_total = start_time.to_f*1000 # m sec に変換

album = RSpotify::Album.find(album_id)
puts album.images.first
height = album.images.first['height']
width = album.images.first['width']
puts album.name
for artist in album.artists
    puts artist.name
end
puts album.release_date

URI.open(album.images.first['url']) do |res|
    IO.copy_stream(res, 'folder.jpg')
end

for track in album.tracks
    m,s = (track.duration_ms).divmod(60000)
    h_total, s_total = (h_total*3600000 + (m_total + m)*60000 + s_total + s).divmod(3600000)
    m_total, s_total = s_total.divmod(60000)
    puts sprintf("%d\t%02d:%02d\t%02d:%02d:%5.3f\t%s", track.track_number, m, s/1000, h_total, m_total, s_total.to_f/1000, track.name)
end
# for track in album.tracks
#     m,s = (track.duration_ms).divmod(60)
#     h_total, s_total = (h_total*3600 + (m_total + m)*60 + s_total + s).divmod(3600)
#     m_total, s_total = s_total.divmod(60)
#     puts sprintf("%d\t%02d:%02d\t%02d:%02d:%02d.0\t%s", track.track_number, m, s, h_total, m_total, s_total, track.name)
# end