class ApplicationController < ActionController::Base

  def run
    if params[:input].present?
      if isvalid?
        @python_output = `python lib/assets/py_script/code.py #{params[:input]}`
        @python_output.upcase!
      end
        render 'new'
    else
      if !@python_output.nil?
        @python_output = nil
      end
        render 'new'
    end
  end

  private
  def isvalid?
    count=0
    flag=0
    params[:input].each_char do |c|
      count+=1
      if c.upcase<'A'&&c.upcase>'F'&&c<'0'&&c>'9'
        flag=1
      end
    end

    if count!=16||flag==1
      flash[:danger] = "Check your input"
      return false
    else
      return true
    end
  end
end
