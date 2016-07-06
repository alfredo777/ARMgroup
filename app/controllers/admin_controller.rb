class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout "intern"
  def panel
  end

  def customers
    @customers = Customer.all
  end

  def new_customer
  end

  def create_customer
    @customer = Customer.create(email: params[:email], password: params[:password], name: params[:name], submname: params[:submname], empresa: params[:empresa], idempresa: params[:idempresa], route_files: params[:route_files])

    if @customer.save
      flash[:notice] = "Se ha creado correctamente el cliente"
      redirect_to admin_customers_path
    else
      flash[:notice] = "Ha ocurrido un error al crear el cliente"
      redirect_to admin_customers_path
    end
  end

  def edit_customer
    @customer = Customer.find(params[:id])
  end

  def update_customer
    @customer = Customer.find(params[:id])
    @customer.email = params[:email]
    @customer.route_files = params[:route_files]
    @customer.empresa = params[:empresa]
    @customer.idempresa = params[:idempresa]
    @customer.name = params[:name]
    @customer.submname = params[:submname]
    if !params[:password].nil?
      @customer.password = params[:password]
    end
    @customer.save(:validate => false)

    flash[:notice] = "Se ha actualizado el usuario correctamente."
    redirect_to :back

  end

  def delete_customer
    @customer = Customer.find(params[:id])
    @customer.destroy
    if @customer.destroy
      flash[:notice] = "Se ha elminado correctamente el client"
      redirect_to :back
    else
      flash[:notice] = "No ha podido ser eliminado el cliente"
      redirect_to :back
    end
  end

  def view_all_pages
    @pages = Dir.glob("#{Rails.root}/public/tpl/*.html")
    if params[:fileoppen] == nil
     oppenroute = @pages[0]
     else
     op = params[:fileoppen]
     oppenroute = @pages[op.to_i]
    end
    @route = oppenroute
    @oppen_page = File.read(oppenroute)
  end

  def  edit_pages
    @file = File.open(params[:file_route], 'w') { |file| file.write(params[:file_w]) }
    flash[:notice] = "Archivo guardado correctamente"
    redirect_to :back
  end
end
