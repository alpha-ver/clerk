class TemplatesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  
  # GET /templates/1
  # GET /templates/1.json
  def show

  end

  # GET /templates/1/edit
  def edit
    @template_fields = @template.template_fields
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)
    current_user.templates << @template

    respond_to do |format|
      if current_user.save
        Field.all.each do |field|
          t_field          = TemplateField.new(val: "")
          t_field.field    = field
          t_field.template = @template 
          t_field.save
        end
        format.html { redirect_to dashboard_path, notice: t('template_added') }
      else
        format.html { redirect_to dashboard_path, notice: @template.errors.full_messages[0]}
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update

    respond_to do |format|
      if @template.update(template_params)
        params[:template_fields].each do |p|
          # name: p[0], val: p[1]
          field  = Field.find_by(:code => p[0])
          tf     = TemplateField.find_by(:field_id => field.id, :template_id => @template.id)
          tf.val = p[1]
          tf.save
        end
        format.html { redirect_to dashboard_path, notice: t('template_updated') }
      else
        format.html { render :edit}
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    if @template.id != 1
      @template.destroy
    end

    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: t('template_destroyed') }
    end

  end

  private

    def set_template
      @template = current_user.templates.find_by(:id => params[:id]) || not_found
    end

    def template_params
      params.require(:template).permit(:name, :about)
    end

    def not_found
      redirect_to dashboard_path, notice: t('contact_to_admin')
    end

end
