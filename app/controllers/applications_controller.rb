class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end

    if params[:pet_id].present?
      @application.pets << Pet.find(pet_params[:pet_id])
    end

    if params[:commit].present?
      @application.write_attribute(:description, params[:description])
      @application.write_attribute(:status, "Pending")
    end
  end

  # def update
  #   @application = Application.find(params[:id])
  #
  #   @application.write_attribute(:description, params[:description])
  #   @application.write_attribute(:status, "Pending")
  #
  #   redirect_back fallback_location: "/applications/#{@application.id}"
  # end



  def new
  end

  def create
    application = Application.create(name: application_params[:name],
                                     description: application_params[:description],
                                     status: application_params[:status])
    #ask how to encapsulate the below better
    address = application.create_address(street_address: application_params[:street_address],
                             city: application_params[:city],
                             state: application_params[:state],
                             zip_code: application_params[:zip_code])

    redirect_to "/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:name,
                  :street_address,
                  :city,
                  :state,
                  :zip_code,
                  :description,
                  :status,
                  :id)
  end

  def pet_params
    params.permit(:pet_id)
  end

  def submit_params
    params.permit(:description,
                  :commit)
  end

end
