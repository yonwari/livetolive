class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      flash.now[:notice] = "入力内容に誤りがあります"
      render :action => 'new'
    end
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)
    if params[:commit] == "戻る"
      render :action => 'new'
    else
      InquiryMailer.received_email(@inquiry).deliver_now
      render :action => 'thanks'
    end
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message)
    end
end
