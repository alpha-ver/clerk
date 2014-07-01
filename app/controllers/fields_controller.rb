class FieldsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin
  before_action :set_field, only: [:show, :edit, :update, :destroy]

  # GET /fields/new
  def new
    @field = Field.new
  end

  # GET /fields/1/edit
  def edit
  end

  # POST /fields
  def create
    @field = Field.new(field_params)
    respond_to do |format|
      if @field.save
        Template.all.each do |template|
          tf          = TemplateField.new(val:'')
          tf.template = template
          tf.field    = @field
          tf.save
        end

        format.html { redirect_to dashboard_path, notice: t('field_created') }
      else
        format.html { redirect_to dashboard_path, notice: @field.errors.full_messages[0] }
      end
    end
  end

  # PATCH/PUT /fields/1
  def update
    respond_to do |format|
      if @field.update(field_params)
        format.html { redirect_to dashboard_path, notice: t('field_updated') }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /fields/1
  # DELETE /fields/1.json
  def destroy
    @field.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: t('field_destroyed') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_field
      @field = Field.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def field_params
      params.require(:field).permit(:name, :about, :code)
    end
end
