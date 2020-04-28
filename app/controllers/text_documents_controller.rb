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
      # Push onto the RQ queue so we can read this from Python.
      Resque.redis.namespace = "rq"
      Resque.enqueue(Annotator, @text_document.id)
      redirect_to text_documents_path, notice: @text_document.file_name + " has been created."
    else
      puts @text_document.errors.messages
      render "new"
    end
  end

  def show
    @text_document = TextDocument.find(params[:id])
  end

  def destroy
    @text_document = TextDocument.find(params[:id])
    @text_document.destroy
    redirect_to text_documents_path, alert: @text_document.file_name + " has been destroyed."
  end

  private
    def text_document_params
      params.require(:text_document).permit(:file_name, :description, :file_content, :textfile)
    end
end
