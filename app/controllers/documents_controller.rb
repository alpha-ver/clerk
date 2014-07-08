class DocumentsController < ApplicationController
  require 'zip'
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :admin, only: [:create, :destroy, :update]
  before_action :user

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show

  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json

  def createl
  end


  def create
    hash = Digest::SHA256.hexdigest(Time.new.to_s + rand.to_s)
    File.open("public/templates/#{hash}.docx", "wb") { |f| f.write(params[:files][0].read) }

    begin
      @document = Document.new(document_params)
      @document.extension = "docx"
      @document.path      = hash
      @document.save

      #current_template = Template.find(1)
      current_document = @document
      
      path   = "word/document.xml"
      fields = Field.all.map {|i| [i.code, i.about]} 

      zf = Zip::File.new("public/templates/#{current_document.path}.#{current_document.extension}")
      buffer = Zip::OutputStream.write_buffer do |out|
        zf.entries.each do |e|
          if e.ftype == :directory
            out.put_next_entry(e.name)
          else
            if e.name == path
              out.put_next_entry(e.name)
              xml = e.get_input_stream.read.force_encoding("UTF-8")
              fields.concat(dynamic_fields).each do |field|
                #xml.gsub!("{#{field[0]}}","#{field[1]}")
                xml.gsub!("{#{field[0]}}", "➤#{field[1]}")
              end
              out.write xml
            else
              out.put_next_entry(e.name)
              out.write e.get_input_stream.read
            end
          end
        end
      end
      hash2 = Digest::SHA256.hexdigest(Time.new.to_s + rand.to_s)
      filepath = "tmp/documents/#{hash2}"
      File.open(filepath, "wb") {|f| f.write(buffer.string) } 
      Libreconv.convert(filepath, "public/preview/#{@document.path}.pdf")

      render :json => {:status => true, :message => "Файл сохранен"}
    rescue
      File.unlink("public/templates/#{hash}.docx")
      render :json => {:status => false, :message => "Файл не DOCX"}
    end

  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to admin_path, notice: t('document_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    path = @document.path
    begin
      File.unlink("public/templates/#{path}.docx")
      File.unlink("public/preview/#{path}.pdf")
    rescue
    
    end
    @document.destroy

    respond_to do |format|
      format.html { redirect_to admin_path, notice: t('document_destroyed') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      if current_user.nil?
        redirect_to new_user_session_path
      else
        @document = Document.find_by(:id => params[:id])
        if @document.nil?
          redirect_to dashboard_path
        else
          category = cat_main(@document.category)
          perm = Permission.find_by(:user_id => current_user.id, :category_id => category)
          if !current_user.admin?
            if perm.nil? || perm.status != 5
              redirect_to dashboard_path, notice: t('not_permssion')
            end
          end
        end
      end
    end

    def user
      @category   = Category.root
      @categories = Category.all.map{|i| (i.name != 'root' ? [i.name, i.id] : [t("chose_category"), 0])} 
      @templates  = current_user.templates
    end

    def dynamic_fields
      [['year', Time.now.year.to_s], ['copyng_free', "Созданно в генераторе документов пробное использование"]]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :category_id)
    end

end