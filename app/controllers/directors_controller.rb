class DirectorsController < ApplicationController
  def create
    m = Director.new
    m.name = params.fetch("director_name")
    m.dob = params.fetch("director_dob")
    m.bio = params.fetch("director_bio")
    m.image = params.fetch("director_image")

    m.save

    redirect_to("/directors")
    
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_record = Director.where({ :id => the_id})
    the_director = matching_record.at(0)
    the_director.destroy

    redirect_to("/directors")
  end

  def edit
    m_id = params.fetch("the_id")

    matching_record = Director.where({ :id => m_id})
    m = matching_record.at(0)

    m.name = params.fetch("director_name")
    m.dob = params.fetch("director_dob")
    m.bio = params.fetch("director_bio")
    m.image = params.fetch("director_image")

    m.save

    redirect_to("/directors/#{m.id}")
  end
  
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
