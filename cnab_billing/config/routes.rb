Rails.application.routes.draw do
  root "home#index"

  post '/import_file', to: 'importer#import_file'
end
