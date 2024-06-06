// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import  "custom/menu"
import Rails from "rails-ujs"
import  "custom/image_upload"

Rails.start()