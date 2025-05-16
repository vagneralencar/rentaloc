# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "admin-lte", to: "adminlte.js" 
pin "jquery-mask-plugin", to: "https://ga.jspm.io/npm:jquery-mask-plugin@1.14.16/dist/jquery.mask.js" # A URL ou caminho pode variar
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.min.js" # A URL ou caminho pode variar
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.0/lib/assets/compiled/rails-ujs.js"
pin "select2", to: "https://ga.jspm.io/npm:select2@4.1.0-rc.0/dist/js/select2.min.js"
pin "select2/dist/css/select2.min.css", to: "https://ga.jspm.io/npm:select2@4.1.0-rc.0/dist/css/select2.min.css"
