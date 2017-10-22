
class Admin::AdminController < ApplicationController

  layout 'admin'

  before_action :admin_only
end