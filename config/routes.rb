Rails.application.routes.draw do
	root 'calculators#investment_calculator'

	post '/calculators_controller/output', to:'calculators#output'

	post '/calculators_controller/output2', to:'calculators#output2'

	post '/calculators_controller/output3', to:'calculators#output3'
	post '/investment_calculator', to:'calculators#investment_calculator'
	post '/calculators_controller/educationoutput', to:'calculators#educationoutput'
	get '/lumpsum', to:'calculators#lumpsum'
	get '/targetsavings', to:'calculators#targetsavings'
	get '/investment_calculator', to:'calculators#investment_calculator'
	get '/education', to:'calculators#education'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
