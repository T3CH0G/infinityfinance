class CalculatorsController < ApplicationController
	def calc1
	end

	def lumpsum
	end

	def output
		@savings = params[:output][:savings].to_f
		@interest = params[:output][:interest].to_f
		@frequency = params[:output][:frequency].to_f
		@current_age = params[:output][:current_age].to_f
		@retirement_age = params[:output][:retirement_age].to_f
		@years=@retirement_age-@current_age;
		r = (((100+@interest)/100)**(1/@frequency))-1
		r2 = (((100+@interest)/100)**(1/@frequency))
		@investments = []
		for i in 1..@years
			@investment = @savings*((((r2)**((@frequency*i)+1)-1)/r)-1)
			@investment = '%.2f' % @investment
			@investments.push(@investment)
			i+=1
		end
		@investments_int = @investments.map(&:to_i)
		@labels=[]
		for g in 1..@investments.length
			@labels.push(g)
		end
		render 'output'
	end

	def output2
		@amount_inv= params[:output2][:amount_inv].to_f
		@investment_gr = params[:output2][:investment_gr].to_f
		@inflation = params[:output2][:inflation].to_f
		@current_age = params[:output2][:current_age].to_f
		@retirement_age = params[:output2][:retirement_age].to_f
		@years=@retirement_age-@current_age
		@gr = @investment_gr/100
		@outputs = []
		for i in 1..@years
			@output = @amount_inv*((1+@gr)**i)
			@output = '%.2f' % @output
			@outputs.push(@output)
			i+=1
		end

		@outputs_int = @outputs.map(&:to_i)
		@labels=[]
		for g in 1..@outputs.length
			@labels.push(g)
		end

		render 'output2'
	end
end