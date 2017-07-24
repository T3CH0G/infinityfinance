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

	def apr
		if params[:apr]
			@balance = params[:apr][:balance].to_f
			@interest = params[:apr][:interest].to_f
			@payment = params[:apr][:payment].to_f
			@ir=@interest/100
			@ir=@ir+1
			@exp=1/12.to_f
			@ir=@ir**(@exp)
			@balances=[@balance]
			@newbalance=@balance
			until @newbalance <= 0 do
			@newbalance=(@newbalance-@payment)*@ir
			@newbalance=@newbalance.round(2)
			@balances.push(@newbalance)
			end

			@length=@balances.length
			@balances[@length-1]=0
			
			render 'apr'
		else
			render 'apr'
		end
	end

	def apr2
		if params[:apr2]
			if params[:apr2][:months] != ""
				@balance = params[:apr2][:balance].to_f
				@interest = params[:apr2][:interest].to_f
				@months = params[:apr2][:months].to_f
				@ir=@interest/100
				@ir=@ir+1
				@exp=1/12.to_f
				@ir=@ir**(@exp)

				@numerator= @balance*(@ir**(@months-1))
				@denom=0
				@newmonths=@months-1
				@months2=@months-1
				@months2.to_i.times do
					@mci=@ir**@newmonths
					@denom=@denom+@mci
					@newmonths-=1
				end

				@payment=@numerator/@denom
				@balances=[@balance]
				@newbalance=@balance
				until @newbalance <= 0 do
				@newbalance=(@newbalance-@payment)*@ir
				@newbalance=@newbalance.round(2)
				@balances.push(@newbalance)
				end

				@length=@balances.length
				if @balances[@length-1] <= 1
				@balances[@length-1]=0
				end

				@labels=[]

					for g in 1..@balances.length
						@labels.push(g)
					end

				@total=@payment*@months
				@totalinterest=@total-@balance
				@repayments=@balance


				render 'apr2'
			else
				@balance = params[:apr2][:balance].to_f
				@interest = params[:apr2][:interest].to_f
				@payment = params[:apr2][:payment].to_f
				@ir=@interest/100
				@ir=@ir+1
				@exp=1/12.to_f
				@ir=@ir**(@exp)
				@balances=[@balance]
				@newbalance=@balance
				until @newbalance <= 0 do
				@newbalance=(@newbalance-@payment)*@ir
				@newbalance=@newbalance.round(2)
				@balances.push(@newbalance)
				end

				@length=@balances.length
				@balances[@length-1]=0
				@months = @length -1



				@labels=[]

					for g in 1..(@length - 1)
						@labels.push(g)
					end

				@total=@payment*@months
				@totalinterest=@total-@balance
				@repayments=@balance

				if @balances[@length-1] <= 1
				@balances[@length-1]=0
				end
				
				render 'apr2'
			end
		else
			render 'apr2'
		end
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
		@premium = (@formula-@lumpsum*((@mci)**(@premium_f*@years)))/@denom

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
			@advice = "You are paying #{@difference.round(2)} less than you need to."
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

	def education_calculator
		if params[:education_calculator]
			@child_name = params[:education_calculator][:child_name]
			@child_startingage = params[:education_calculator][:child_startingage].to_f
			@child_currentage = params[:education_calculator][:child_currentage].to_f
			@child_years = params[:education_calculator][:child_years].to_f
			@child_tuition = params[:education_calculator][:child_tuition].to_f
			@child_living_expense = params[:education_calculator][:child_living_expense].to_f

			@child2_name = params[:education_calculator][:child2_name]
			@child2_startingage = params[:education_calculator][:child2_startingage].to_f
			@child2_currentage = params[:education_calculator][:child2_currentage].to_f
			@child2_years = params[:education_calculator][:child2_years].to_f
			@child2_tuition = params[:education_calculator][:child2_tuition].to_f
			@child2_living_expense = params[:education_calculator][:child2_living_expense].to_f

			@child3_name = params[:education_calculator][:child3_name]
			@child3_startingage = params[:education_calculator][:child3_startingage].to_f
			@child3_currentage = params[:education_calculator][:child3_currentage].to_f
			@child3_years = params[:education_calculator][:child3_years].to_f
			@child3_tuition = params[:education_calculator][:child3_tuition].to_f
			@child3_living_expense = params[:education_calculator][:child3_living_expense].to_f

			@child4_name = params[:education_calculator][:child4_name]
			@child4_startingage = params[:education_calculator][:child4_startingage].to_f
			@child4_currentage = params[:education_calculator][:child4_currentage].to_f
			@child4_years = params[:education_calculator][:child4_years].to_f
			@child4_tuition = params[:education_calculator][:child4_tuition].to_f
			@child4_living_expense = params[:education_calculator][:child4_living_expense].to_f

			@child5_name = params[:education_calculator][:child5_name]
			@child5_startingage = params[:education_calculator][:child5_startingage].to_f
			@child5_currentage = params[:education_calculator][:child5_currentage].to_f
			@child5_years = params[:education_calculator][:child5_years].to_f
			@child5_tuition = params[:education_calculator][:child5_tuition].to_f
			@child5_living_expense = params[:education_calculator][:child5_living_expense].to_f

			@interest = params[:education_calculator][:interest].to_f
			@frequency = params[:education_calculator][:frequency]
			@lumpsum = params[:education_calculator][:lumpsum].to_f
			@inflation = params[:education_calculator][:inflation].to_f
			@tuition_inflation = params[:education_calculator][:tuition_inflation].to_f
			@ir=@interest/100
			@ir=@ir.to_f
			@inflation_rate=@inflation/100
			@inflation_rate=@inflation_rate.to_f
			@tuition_inflationz=@tuition_inflation/100
			@formula_inflation=@tuition_inflationz+1
			@formula_inflation2=@inflation_rate+1
			@formula_interest=@ir+1
			@formula_yoc = @child_years-1
			@formula_yoc2=@formula_yoc
			@formula_ytc=@child_startingage-@child_currentage
			@formula_ytc2=@formula_ytc
			@iterate_sum=0
			@iterate_sum2=0
			
			@tinflation=1+(@tuition_inflation/100)
			@linflation=1+@inflation_rate

			#child1
			@expenses=[@child_tuition]
			@ct= @child_tuition
			@times=(@child_startingage-@child_currentage)+@child_years
			@zeros=@child_startingage-@child_currentage
			@times.to_i.times do
				@ct=@ct*@tinflation
				@le=@child_living_expense*@linflation
				@ctle=@ct+@le
				@ctle=@ctle.round(2)
				@expenses.push(@ctle)
			end
			x=0
			@zeros.to_i.times do
				@expenses[x]=0
				x+=1
			end

			#child2
			@expenses2=[@child2_tuition]
			@ct2= @child2_tuition
			@times2=(@child2_startingage-@child2_currentage)+@child2_years
			@zeros2=@child2_startingage-@child2_currentage
			@times2.to_i.times do
				@ct2=@ct2*@tinflation
				@le2=@child2_living_expense*@linflation
				@ctle2=@ct2+@le2
				@ctle2=@ctle2.round(2)
				@expenses2.push(@ctle2)
			end
			x=0
			@zeros2.to_i.times do
				@expenses2[x]=0
				x+=1
			end

			#child3
			@expenses3=[@child3_tuition]
			@ct3= @child3_tuition
			@times3=(@child3_startingage-@child3_currentage)+@child3_years
			@zeros3=@child3_startingage-@child3_currentage
			@times3.to_i.times do
				@ct3=@ct3*@tinflation
				@le3=@child3_living_expense*@linflation
				@ctle3=@ct3+@le3
				@ctle3=@ctle3.round(2)
				@expenses3.push(@ctle3)
			end
			x=0
			@zeros3.to_i.times do
				@expenses3[x]=0
				x+=1
			end

			#child4
			@expenses4=[@child4_tuition]
			@ct4= @child4_tuition
			@times4=(@child4_startingage-@child4_currentage)+@child4_years
			@zeros4=@child4_startingage-@child4_currentage
			@times4.to_i.times do
				@ct4=@ct4*@tinflation
				@le4=@child4_living_expense*@linflation
				@ct4=@ct4+@le4
				@ctle4=@ctle4.round(2)
				@expenses4.push(@ctle4)
			end
			x=0
			@zeros4.to_i.times do
				@expenses4[x]=0
				x+=1
			end

			#child5
			@expenses5=[@child5_tuition]
			@ct5= @child5_tuition
			@times5=(@child5_startingage-@child5_currentage)+@child5_years
			@zeros5=@child5_startingage-@child5_currentage
			@times5.to_i.times do
				@ct5=@ct5*@tinflation
				@le5=@child5_living_expense*@linflation
				@ctle5=@ct5+@le5
				@ctle5=@ctle5.round(2)
				@expenses5.push(@ctle5)
			end
			x=0
			@zeros5.to_i.times do
				@expenses5[x]=0
				x+=1
			end

			@child_names=[@child_name,@child2_name,@child3_name,@child4_name,@child5_name]
			@totaltimes=[@times,@times2,@times3,@times4,@times5]
			@totaltimes=@totaltimes.max
			@totalexpenses=[]
			
			x=0
			@totals=[]

			@totaltimes.to_i.times do
				if @expenses[x]
				@array1=@expenses[x]
				else
				@array1=0
				end
				if @expenses2[x]
				@array2=@expenses2[x]
				else
				@array2=0
				end
				if @expenses3[x]
				@array3=@expenses3[x]
				else
				@array3=0
				end
				if @expenses4[x]
				@array4=@expenses4[x]
				else
				@array4=0
				end
				if @expenses5[x]
				@array5=@expenses5[x]
				else
				@array5=0
				end
				@total=@array1+@array2+@array3+@array4+@array5
				@totals.push(@total)
				@temparray = [@array1,@array2,@array3,@array4,@array5,@total]
				@totalexpenses.push(@temparray)
				x+=1
			end

			@total=@totals.max
			@premium=@total

			@pres=[]
			if @frequency=="Monthly"
				@exp=1/12.to_f
				@mci = (1.00+@ir)**@exp
			elsif @frequency=="Yearly"
				@mci = 1+@ir
			end

			@u=0


			while @pres.all?(&:positive?) || @pres==[]
				if @premium < 0.1
					break
				end
				@premium-=1
				@amount=@lumpsum.to_i
				@pres=[@amount]
				@years=@totaltimes	
				@months=@totaltimes*12
				if @frequency=="Monthly"

					z=0
					@pres=[@amount]
					@years.to_i.times do
					12.times do	
						@amount=(@amount*@mci)+(@premium*@mci)
					end
					@amount=@amount-@totals[z]
					@amount = @amount.round(2)
					@pres.push(@amount)
					z+=1
					end

				elsif @frequency=="Yearly"

					y=0
					@years.to_i.times do
					@amount=(@amount*@mci)+(@premium*@mci)-@totals[y]
					@amount = @amount.round(2)
					@pres.push(@amount)
						y+=1
					end
					@u+=1
				end

			end

			@premium = @premium + 1
				@amount=@lumpsum.to_i
				@pres=[@amount]
				@years=@totaltimes	
				if @frequency=="Monthly"
					z=0
					@pres=[@amount]
					@years.to_i.times do
					12.times do	
						@amount=(@amount*@mci)+(@premium*@mci)
						@amount = @amount.round(2)
					end
					@amount=@amount-@totals[z]
					@pres.push(@amount)
					z+=1
					end

				elsif @frequency=="Yearly"

					y=0
					@years.to_i.times do
					@amount=(@amount*@mci)+(@premium*@mci)-@totals[y]
					@amount = @amount.round(2)
					@pres.push(@amount)
						y+=1
					end
				end

			@pres.push(0)
			@post=[]
			@lengthzz=@pres.length-1
			h=1
			@lengthzz.times do 
				@post.push(@pres[h])
				h+=1
			end

			u=0
			@labels=[]
			@kek = @pres.length
			@kek = @kek-1
			@kek.times do
				@labels.push(u)
				u+=1
			end


			@child_total=@expenses.inject(0){|sum,x| sum + x }
			@child2_total=@expenses2.inject(0){|sum,x| sum + x }
			@child3_total=@expenses3.inject(0){|sum,x| sum + x }
			@child4_total=@expenses4.inject(0){|sum,x| sum + x }
			@child5_total=@expenses5.inject(0){|sum,x| sum + x }
			@childall_total=@child_total+@child2_total+@child3_total+@child4_total+@child5_total

			@child_total_array =[@child_total.to_i,@child2_total.to_i,@child3_total.to_i,@child4_total.to_i,@child5_total.to_i]


			@child_name_labels= []
			@child_names.each do |i|
				if i == nil
				else
					@child_name_labels.push(i.to_s)
				end
			end
			@child_final_totals=[]
			@child_total_array.each do |i|
				if i == nil || i == 0
				else
					@child_final_totals.push(i)
				end
			end




			render 'education_calculator'
		else
			render 'education_calculator'
		end
	end

	def mortgage
	  if params[:mortgage]
		@pla = params[:mortgage][:pla].to_f
		@air = params[:mortgage][:air].to_f
		@lp = params[:mortgage][:lp].to_f
		@epa = params[:mortgage][:epa].to_f
		@f = params[:mortgage][:f].to_f
		@nop = params[:mortgage][:nop].to_f
		@ir=@air/100
		@ir=1+@ir
		@lp2=@lp-1
		@iterate_sum=0
				@lp.to_i.times do
					@iterate=@ir**@lp2
					@iterate_sum=@iterate+@iterate_sum
					@lp2-=1
				end

		@payment = @pla*(@ir**(@lp-1))/(12*(@iterate_sum))

		@plas=[@pla]
				@newpla=@pla
				until @newpla <= 0 do
				@newpla=(@newpla-(12*@payment))*@ir
				@newpla=@newpla.round(2)
				@plas.push(@newpla)
				end

				@length=@plas.length
				@plas[@length-1]=0
				@years = @length -1



				@labels=[]

					for g in 1..(@length - 1)
						@labels.push(g)
					end

				@total=@payment*@years
				@totalinterest=@total-@pla
				@repayments=@pla

				if @plas[@length-1] <= 1
				@plas[@length-1]=0
				end

		@plas2=[@pla]
			@newpla2=@pla
			@nop2 = @nop
			if @f==12
					until @nop2 <= 0 do
					@newpla2=(@newpla2-(12*(@payment+@epa)))*@ir
					@newpla2=@newpla2.round(2)
					@plas2.push(@newpla2)
					@nop2-=12
					end	

					until @newpla2 <= 0 do
					@newpla2=(@newpla2-(12*@payment))*@ir
					@newpla2=@newpla2.round(2)
					@plas2.push(@newpla2)
					end

					@length2=@plas2.length
					@plas2[@length2-1]=0
					@years2 = @length2 -1


					@labels2=[]

						for g in 1..(@length2 - 1)
							@labels2.push(g)
						end

					if @plas2[@length2-1] <= 1
					@plas2[@length2-1]=0
					end

			else

					until @nop2 <= 0 do
					@newpla2=(@newpla2-(12*@payment)-@epa)*@ir
					@newpla2=@newpla2.round(2)
					@plas2.push(@newpla2)
					@nop2-=1
					end	

					until @newpla2 <= 0 do
					@newpla2=(@newpla2-(12*@payment))*@ir
					@newpla2=@newpla2.round(2)
					@plas2.push(@newpla2)
					end

					@length2=@plas2.length
					@plas2[@length-1]=0
					@years2 = @length2 -1



					@labels2=[]

						for g in 1..(@length2 - 1)
							@labels2.push(g)
						end

					if @plas2[@length2-1] <= 1
					@plas2[@length2-1]=0
					end
			end



				render 'mortgage'
			else
				render 'mortgage'
			end


