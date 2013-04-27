class MissionsController < ApplicationController
  before_filter :check_for_mobile

  def show
    @mission = Mission.find(UUIDTools::UUID.parse(params[:id]))
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @mission }
    end
  end

  # Get the N (default 1) most recent missions
  # GET /missions/mostrecent
  # GET /missions/mostrecent/5
  def mostrecent
    count = params[:id] || 1
    render :json => Mission.find(:all, :limit => count, :order => 'started DESC')
                    .to_json(:only => [:id, :title, :number, :started])
  end

  def new

  end

  def create
    cmd = Commands::UpdateCommand.make(nil, 'Mission', params[:mission])
   
    respond_to do |format|
      if cmd.execute
        broadcast "missions/new", cmd.model.to_json

        format.html # new.html.erb
        format.json { render :json => cmd.model }
      else
        format.html { render :action => "new" }
        format.json { render :json => cmd.model.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    cmd = Commands::UpdateCommand.make(params[:id], 'Mission', params[:mission])

    respond_to do |format|
      if cmd.execute
        broadcast "missions/update", cmd.model.id.to_json

        format.html
        format.json { render :json => cmd.model }
      else
        format.html { render :action => "edit" }
        format.json { render :json => cmd.model.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    cmd = Commands::DestroyCommand.make(params[:id], 'Mission')
    if (cmd.execute) then
	    broadcast "missions/delete", "\"#{params[:id]}\""
	    render :json => params[:id]
    end
  end

end
