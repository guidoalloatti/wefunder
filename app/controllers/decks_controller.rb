class DecksController < ApplicationController

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
    @deck_id = 0
  end

  def show
    if params[:id].to_i == 0
      @deck = Deck.last
    else
      @deck = Deck.find(params[:id])
    end
  end

  def destroy
    deck = Deck.find(params[:id])
    file_path = "./public/uploads/#{deck.pitch_deck_file_name}"

    # Delete PDF/PPT File
    File.delete(file_path) if File.exist?(file_path)

    # Delete all generated Images
    deck.images.each do |image|
      file_path = image&.filepath
      File.delete(file_path) if File.exist?(file_path)
    end
    
    # Destroy deck and deck images
    deck.images.destroy_all
    deck.destroy

    flash[:success] = 'Pitch Deck deleted successfuly.'
    redirect_to decks_path
  end

  def upload
    uploaded_file = deck_params[:file]
    file_name = "v#{deck_params[:version]}_#{uploaded_file&.original_filename}"
    file_path = "./public/uploads/#{file_name}"

    if File.exist?(file_path)
      flash[:error] = 'Pitch Deck version already exist, please change the version.'
      redirect_to new_deck_path
    else
      @deck = Deck.create(deck_params.merge!({pitch_deck_file_name: file_name}))
      
      # Upload the file if deck was created
      if @deck
        File.open(Rails.root.join('public', 'uploads', file_name), 'wb') do |file|
          file.write(uploaded_file.read)
        end

        # Process conversion to sidekiq worker
        ::PitchDeckImageSplitWorker.perform_async(@deck.id)

        @deck_id = @deck.id
        flash[:success] = 'Pitch Deck created successfuly.'
        redirect_to new_deck_path
      end
    end
  end

  def download
    file_path = File.join(Rails.root, "public", "uploads")
    file_name = params[:filename]
    send_file(File.join(file_path, file_name))
  end
  
  private

  def deck_params
    params.require(:deck).permit(:project, :company, :version, :file)
  end

end