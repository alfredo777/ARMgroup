class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout "intern"
  def panel
    @visit = Ahoy::Event.paginate(:page => params[:page], :per_page => 10).order('time DESC')
  end

  def customers
    @customers = Customer.paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end

  def new_customer
  end

  def notify
    @notices = Notice.where(customer_id: params[:customer]).paginate(:page => params[:page], :per_page => 2).order('id DESC')
  end

  def campaings
    @customer = Customer.find(params[:id])
    @campaing = @customer.campaings.paginate(:page => params[:page], :per_page => 10).order('id DESC')
  end

  def create_campaing
    campaing = Campaing.new
    campaing.customer_id = params[:customer_id]
    campaing.admin_id = params[:admin_id]
    campaing.campaing_code = params[:code]
    campaing.campaing_title = params[:title]
    campaing.active = true
    campaing.restrict_audio_download = false
    campaing.save

    if campaing.save 
     flash[:notice] = "Campaña creada correctamente"
   else
     flash[:notice] = "La campaña no pudo ser creada"
   end
   redirect_to :back
  end

  def delete_campaing
    campaing = Campaing.find(params[:id])
    campaing.destroy
    flash[:notice] = "Se ha eliminado la campaña correctamente"
    redirect_to :back
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

  def library
    @customer = Customer.find(params[:id])
    @files = @customer.shared_files.paginate(:page => params[:page], :per_page => 12).order('id DESC')
  end


  def files_add
    @share_file = SharedFile.new
    @share_file.admin_id = current_admin.id
    @share_file.url = params[:file]
    @share_file.fileable_type = "Customer"
    @share_file.fileable_id = params[:id]
    @share_file.save

    if @share_file.save
      @share_file.name = "#{@share_file.url}".split('/').last
      @share_file.save
      notify = Notice.new
      notify.customer_id = params[:id]
      notify.admin_id = current_admin.id
      notify.content = "<a href='#{open_file_path(id: @share_file.id)}'>#{@share_file.name}</a>"
      notify.owner_id = current_admin.id
      notify.owner_type = "Admin"
      notify.save
      notice = "<h3>Usted ha recibido una notificación de Archivo compartido ingrese a ARM para responderla | <a href='#{host_url}/customer_files/notify'>Ingresar</a> </h3>"
      toemail = Customer.find(params[:id])
      fromemail = "contacto@research-ss.com"
      #toemail = "alfredo@rockstars.mx"
      mail = ContactMailer.notify_me(fromemail,toemail,notice).deliver_now
    end

    respond_to do |format|
      format.js
    end
  end

  def delete_file
    if current_admin
    @share_file = SharedFile.find(params[:id])
    @share_file.destroy

    if @share_file.destroy
      ahoy.track "Destroy File", title: "Archivo #{@share_file.name} destruido por #{current_admin.email}"

      flash[:notice] = "Archivo eliminado correctamente"
      redirect_to :back

    end
    else
      flash[:notice] = "Usted no esta autorizado para eliminar el archivo"
      redirect_to :back
    end
  end

  def library_event
   event = Ahoy::Event.where(name: "Open File")
   @event = event.where(customer_act_search(params[:file],'archivo'))
  end

  def  edit_pages
    @file = File.open(params[:file_route], 'w') { |file| file.write(params[:file_w]) }
    flash[:notice] = "Archivo guardado correctamente"
    redirect_to :back
  end

end
