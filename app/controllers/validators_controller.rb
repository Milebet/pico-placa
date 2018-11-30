class ValidatorsController < ApplicationController
  
  def index
  end

  def new
  	@validator = Validator.new()
  end

  def validate
  	@validator = Validator.new(placa_params)
  	@validator.date = placa_params["date"]
  	last_digit = @validator.get_last_digit
  	@validator.time = placa_params["time"]
  	respond_to do |format|
	  	if !@validator.is_a_valid_placa?
	  	  flash.now[:alert] = "Formato de placa invalido"
        format.html { render 'new', :alert => "Formato de placa invalido" }
      elsif @validator.is_an_invalid_day?(last_digit) && !@validator.is_an_invalid_hour?
		    format.html { redirect_to validators_path, notice: "Puede conducir" }
	    elsif @validator.is_an_invalid_day?(last_digit) && @validator.is_an_invalid_hour?
		    flash.now[:alert] = "Por la hora, usted no puede conducir el vehículo"
        format.html { redirect_to validators_path, :alert => flash.now[:alert]}
  		else
  		  format.html { redirect_to validators_path, notice: "Puede conducir" }
  		end
	  end
  end

  private
    def placa_params
    	params.require(:validator).permit(:placa, :date, :time)
    end
end
