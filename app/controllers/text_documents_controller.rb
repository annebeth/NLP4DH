class TextDocumentsController < ApplicationController

  def index
    @text_documents = TextDocument.all
  end

  def new
    @text_document = TextDocument.new
  end

  def create
    @text_document = TextDocument.new(text_document_params)
    # Update the filename with the name of the uploaded file.
    @text_document.file_name = params[:text_document]["textfile"].original_filename
    # Read text from the uploaded file and save the file content.
    uploaded_file = File.open(params[:text_document]["textfile"], "rb")
    @text_document.file_content = uploaded_file.read.force_encoding('utf-8')

    if @text_document.save
       redirect_to text_documents_path
    else
       render "new"
    end

  end

  def show
    @text_document = TextDocument.find(params[:id])
  end

  def destroy
    @text_document = TextDocument.find(params[:id])
    @text_document.destroy
    redirect_to text_documents_path
  end

  private
    def text_document_params
      params.require(:text_document).permit(:file_name, :description, :file_content, :textfile)
    end
end
