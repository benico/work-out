class ApplicationController < ActionController::Base
    layout :layout_by_resource

private

    def layout_by_resource
        devise_controller? ? "devise_layout" : "application"
      end
end
