Phonebook::Application.routes.draw do
  resources :contacts do
    collection do
      get 'autocomplete'
    end
  end

  mount Soulmate::Server, :at => '/sm'

  root :to => "contacts#index"
end
