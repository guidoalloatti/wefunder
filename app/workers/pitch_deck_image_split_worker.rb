class PitchDeckImageSplitWorker
  require 'rmagick'

  include Sidekiq::Worker
  sidekiq_options queue: 'wefunder'
  sidekiq_options retry: 3

  def perform(deck_id)
    @deck = Deck.find(deck_id)
    @original_file = @deck.pitch_deck_file_name
    @file_ext = File.extname(@original_file).strip.downcase[1..-1]
    @file_name = @original_file.sub("." + @file_ext, "")
    @file_path = "#{Rails.root}/public/uploads/"
    @file = @file_path + @original_file
        
    if File.exist?(@file)
      if pdf?
        @images = Magick::Image.read(@file)
        @images.each_with_index do |image, index|
          create_images(index)
          image_name = get_filepath(index)
          image.write(image_name)
        end
      elsif ppt?
        Docsplit.extract_images(
          @file,
          :size => '1152x',
          :format => [:jpg],
          :output => './public/uploads/'
        )

        size = Docsplit.extract_length(@file)
        size.times do |index|
          create_images(index)
        end
      end
    else
      p "File not found for pitch deck."
    end
  end

  private

  def get_filename(index)
    "/uploads/" + @file_name + "_" + (index+1).to_s + ".jpg"
  end

  def get_filepath(index)
    @file.sub("." + @file_ext, "") + "_" + (index+1).to_s + ".jpg"
  end

  def create_images(index)
    image_filepath = get_filepath(index)
    image_filename = get_filename(index)
    @deck.images.create(filename: image_filename, filepath: image_filepath)
  end

  def pdf?
    @file_ext == "pdf"
  end

  def ppt?
    ['ppt', 'pptx'].include?(@file_ext)
  end
end

