Rails.application.routes.draw do
	root 'calculators#investment_calculator'

	post '/calculators_controller/output', to:'calculators#output'

	post '/calculators_controller/output2', to:'calculators#output2'

	post '/calculators_controller/output3', to:'calculators#output3'
	post '/investment_calculator', to:'calculators#investment_calculator'
	post '/retirement_planner', to:'calculators#retirement_planner'
	post '/education_calculator', to:'calculators#education_calculator'
	get '/lumpsum', to:'calculators#lumpsum'
	get '/targetsavings', to:'calculators#targetsavings'
	get '/investment_calculator', to:'calculators#investment_calculator'
	get '/retirement_planner', to:'calculators#retirement_planner'
	get '/education_calculator', to:'calculators#education_calculator'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
