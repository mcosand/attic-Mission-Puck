class LogsController < ApplicationController
	before_filter :find_mission

	before_filter :check_for_mobile

	def index
		@logs = @mission.logs.all( :order => '"when" DESC')
		respond_to do |format|
			format.html # index.html.erb
			format.json { render :json => @logs }
		end
	end

	def create
		log = @mission.logs.build(params[:log])
    act = CreateLogAction.new(:data => log.to_json, :when => Time.now, :source => "@#{`hostname`.strip}")

    val = false
    act.transaction do
      val = act.perform
      act.save
    end

    log = @mission.logs.find(act.reference)

		respond_to do |format|
			if val
		    broadcast "/logs/new", log.to_json

				format.html # new.html.erb
				format.json { render :json => log }
			else
				format.html { render :action => "new" }
				format.json { render :json => log.errors, :status => :unprocessable_entity }
			end
		end
	end

  def destroy
    log = @mission.logs.find(params[:id])
    act = DestroyLogAction.new(:data => {:id => log.id, :mission_id => log.mission_id}.to_json, :when => Time.now, :source => "@{`hostname`.strip}")

    act.transaction do
      act.perform
      act.save
    end

    broadcast "/logs/delete", params[:id]
    render :json => params[:id]
  end

	private
		def find_mission
			@mission = Mission.find(UUIDTools::UUID.parse(params[:mission_id]))
		end
end
