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
    act = CreateMissionAction.new(:data => params[:mission], :when => Time.now, :source => "@#{`hostname`.strip}")

    val = false
    act.transaction do
      val = act.perform
      act.save
    end
    
    respond_to do |format|
      if val
        broadcast "/missions/new", act.created.to_json

        format.html # new.html.erb
        format.json { render :json => act.created }
      else
        format.html { render :action => "new" }
        format.json { render :json => act.created.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    act = UpdateMissionAction.new(:data => params[:mission], :reference => UUIDTools::UUID.parse(params[:id]),
                                  :when => Time.now, :source => "@#{`hostname`.strip}")

    val = false
    act.transaction do
      val = act.perform
      act.save
    end

    respond_to do |format|
      if val
        broadcast "/missions/update", act.model.id

        format.html
        format.json { render :json => act.model }
      else
        format.html { render :action => "edit" }
        format.json { render :json => act.model.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    m = Mission.find(params[:id])
    act = DestroyMissionAction.new(:data => m.id.to_json, :when => Time.now, :source => "@{`hostname`.strip}")

    act.transaction do
      act.perform
      act.save
    end

    broadcast "/missions/delete", params[:id]
    render :json => params[:id]
  end

end
