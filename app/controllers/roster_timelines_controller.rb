class RosterTimelinesController < ApplicationController
  before_filter :find_mission

  before_filter :check_for_mobile

  def create
     timeline_args = params[:timeline]
     timelineAction = CreateTimelineAction.new(
                        :data => timeline_args,
                        :when => Time.now, :source => "@#{`hostname`.strip}")

     responder_id = timelineAction.data['responder_id']
     success = false
     errors = { :timeline => nil, :responder => nil, :unit => nil }
     timelineAction.transaction do

       if timelineAction.data['responder_id'] == nil then
         responder_args = params[:responder]
         if responder_args == nil then raise ActiveRecord::Rollback end
         responder_args['mission_id'] = @mission.id.to_s
         responderAction = CreateResponderAction.new(
                             :data => responder_args,
                             :when => Time.now, :source => "@#{`hostname`.strip}")

         responderAction.perform
         timelineAction.data[:responder] = responderAction.created
         responder_id = responderAction.created.id.to_s
         responderAction.save
       end

       if timelineAction.data['unit_id'] == nil then
         unit_args = params[:unit]
         if unit_args == nil then raise ActiveRecord::Rollback end

         unit_args['mission_id'] = @mission.id.to_s
         unitAction = CreateUnitAction.new(
                        :data => unit_args,
                        :when => Time.now, :source => "@#{`hostname`.strip}")
         unitAction.perform
         timelineAction.data[:unit] = unitAction.created
         unitAction.save
       end

       timelineAction.perform
       timelineAction.save
       success = true
     end
             
     if (success) then
       json = timelineAction.created.responder.to_json(:include => { :current => {:include => { :unit => { :only => ["name"] } }, :except => ["id"] } })
 
       broadcast "/responders/update", json
       render :json => json
     else
       render :json => errors, :status => :unprocessable_entity
     end

#     responder_args = timeline_args['responder']
#     unit_args = timeline_args['unit']

#     timelineAction = CreateTimelineAction.new(
#                        :data => timeline_args.reject{|k,v| k == "responder"},
#                        :when => Time.now, :source => "@#{`hostname`.strip}")
    
#     val = false
#     timelineAction.transaction do
#       if (responder_args['id']) then
#         timelineAction.data['responder_id'] = responder_args['id']
#       else
#         responder_args['mission_id'] = @mission.id.to_s
#         responderAction = CreateResponderAction.new(
#                             :data => responder_args,
#                             :when => Time.now, :source => "@#{`hostname`.strip}")
#         responderAction.perform
#         timelineAction.data['responder_id'] = responderAction.created.id
#         responderAction.save
#       end

#       if (unit_args['id']) then
#         timelineAction.data['unit_id'] = unit_args['id']
#       else
#         unit_args['mission_id'] = @mission.id.to_s
#         unitAction = CreateUnitAction.new(
#                        :data => unit_args,
#                        :when => Time.now, :source => "@#{`hostname`.strip}")
#         unitAction.perform
#         timelineAction.data['unit_id'] = unitAction.created.id
#         unitAction.save
#       end

#       val = timelineAction.perform
#       timelineAction.save
#     end

#     responder = Responders.find(UUIDTools::UUID.parse(responder_args['id']))
#    args = params[:log]
#    args['mission_id'] = @mission.id.to_s
#    act = CreateLogAction.new(:data => args, :when => Time.now, :source => "@#{`hostname`.strip}")

#    val = false
#    act.transaction do
#      val = act.perform
#      act.save
#    end

#    respond_to do |format|
#      if val
#        broadcast "/logs/new", act.created.to_json

#        format.html # new.html.erb
#        format.json { render :json => act.created }
#      else
#        format.html { render :action => "new" }
#        format.json { render :json => act.created.errors, :status => :unprocessable_entity }
#      end
#    end


#    render :json => 5;
  end

  private
    def find_mission
      @mission = Mission.find(UUIDTools::UUID.parse(params[:mission_id]))
    end
end
