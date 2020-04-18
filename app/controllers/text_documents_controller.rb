class TextDocumentsController < ApplicationController

  def index
    @text_documents = TextDocument.all
  end

  def new
    @text_document = TextDocument.new
  end

  def create
    @text_document = TextDocument.new(text_document_params)

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
