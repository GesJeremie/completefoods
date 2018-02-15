class Tasks::ImportIcons < Trailblazer::Operation

  success  :import

  def import(options, params:, **)
    puts "Importing icons ..."

    document = Nokogiri::HTML(File.open('/app/public/import/icons.htm'))

    document.css('img').each do |image|
      media_path = image.attr('class').split('/')
      tmp_media_path = image.attr('src').gsub('./icons_files/', '')

      FileUtils.mkdir_p("/app/app/assets/images/media/#{media_path[0]}")
      FileUtils.cp("/app/public/import/icons_files/#{tmp_media_path}", "/app/app/assets/images/media/#{media_path[0]}/#{media_path[1]}")
      puts "#{media_path[0]}/#{media_path[1]} added"
    end

    FileUtils.remove_dir("/app/public/import")
    puts "Import folder removed"

  end

end
