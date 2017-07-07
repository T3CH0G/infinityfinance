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
		@real_value= @investment_gr-@inflation
		@gr = @investment_gr/100
		@rv = @real_value/100
		@outputs = []
		@outputs2 = []
		for i in 1..@years
			@output = @amount_inv*((1+@gr)**i)
			@output = '%.2f' % @output
			@outputs.push(@output)
			i+=1
		end
		for z in 1..@years
			@output2 = @amount_inv*((1+@rv)**z)
			@output2 = '%.2f' % @output2
			@outputs2.push(@output2)
			i+=1
		end

		@outputs_int = @outputs.map(&:to_i)
		@outputs2_int = @outputs2.map(&:to_i)

		@labels=[]
		@labels2=[]
		for g in 1..@outputs.length
			@labels.push(g)
		end

		for r in 1..@outputs2.length
			@labels2.push(r)
		end

		render 'output2'
	end

	def output3
		@target= params[:output3][:target].to_f
		@investment_gr = params[:output3][:investment_gr].to_f
		@current_age = params[:output3][:current_age].to_f
		@retirement_age = params[:output3][:retirement_age].to_f
		@years=@retirement_age-@current_age
		@gr = @investment_gr/100
		@outputs = []
		@amount_inv = @target/((1+@gr)**@years)
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

		render 'output3'
	end
end