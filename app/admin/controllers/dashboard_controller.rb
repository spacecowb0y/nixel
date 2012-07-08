# This is a quick hack to remove the dashboard section
# of the admin panel and make the "Presupuestos" controller
# the default route.
module ActiveAdmin
  module Dashboards
    class DashboardController < ResourceController
      def index
        redirect_to admin_presupuestos_path
      end
    end
  end
end