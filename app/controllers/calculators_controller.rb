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

			@investment_name = params[:investment_calculator][:investment_name]
			@investment_ls = params[:investment_calculator][:investment_ls].to_f
			@investment_regular = params[:investment_calculator][:investment_regular].to_f
			@investment_growth = params[:investment_calculator][:investment_growth].to_f
			@investment_name2 = params[:investment_calculator][:investment_name2]
			@investment_ls2 = params[:investment_calculator][:investment_ls2].to_f
			@investment_regular2 = params[:investment_calculator][:investment_regular2].to_f
			@investment_growth2 = params[:investment_calculator][:investment_growth2].to_f
			@investment_name3 = params[:investment_calculator][:investment_name3]
			@investment_ls3 = params[:investment_calculator][:investment_ls3].to_f
			@investment_regular3 = params[:investment_calculator][:investment_regular3].to_f
			@investment_growth3 = params[:investment_calculator][:investment_growth3].to_f
			@investment_name4 = params[:investment_calculator][:investment_name4]
			@investment_ls4 = params[:investment_calculator][:investment_ls4].to_f
			@investment_regular4 = params[:investment_calculator][:investment_regular4].to_f
			@investment_growth4 = params[:investment_calculator][:investment_growth4].to_f
			@investment_name5 = params[:investment_calculator][:investment_name5]
			@investment_ls5 = params[:investment_calculator][:investment_ls5].to_f
			@investment_regular5 = params[:investment_calculator][:investment_regular5].to_f
			@investment_growth5 = params[:investment_calculator][:investment_growth5].to_f

			@years = @retirement_age-@current_age
			@ir=@interest/100
			@ir=@ir.to_f
			@invr=@investment_growth/100
			@invr2=@investment_growth2/100
			@invr3=@investment_growth3/100
			@invr4=@investment_growth4/100
			@invr5=@investment_growth5/100
			@inflation_rate=@inflation/100
			@inflation_rate=@inflation_rate.to_f
			@real_rate=@ir-@inflation_rate
			@real_rate = @real_rate.to_f
			@inv_real_rate=@invr-@inflation_rate
			@inv_real_rate2=@invr2-@inflation_rate
			@inv_real_rate3=@invr3-@inflation_rate
			@inv_real_rate4=@invr4-@inflation_rate
			@inv_real_rate5=@invr5-@inflation_rate

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

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@invmci = (1.00+@invr)**@exp
			elsif @frequency=="Yearly"
				@invmci = 1+@invr
			end


			if @frequency=="Monthly"
				@exp=1/12.to_f
				@invmci2 = (1.00+@invr2)**@exp
			elsif @frequency=="Yearly"
				@invmci2 = 1+@invr2
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@invmci3 = (1.00+@invr3)**@exp
			elsif @frequency=="Yearly"
				@invmci3 = 1+@invr3
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@invmci4 = (1.00+@invr4)**@exp
			elsif @frequency=="Yearly"
				@invmci4 = 1+@invr4
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@invmci5 = (1.00+@invr5)**@exp
			elsif @frequency=="Yearly"
				@invmci5 = 1+@invr5
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@real_invmci = (1.00+@inv_real_rate)**@exp
			elsif @frequency=="Yearly"
				@real_invmci = 1+@inv_real_rate
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@real_invmci2 = (1.00+@inv_real_rate2)**@exp
			elsif @frequency=="Yearly"
				@real_invmci2 = 1+@inv_real_rate2
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@real_invmci3 = (1.00+@inv_real_rate3)**@exp
			elsif @frequency=="Yearly"
				@real_invmci3 = 1+@inv_real_rate3
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@real_invmci4 = (1.00+@inv_real_rate4)**@exp
			elsif @frequency=="Yearly"
				@real_invmci4 = 1+@inv_real_rate4
			end

			if @frequency=="Monthly"
				@exp=1/12.to_f
				@real_invmci5 = (1.00+@inv_real_rate5)**@exp
			elsif @frequency=="Yearly"
				@real_invmci5 = 1+@inv_real_rate5
			end

			@months=@years*12
			@months=@months.to_i
			@amount=@lumpsum+@investment_ls
			@amount2=@lumpsum+@investment_ls
			@array=[]
			@array2=[]

			if @frequency=="Monthly"
				@months.times do
					@amount=(@amount*@mci)+(@deposit*@mci)+(@investment_regular*@invmci)+(@investment_regular2*@invmci2)+(@investment_regular3*@invmci3)+(@investment_regular4*@invmci4)+(@investment_regular5*@invmci5)
					@amount = @amount.round(2)
					@array.push(@amount)
				end
			elsif @frequency=="Yearly"
				@years.to_i.times do
				@amount=(@amount*@mci)+(@deposit*@mci)+(@investment_regular*@invmci)+(@investment_regular2*@invmci2)+(@investment_regular3*@invmci3)+(@investment_regular4*@invmci4)+(@investment_regular5*@invmci5)
				@amount = @amount.round(2)
				@array.push(@amount)
				end
			end

			if @frequency=="Monthly"
				@months.times do
					@amount2=(@amount2*@mci2)+(@deposit*@mci2)+(@investment_regular*@real_invmci)+(@investment_regular2*@real_invmci2)+(@investment_regular3*@real_invmci3)+(@investment_regular4*@real_invmci4)+(@investment_regular5*@real_invmci5)
					@amount2 = @amount2.round(2)
					@array2.push(@amount2)
				end
			elsif @frequency=="Yearly"
				@years.to_i.times do
				@amount2=(@amount2*@mci2)+(@deposit*@mci2)+(@investment_regular*@real_invmci)+(@investment_regular2*@real_invmci2)+(@investment_regular3*@real_invmci3)+(@investment_regular4*@real_invmci4)+(@investment_regular5*@real_invmci5)
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

			for g in @current_age.to_i..(@retirement_age.to_i-1)
				@labels.push(g)
			end


			render 'investment_calculator'
		else
			render 'investment_calculator'
		end
	end

	def retirement_planner
		if params[:retirement_planner]
		@deposit = params[:retirement_planner][:deposit].to_f
		@current_p = params[:retirement_planner][:current_p].to_f
		@interest = params[:retirement_planner][:interest].to_f
		@frequency = params[:retirement_planner][:frequency]
		@current_age = params[:retirement_planner][:current_age].to_f
		@retirement_age = params[:retirement_planner][:retirement_age].to_f
		@lumpsum = params[:retirement_planner][:lumpsum].to_f
		@inflation = params[:retirement_planner][:inflation].to_f
		@retirement_length = params[:retirement_planner][:retirement_length].to_f
		@years = @retirement_age-@current_age
		@ir=@interest/100
		@ir=@ir.to_f
		@inflation_rate=@inflation/100
		@inflation_rate=@inflation_rate.to_f
		@formula_inflation=@inflation_rate+1
		@formula_interest=@ir+1
		@formula_retirement = @retirement_length-1
		@formula_years=@years
		@iterate_sum=0
		@retirement_length.to_i.times do
			@iterate = ((@formula_interest)**@formula_retirement)*((@formula_inflation)**@formula_years)
			@iterate_sum = @iterate_sum+@iterate
			@formula_retirement-=1
			@formula_years+=1
		end
		@formula=(@deposit*@iterate_sum)/((@formula_interest)**@retirement_length)

		if @frequency=="Monthly"
			@exp=1/12.to_f
			@mci = (1.00+@ir)**@exp
		elsif @frequency=="Yearly"
			@mci = 1+@ir
		end

		if @frequency=="Monthly"
			@premium_f=12
		elsif @frequency=="Yearly"
			@premium_f=1
		end

		@denom=((((@mci)**((@premium_f*@years)+1))-1)/(@mci-1))-1
		@premium = (@formula-@lumpsum*(1+@mci)**(@premium_f*@years))/@denom

		@months=@years*12
		@months=@months.to_i
		@amount=@lumpsum
		@amount2=@lumpsum
		@array=[]

		if @frequency=="Monthly"
			@months.times do
				@amount=(@amount*@mci)+(@premium*@mci)
				@amount = @amount.round(2)
				@array.push(@amount)
			end
		elsif @frequency=="Yearly"
			@years.to_i.times do
			@amount=(@amount*@mci)+(@premium*@mci)
			@amount = @amount.round(2)
			@array.push(@amount)
			end
		end


		n = 12

		if @frequency=="Monthly"
			@array = (n - 1).step(@array.size - 1, n).map { |i| @array[i] }
		end

		@startyear= @years
		@outputs2=[]
		@array.length.times do |x|
			@outputs2.push(0)
		end
		@retirement_length.to_i.times do 
			@amount=@amount*(@ir+1)
			@withdrawal=@deposit*((@formula_inflation)**@startyear)
			@outputs2.push(@withdrawal)
			@amount=@amount-@withdrawal
			@amount = @amount.round(2)
			@startyear+=1
			@array.push(@amount)
		end


		@outputs=@array


		@outputs_int = @outputs.map(&:to_i)
		@growths=[0]
		@f=0
		@growth_output=@outputs_int.length-1
		@growth_output.times do
			@p1=@outputs_int[@f+1]
			@p2=@outputs_int[@f]
			@g=@p1-@p2
			@growths.push(@g)
			@f+=1
		end
		@outputs_int2 = @outputs2.map(&:to_i)

		@total=@outputs_int.last
		@initial=@lumpsum.to_i

		if @frequency=="Monthly"
			@contributions=@deposit*@months
		elsif @frequency=="Yearly"
			@contributions=@deposit*@years
		end

		@contributions=@contributions.to_i
		if @total.nil?
		@growth=0;
		else
		@growth=@total-@initial-@contributions
		end

		@growth=@growth.to_s
		@contributions=@contributions.to_s
		@initial=@initial.to_s

		@labels=[]

		for g in 1..@outputs.length
			@labels.push(g)
		end

		if @current_p > @premium
			@difference= @current_p-@premium
			@advice = "You are paying #{@difference.round(2)} more than you need to."
		elsif @current_p < @premium
			@difference= @premium-@current_p
			@advice = "You are paying #{@difference} less than you need to."
		else
			@difference="0"
			@advice="Congrats nibba"
		end

		@difference=@difference.round(2)

		render 'retirement_planner'
	else
		render 'retirement_planner'
	end
	end

	def educationoutput
		@child1_name = params[:educationoutput][:child1_name]
		@child1_startingage = params[:educationoutput][:child1_startingage]
		@child1_currentage = params[:educationoutput][:child1_currentage]
		@child1_years = params[:educationoutput][:child1_years]
		@child1_tuition = params[:educationoutput][:child1_tuition]
		@child1_living_expense = params[:educationoutput][:child1_living_expense]
		@tuition_inflation = params[:educationoutput][:tuition_inflation].to_f

		@deposit = params[:educationoutput][:deposit].to_f
		@interest = params[:educationoutput][:interest].to_f
		@frequency = params[:educationoutput][:frequency]
		@lumpsum = params[:educationoutput][:lumpsum].to_f
		@inflation = params[:educationoutput][:inflation].to_f
		@years = @retirement_age-@current_age
		@ir=@interest/100
		@ir=@ir.to_f
		@years=@child1_years
		@inflation_rate=@inflation/100
		@inflation_rate=@inflation_rate.to_f
		@formula_inflation=@inflation_rate+1
		@formula_interest=@ir+1
		@retirement_length=@child1_years
		@formula_retirement = @retirement_length-1
		@formula_years=@years
		@iterate_sum=0
		@retirement_length.to_i.times do
			@iterate = ((@formula_interest)**@formula_retirement)*((@formula_inflation)**@formula_years)
			@iterate_sum = @iterate_sum+@iterate
			@formula_retirement-=1
			@formula_years+=1
		end
		@formula=(@deposit*@iterate_sum)/((@formula_interest)**@retirement_length)
		
		if @frequency=="Monthly"
			@exp=1/12.to_f
			@mci = (1.00+@ir)**@exp
		elsif @frequency=="Yearly"
			@mci = 1+@ir
		end

		if @frequency=="Monthly"
			@premium_f=12
		elsif @frequency=="Yearly"
			@premium_f=1
		end

		@denom=((((@mci)**((@premium_f*@years)+1))-1)/(@mci-1))-1
		@premium = (@formula-@lumpsum*(1+@mci)**(@premium_f*@years))/@denom

		@months=@years*12
		@months=@months.to_i
		@amount=@lumpsum
		@amount2=@lumpsum
		@array=[]

		if @frequency=="Monthly"
			@months.times do
				@amount=(@amount*@mci)+(@premium*@mci)
				@amount = @amount.round(2)
				@array.push(@amount)
			end
		elsif @frequency=="Yearly"
			@years.to_i.times do
			@amount=(@amount*@mci)+(@premium*@mci)
			@amount = @amount.round(2)
			@array.push(@amount)
			end
		end


		n = 12

		if @frequency=="Monthly"
			@array = (n - 1).step(@array.size - 1, n).map { |i| @array[i] }
		end

		@startyear= @years
		@outputs2=[]
		@array.length.times do |x|
			@outputs2.push(0)
		end
		@retirement_length.to_i.times do 
			@amount=@amount*(@ir+1)
			@withdrawal=@deposit*((@formula_inflation)**@startyear)
			@outputs2.push(@withdrawal)
			@amount=@amount-@withdrawal
			@amount = @amount.round(2)
			@startyear+=1
			@array.push(@amount)
		end


		@outputs=@array


		@outputs_int = @outputs.map(&:to_i)
		@growths=[0]
		@f=0
		@growth_output=@outputs_int.length-1
		@growth_output.times do
			@p1=@outputs_int[@f+1]
			@p2=@outputs_int[@f]
			@g=@p1-@p2
			@growths.push(@g)
			@f+=1
		end
		@outputs_int2 = @outputs2.map(&:to_i)

		@total=@outputs_int.last
		@initial=@lumpsum.to_i

		if @frequency=="Monthly"
			@contributions=@deposit*@months
		elsif @frequency=="Yearly"
			@contributions=@deposit*@years
		end

		@contributions=@contributions.to_i
		if @total.nil?
		@growth=0;
		else
		@growth=@total-@initial-@contributions
		end

		@growth=@growth.to_s
		@contributions=@contributions.to_s
		@initial=@initial.to_s

		@labels=[]

		for g in 1..@outputs.length
			@labels.push(g)
		end

		if @current_p > @premium
			@difference= @current_p-@premium
			@advice = "You are paying #{@difference.round(2)} more than you need to."
		elsif @current_p < @premium
			@difference= @premium-@current_p
			@advice = "You are paying #{@difference} less than you need to."
		else
			@difference="0"
			@advice="Congrats nibba"
		end

		@difference=@difference.round(2)

		render 'retirement_planner'
	else
		render 'retirement_planner'
	end
end