#@formula_ytc.to_i.times do
				#@iterate = ((@formula_interest)**@formula_ytc)*((@formula_inflation)**@formula_yoc)
				#@iterate_sum = @iterate_sum+@iterate
				#@formula_ytc-=1
				#@formula_yoc+=1
			#end
			#@retirement_length.to_i.times do	
				#@iterate2 = ((@formula_interest)**@formula_retirement2)*((@formula_inflation2)**@formula_years2)
				#@iterate_sum2 = @iterate_sum2 + @iterate2
				#@formula_retirement2-=1
				#@formula_years2+=1
			#end
			#@formula=((@child_tuition*@iterate_sum)+(@child_living_expense*@iterate_sum2))/(@formula_interest**@retirement_length)


	end

	def insurance
	if params[:insurance]
		@childcareamount = params[:insurance][:childcareamount].to_f
		@childcarestartyear = params[:insurance][:childcarestartyear].to_f
		@childcareendyear = params[:insurance][:childcareendyear].to_f
		@lechildhomeamount = params[:insurance][:lechildhomeamount].to_f
		@lechildhomestartyear = params[:insurance][:lechildhomestartyear].to_f
		@lechildhomeendyear = params[:insurance][:lechildhomeendyear].to_f
		@lechildgoneamount = params[:insurance][:lechildgoneamount].to_f
		@lechildgonestartyear = params[:insurance][:lechildgonestartyear].to_f
		@lechildgoneendyear = params[:insurance][:lechildgoneendyear].to_f
		@childrencollegeamount = params[:insurance][:childrencollegeamount].to_f
		@childrencollegestartyear = params[:insurance][:childrencollegestartyear].to_f
		@childrencollegeendyear = params[:insurance][:childrencollegeendyear].to_f
		@retrainingspouseamount = params[:insurance][:retrainingspouseamount].to_f
		@retrainingstartyear = params[:insurance][:retrainingstartyear].to_f
		@retrainingendyear = params[:insurance][:retrainingendyear].to_f
		@oeamount=params[:insurance][:oeamount].to_f
		@oestartyear=params[:insurance][:oestartyear].to_f
		@oeendyear=params[:insurance][:oeendyear].to_f
		@yearstocover=params[:insurance][:yearstocover].to_f
		@rateearnedinvest=params[:insurance][:rateearnedinvest].to_f
		@inflation=params[:insurance][:inflation].to_f


		@deathduties=params[:insurance][:deathduties].to_f
		@probatecosts=params[:insurance][:probatecosts].to_f
		@funeralcosts=params[:insurance][:funeralcosts].to_f
		@uninsuredmedicalcosts=params[:insurance][:uninsuredmedicalcosts].to_f
		@debtrepayment = params[:insurance][:debtrepayment].to_f
		@collegefund1=params[:insurance][:collegefund1].to_f
		@collegefund2=params[:insurance][:collegefund2].to_f
		@collegefund3=params[:insurance][:collegefund3].to_f


		@spouseincomeamount = params[:insurance][:spouseincomeamount].to_f
		@spouseincomestart = params[:insurance][:spouseincomestart].to_f
		@spouseincomeyears = params[:insurance][:spouseincomeyears].to_f
		@otherincomeamount = params[:insurance][:otherincomeamount].to_f
		@otherincomestart = params[:insurance][:otherincomestart].to_f
		@otherincomeend = params[:insurance][:otherincomeend].to_f
		@cashandsavings = params[:insurance][:cashandsavings].to_f
		@homeequity = params[:insurance][:homeequity].to_f
		@investments = params[:insurance][:investments].to_f
		@other= params[:insurance][:other].to_f

		@inflation_rate=(@inflation/100)+1
		@ir=(@rateearnedinvest/100)+1

		@t1=@childcarestartyear+@childcareendyear
		@t2=@lechildhomestartyear+@lechildhomeendyear
		@t3=@lechildgonestartyear+@lechildgoneendyear
		@t4=@childrencollegestartyear+@childrencollegeendyear
		@t5=@retrainingstartyear+@retrainingendyear
		@t6=@oestartyear+@oeendyear
		@t7=@spouseincomestart+@spouseincomeyears
		@t8=@otherincomestart+@otherincomeend

		@totals=[@t1,@t2,@t3,@t4,@t5,@t5,@t6,@t7,@t8]
		@totaltimes=@totals.max 

		@earliestarray=[@childcarestartyear,@lechildhomestartyear,@lechildgonestartyear,@childrencollegestartyear,@retrainingstartyear,@oestartyear,@spouseincomestart,@otherincomestart]
		
		#childcare
			@childcarearray=[]
			#from 0 to start
			@first=@childcareamount*12
			

			@childcarestartyear.to_i.times do
				@childcarearray.push(0)
				@first=@first*@inflation_rate
			end

			#first year
			#rest of year
			@childcareendyear.to_i.times do
				@childcarearray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t1
			#after 0
			@remaining.to_i.times do
				@childcarearray.push(0)
			end

		#lechildhome
			@lechildhomearray=[]

			@first=@lechildhomeamount*12
	
			#from 0 to start
			@lechildhomestartyear.to_i.times do
				@lechildhomearray.push(0)
				@first=@first*@inflation_rate
			end
			#first year
			#rest of year
			@lechildhomeendyear.to_i.times do
				@lechildhomearray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t2
			#0
			@remaining.to_i.times do
				@lechildhomearray.push(0)
			end

		#lechildgone
			@lechildgonearray=[]
			@first=@lechildgoneamount*12
			#from 0 to start
			@lechildgonestartyear.to_i.times do
				@lechildgonearray.push(0)
				@first=@first*@inflation_rate
			end
			#first year
			#rest of year
			@lechildgoneendyear.to_i.times do
				@lechildgonearray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t3
			#after 0
			@remaining.to_i.times do
				@lechildgonearray.push(0)
			end

		#childrencollege
			@childrencollegearray=[]
			@first=@childrencollegeamount*12
			#from 0 to start
			@childrencollegestartyear.to_i.times do
				@childrencollegearray.push(0)
				@first=@first*@inflation_rate
			end
			#first year
			#rest of year
			@childrencollegeendyear.to_i.times do
				@childrencollegearray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t4
			#after 0
			@remaining.to_i.times do
				@childrencollegearray.push(0)
			end

		#retraining
			@retrainingarray=[]
			@first=@retrainingspouseamount*12
			#from 0 to start
			@retrainingstartyear.to_i.times do
				@retrainingarray.push(0)
				@first=@first*@inflation_rate
			end
			#first year
			#rest of year
			@retrainingendyear.to_i.times do
				@retrainingarray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t5
			#after 0
			@remaining.to_i.times do
				@retrainingarray.push(0)
			end
		#oe
			@oearray=[]
			@first=@oeamount*12
			#from 0 to start
			@oestartyear.to_i.times do
				@oearray.push(0)
				@first=@first*@inflation_rate
			end
			#first year
			#rest of year
			@oeendyear.to_i.times do
				@oearray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t6
			#after 0
			@remaining.to_i.times do
				@oearray.push(0)
			end

		#total
		@totalexpensearray=[]
		i=0
		@totaltimes.to_i.times do
			@sum=@childcarearray[i]+@lechildhomearray[i]+@lechildgonearray[i]+@childrencollegearray[i]+@retrainingarray[i]+@oearray[i]
			@totalexpensearray.push(@sum)
			i+=1
		end

		@remainder=@yearstocover-@totaltimes
		if @remainder > 0
		@remainder.to_i.times do
			@totalexpensearray.push(0)
		end
		end

		@spouseincomearray=[]
			@first=@spouseincomeamount*12
			#from 0 to start
			@spouseincomestart.to_i.times do
				@spouseincomearray.push(0)
				@first=@first*@inflation_rate
			end
			#first year
			#rest of year
			@spouseincomeyears.to_i.times do
				@spouseincomearray.push(@first)
				@first=@first*@inflation_rate
			end
			@remaining=@totaltimes-@t7
			#after 0
			@remaining.to_i.times do
				@spouseincomearray.push(0)
			end

		@otherincomearray=[]
		@first=@otherincomeamount*12
		#from 0 to start
		@otherincomestart.to_i.times do
			@otherincomearray.push(0)
			@first=@first*@inflation_rate
		end
		#first year
		#rest of year
		@otherincomeend.to_i.times do
			@otherincomearray.push(@first)
			@first=@first*@inflation_rate
		end
		@remaining=@totaltimes-@t8
		#after 0
		@remaining.to_i.times do
			@otherincomearray.push(0)
		end

		@totalincomearray=[]
		i=0
		@totaltimes.to_i.times do
			@sum=@spouseincomearray[i]+@otherincomearray[i]+0
			@totalincomearray.push(@sum)
			i+=1
		end

		@remainder=@yearstocover-@totaltimes
		if @remainder > 0
			@remainder.to_i.times do
				@totalincomearray.push(0)
			end
		end

		@investmentarray=[@investments]
		@differencearray=[]
		@investments2=@investments
		x=0
		@totaltimes.to_i.times do 
			if @totalexpensearray[x] > @totalincomearray[x]
				@investments2=(@investments2*@ir)+@totalincomearray[x]-@totalexpensearray[x]
				if @investments2 <0
					@investments2=0
				end
				@investmentarray.push(@investments2)
			else
				@investments2=@investments2*@ir
				@investmentarray.push(@investments2)
			end
			x+=1
		end
		x=0
		@totaltimes.to_i.times do 
				@difference =@investmentarray[x]+@totalincomearray[x]-@totalexpensearray[x]
				@differencearray.push(@difference)
				x+=1
		end

		@labels=[]
		x=0
		@labeltime=@totaltimes-1
		@labeltime.to_i.times do
			@labels.push(x)
			x+=1
		end

		@graph_expense=[]
		@totalexpensearray.each do |x|
			@graph_expense.push(x.round(2))
		end

		@graph_expense=@graph_expense.first @graph_expense.size - 1


		@graph_income=[]
		@totalincomearray.each do|x|
			@graph_income.push(x.round(2))
		end

		@graph_income=@graph_income.first @graph_income.size - 1

		@graph_investment=[]
		@investmentarray.each do|x|
			@graph_investment.push(x.round(2))
		end

		@different_sum=@differencearray.inject(0){|sum,x| sum + x }

		if @different_sum < 0
			@different_sum = @different_sum*-1
		elsif @different_sum > 0
			@different_sum = @different_sum*-1
		end


		@requirementtoday = @different_sum/((1+@ir-@inflation_rate)**@totaltimes)

		@otherstotal=@deathduties+@probatecosts+@funeralcosts+@uninsuredmedicalcosts+@debtrepayment+@collegefund1+@collegefund2+@collegefund3

		@assetstotal=@cashandsavings+@homeequity+@other

		@requirementtoday+=@otherstotal

		@requirementtoday-=@assetstotal

			render 'insurance'
		else
			render 'insurance'
		end
	end



end
