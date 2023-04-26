require 'taglib'

width = 640
height = 640


TagLib::FLAC::File.open("serkin_inventions_1.flac") do |file|
    pic = file.picture_list
    p file.tag
    puts pic.length
    puts file.tag.album, file.tag.artist, file.tag.track, file.tag.title
    # file.tag.album = 'フィンガー5ベスト'
    # file.tag.artist = 'Finger5'
    # file.tag.track = 7
    # file.tag.title = '恋のダイヤル'
    # file.save

    # tag = file.xiph_comment
    # p tag
    # # tag.title = 'finger'
    # # tag.tracknumber = '7'
    fields = file.xiph_comment.field_list_map
    p fields
    # file.xiph_comment.add_field('date', '1980', replace = true)
    # file.xiph_comment.add_field('album', 'バッハ ゼルキン', replace = true)
    # file.xiph_comment.add_field('title', 'invention no.2', replace = true)
    # file.xiph_comment.add_field('tracknumber', '3', replace = true)
    # file.xiph_comment.add_field('artist', 'serkin peter', replace = true)
    # file.save

    # 画像の追加
    if pic.length == 0
        pic = TagLib::FLAC::Picture.new
        pic.type = TagLib::FLAC::Picture::FrontCover
        pic.mime_type = "image/jpeg"
        # pic.description = "front cover"
        pic.width = width
        pic.height = height
        pic.data = File.open("folder.jpg", 'rb') { |f| f.read }
    
        file.add_picture(pic)
        file.save
    end
    pic = file.picture_list
    p pic
    puts pic.length

end
