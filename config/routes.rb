Rails.application.routes.draw do
	root 'calculators#calc1'

	post '/calculators_controller/output', to:'calculators#output'

	post '/calculators_controller/output2', to:'calculators#output2'

	post '/calculators_controller/output3', to:'calculators#output3'
	get '/lumpsum', to:'calculators#lumpsum'
	get '/targetsavings', to:'calculators#targetsavings'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
