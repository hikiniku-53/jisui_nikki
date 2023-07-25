class Public::DiariesController < ApplicationController
  before_action :authenticate_customer!
end
