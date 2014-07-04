class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_action :user

  #before_filter :admin

  require 'zip'
  require 'libreconv'
  
  def index
    @fields    = Field.all
  end

  def document
    @current_category = Category.find(params[:category_id])
    @documents = @current_category.documents
  end

  #dub
  def generate
    current_template = @templates.find(params[:template_id])
    current_document = Document.find(params[:document_id])
    
    category = cat_main(current_document.category)
    perm = Permission.find_by(:user_id => current_user.id, :category_id => category)
    if current_user.admin? || !perm.nil? && perm.status == 5    
      path   = "word/document.xml"
      fields = current_template.template_fields.map {|i| [i.field.code, i.val]} 

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
                xml.gsub!("{#{field[0]}}","#{field[1]}")
              end

              out.write xml
            else
              out.put_next_entry(e.name)
              out.write e.get_input_stream.read
            end
          end
        end
      end

      hash     = Digest::SHA256.hexdigest(Time.new.to_s + rand.to_s)
      filepath = "tmp/documents/#{hash}"
      File.open(filepath, "wb") {|f| f.write(buffer.string) } 
      Libreconv.convert(filepath, "#{filepath}.pdf")
      send_file("#{filepath}.pdf", :filename => "#{current_document.name}.pdf")
    else
      redirect_to dashboard_path, notice: t('not_permssion')
    end


  end


  private
    def user
      @category   = Category.root
      @categories = Category.all.map{|i| (i.name != 'root' ? [i.name, i.id] : [t("chose_category"), 0])} 
      @templates  = current_user.templates
    end

    def dynamic_fields
      [['year', Time.now.year.to_s], ['copyng_free', "Созданно в генераторе документов пробное использование"]]
    end

end
