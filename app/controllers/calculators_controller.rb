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

		respond_to do |format|
		       format.js 
		end
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


	def investment_calculator
	if params[:investment_calculator]
		@deposit = params[:investment_calculator][:deposit].to_f
		@interest = params[:investment_calculator][:interest].to_f
		@frequency = params[:investment_calculator][:frequency]
		@current_age = params[:investment_calculator][:current_age].to_f
		@retirement_age = params[:investment_calculator][:retirement_age].to_f
		@lumpsum = params[:investment_calculator][:lumpsum].to_f
		@inflation = params[:investment_calculator][:inflation].to_f
		@years = @retirement_age-@current_age
		@ir=@interest/100
		@ir=@ir.to_f
		@inflation_rate=@inflation/100
		@inflation_rate=@inflation_rate.to_f
		@real_rate=@ir-@inflation_rate
		@real_rate = @real_rate.to_f

		if @frequency=="Monthly"
			@exp=1/12.to_f
			@mci = (1.00+@ir)**@exp
		elsif @frequency=="Yearly"
			@mci = 1+@ir
		end

		if @frequency=="Monthly"
			@exp=1/12.to_f
			@mci2 = (1.00+@real_rate)**@exp
		elsif @frequency=="Yearly"
			@mci2 = 1+@real_rate
		end

		@months=@years*12
		@months=@months.to_i
		@amount=@lumpsum
		@amount2=@lumpsum
		@array=[]
		@array2=[]

		if @frequency=="Monthly"
			@months.times do
				@amount=(@amount*@mci)+(@deposit*@mci)
				@amount = @amount.round(2)
				@array.push(@amount)
			end
		elsif @frequency=="Yearly"
			@years.to_i.times do
			@amount=(@amount*@mci)+(@deposit*@mci)
			@amount = @amount.round(2)
			@array.push(@amount)
			end
		end

		if @frequency=="Monthly"
			@months.times do
				@amount2=(@amount2*@mci2)+(@deposit*@mci2)
				@amount2 = @amount2.round(2)
				@array2.push(@amount2)
			end
		elsif @frequency=="Yearly"
			@years.to_i.times do
			@amount2=(@amount2*@mci2)+(@deposit*@mci2)
			@amount2 = @amount2.round(2)
			@array2.push(@amount2)
			end
		end

		n = 12

		if @frequency=="Monthly"
			@array = (n - 1).step(@array.size - 1, n).map { |i| @array[i] }
		end

		if @frequency=="Monthly"
			@array2 = (n - 1).step(@array2.size - 1, n).map { |i| @array2[i] }
		end

		@outputs=@array
		@outputs2=@array2

		@outputs_int = @outputs.map(&:to_i)
		@outputs2_int = @outputs2.map(&:to_i)

		@total=@outputs_int.last
		@initial=@lumpsum.to_i

		if @frequency=="Monthly"
			@contributions=@deposit*@months
		elsif @frequency=="Yearly"
			@contributions=@deposit*@years
		end

		@contributions=@contributions.to_i
		@growth=@total-@initial-@contributions

		@growth=@growth.to_s
		@contributions=@contributions.to_s
		@initial=@initial.to_s

		@labels=[]
		@labels2=[]

		for g in 1..@outputs.length
			@labels.push(g)
		end

		for r in 1..@outputs2.length
			@labels2.push(r)
		end

		render 'investment_calculator'
	else
		render 'investment_calculator'
	end
	end

	def educationoutput
		@deposit = params[:educationoutput][:deposit].to_f
		@interest = params[:educationoutput][:interest].to_f
		@frequency = params[:educationoutput][:frequency]
		@current_age = params[:educationoutput][:current_age].to_f
		@retirement_age = params[:educationoutput][:retirement_age].to_f
		@lumpsum = params[:educationoutput][:lumpsum].to_f
		@inflation = params[:educationoutput][:inflation].to_f
		@years = @retirement_age-@current_age
		@ir=@interest/100
		@ir=@ir.to_f
		@inflation_rate=@inflation/100
		@inflation_rate=@inflation_rate.to_f
		@real_rate=@ir-@inflation_rate
		@real_rate = @real_rate.to_f

		if @frequency=="Monthly"
			@exp=1/12.to_f
			@mci = (1.00+@ir)**@exp
		elsif @frequency=="Yearly"
			@mci = 1+@ir
		end

		if @frequency=="Monthly"
			@exp=1/12.to_f
			@mci2 = (1.00+@real_rate)**@exp
		elsif @frequency=="Yearly"
			@mci2 = 1+@real_rate
		end

		@months=@years*12
		@months=@months.to_i
		@amount=@lumpsum
		@amount2=@lumpsum
		@array=[]
		@array2=[]

		if @frequency=="Monthly"
			@months.times do
				@amount=(@amount*@mci)+(@deposit*@mci)
				@amount = @amount.round(2)
				@array.push(@amount)
			end
		elsif @frequency=="Yearly"
			@years.to_i.times do
			@amount=(@amount*@mci)+(@deposit*@mci)
			@amount = @amount.round(2)
			@array.push(@amount)
			end
		end

		if @frequency=="Monthly"
			@months.times do
				@amount2=(@amount2*@mci2)+(@deposit*@mci2)
				@amount2 = @amount2.round(2)
				@array2.push(@amount2)
			end
		elsif @frequency=="Yearly"
			@years.to_i.times do
			@amount2=(@amount2*@mci2)+(@deposit*@mci2)
			@amount2 = @amount2.round(2)
			@array2.push(@amount2)
			end
		end

		n = 12

		if @frequency=="Monthly"
			@output = (n - 1).step(@array.size - 1, n).map { |i| @array[i] }
		end

		@outputs=@array
		@outputs2=@array2

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
end