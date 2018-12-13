class RecruitmentsController < ApplicationController
  before_action :set_recruitment, only: [:show, :edit, :update, :destroy]

  # GET /recruitments
  # GET /recruitments.json
  def index
    @recruitments = Recruitment.all
    @recruitments.order(updated_at: "DESC")
  end

  # GET /recruitments/new
  def new
    @recruitment = Recruitment.new
  end


  # POST /recruitments
  # POST /recruitments.json
  def create
    @recruitments = Recruitment.all
    @inputtag = Inputtag.new
    if account_signed_in? then
      @taghistoryid = Taghistoryid.new
      @inputtag.setuniv school: current_account.university, faculty: current_account.faculty, department: current_account.department
    end

    @recruitment = Recruitment.new(recruitment_params)
    @recruitment.acc_id = current_account.acc_id#アカウントID
    @recruitment.update_time = Time.now.to_s(:datetime)
    if @recruitment.detail.size ==0 || (@recruitment.detail.gsub(/\r\n|\r|\n|\s|\t/, "")).size==0
      @recruitment.detail = nil
    end

    if $view_com_num == '5'
      @recruitment.re_id  = '発言'
      @recruitment.title = "発言"
    else if  $view_com_num == '6'
           @recruitment.re_id  = '募集'
           @recruitment.resolved = '未解決'
         end
    end

    respond_to do |format|
      if @recruitment.save
        tagarry=[params[:school], params[:faculty], params[:department], params[:tag1], params[:tag2], params[:tag3], params[:tag4], params[:tag5], params[:tag6], params[:tag7]]
        Tagmap.associate(@recruitment.id, tagarry)
        format.html { redirect_to root_path, notice: '送信しました' }
        format.json { render :show, status: :created, location: @recruitment }
      else
        format.html { render :template => "mains/index" }
        format.json { render json: @recruitment.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /recruitments/1
  # DELETE /recruitments/1.json
  def destroy
    @recruitment.destroy
    Tagmap.delrelated(@recruitment.id)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Recruitment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruitment
      @recruitment = Recruitment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recruitment_params
      params.require(:recruitment).permit(:post_time, :update_time, :acc_id, :chat_id, :resolved,  :ans_com_id, :detail, :title, :integer, :answer, :file_id)
    end
end
