class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin
  before_action :user

  require "zip"
  require 'libreconv'
  
  def index
    @fields    = Field.all
  end

  def document
    @current_category = Category.find(params[:category_id])
    @documents = @current_category.documents
  end

  def generate
    current_template = @templates.find(params[:template_id])
    current_document = Document.find(params[:document_id])
    
    if current_document.extension    == 'docx'
      path = "word/document.xml"
    elsif current_document.extension == 'xlsx'
      path = ''
    else
      path = ''
    end

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
              xml.gsub!("#{field[0]}","#{field[1]}")
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
  end

  private
    def user
      @category  = Category.root
      @templates = current_user.templates
    end

    def dynamic_fields
      [['{year}', Time.now.year.to_s], ['{copyng_free}', "Созданно в генераторе документов пробное использование"]]
    end

end
