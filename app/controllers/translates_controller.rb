class TranslatesController < ApplicationController
  before_action :set_translate, only: [:show, :edit, :update, :destroy]

  # GET /translates
  # GET /translates.json
  def index
    page = params[:page] || 1
    @translates = Translate.page(page).per(5)
  end

  def not_learned
    page = params[:page] || 1
    @translates = Translate.where(learned: false).page(page).per(5)
  end

  def for_repeat
    page = params[:page] || 1
    @translates = Translate.where(learned: true).page(page).per(5)
  end
  # GET /translates/1
  # GET /translates/1.json
  def show
  end

  # GET /translates/new
  def new
    @translate = Translate.new
  end

  # GET /translates/1/edit
  def edit
  end

  # POST /translates
  # POST /translates.json
  def create
    @translate = Translate.new(translate_params)

    respond_to do |format|
      if @translate.save
        format.html { redirect_to @translate, notice: 'Translate was successfully created.' }
        format.json { render :show, status: :created, location: @translate }
      else
        format.html { render :new }
        format.json { render json: @translate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /translates/1
  # PATCH/PUT /translates/1.json
  def update
    respond_to do |format|
      if @translate.update(translate_params)
        format.html { redirect_to @translate, notice: 'Translate was successfully updated.' }
        format.json { render :show, status: :ok, location: @translate }
      else
        format.html { render :edit }
        format.json { render json: @translate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_learned
    argument = params[:translate][:learned]
    Translate.find(params[:id]).learn(argument)
  end

  def update_repeited
    argument = params[:translate][:repeited]
    Translate.find(params[:id]).repeit(argument)
  end

  def search_result
    page = params[:page] || 1
    selector = params[:translate][:word].downcase
    @translates = Translate.or( 
      { word: /.*#{selector}.*/ },
      { translate: /.*#{selector}.*/ }
    ).page(page).per(5)

    respond_to do |format|
      if @translates.empty?
        format.html { render :no_result}
      else
        format.html { render :search_result}
      end
    end
  end

  # DELETE /translates/1
  # DELETE /translates/1.json
  def destroy
    @translate.destroy
    respond_to do |format|
      format.html { redirect_to translates_url, notice: 'Translate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_translate
      @translate = Translate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def translate_params
      params.require(:translate).permit(:word, :transcription, :translate, :learned, :repeited)
    end
end
