class ActorsController < ApplicationController
  def edit
    m_id = params.fetch("the_id")

    matching_record = Actor.where({ :id => m_id})
    m = matching_record.at(0)

    m.name = params.fetch("actor_name")
    m.dob = params.fetch("actor_dob")
    m.bio = params.fetch("actor_bio")
    m.image = params.fetch("actor_image")

    m.save

    redirect_to("/actors/#{m.id}")
  end
  
  def destroy
    the_id = params.fetch("an_id")
    matching_record = Actor.where({ :id => the_id})
    the_actor = matching_record.at(0)
    the_actor.destroy

    redirect_to("/actors")
  end
  
  def create
    m = Actor.new
    m.name = params.fetch("actor_name")
    m.dob = params.fetch("actor_dob")
    m.bio = params.fetch("actor_bio")
    m.image = params.fetch("actor_image")

    m.save

    redirect_to("/actors")
  end
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
