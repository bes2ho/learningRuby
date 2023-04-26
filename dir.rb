require 'taglib'


path = "/mnt/d/cd"
begin
  Dir.chdir(path)
  Dir.glob("francaix_*.flac") do |f|
    base, track_num = f.split(/_|\./)
    TagLib::FLAC::File.open(f) do |file|
        tag = file.xiph_comment
        puts tag.title
    end
  end
rescue
  puts "ファイル一覧の取得に失敗しました"
end
