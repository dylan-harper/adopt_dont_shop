class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

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

end
