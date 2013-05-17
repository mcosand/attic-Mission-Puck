class CommandsController < ApplicationController
  def index
    @logs = Commands::Command.all( :order => '"when" DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @logs }
    end
  end
end
