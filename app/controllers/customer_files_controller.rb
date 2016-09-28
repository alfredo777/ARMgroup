class CustomerFilesController < ApplicationController
  before_action :authenticate_any!, only: [:open_file, :audio_search, :audio_search_files, :zip_compress_download, :create_backup]
  before_action :authenticate_customer!, except: [:open_file, :audio_search, :audio_search_files, :zip_compress_download, :create_backup]
  layout "intern"

  def shared
    @customer = current_customer
    @files = @customer.shared_files.paginate(:page => params[:page], :per_page => 12).order('id DESC')

  end

  def open_file
   @file = SharedFile.find(params[:id])
   @type = @file.name.split('.').last 
   if current_customer
   ahoy.track "Open File", title: "El archivo fue abierto #{@file.name} por #{current_customer.email} - #{Time.now}", customer:current_customer.id, archivo:params[:id].to_i
   end
  end

  def audio_search
    require 'will_paginate/array'

    customer = current_customer if current_customer
    customer = Customer.find(params[:id]) if !current_customer
    hoy = Date.today

    hace_10_dias = Date.today - 4.days
    puts hoy
    puts hace_10_dias

    array_dates = []
    4.times do |i|
      date = hoy - i.day
      date = "#{date.strftime('%Y''%m')}/#{date.strftime('%Y''%m''%d')}"
      date = date.to_s
      array_dates.push(date)
    end
    audios_result = []
    real_routes = []
    conlection_for_dates = []
    array_dates.each do |araydate|
      routeAU = "#{Rails.root}/public/audios/#{araydate}/*"
      audios_result_no_tuning = Dir.glob(routeAU)
      ###### estrayendo audios ######
      audios_result_no_tuning.each do |r|
        full_name = r.split('/').last
        components = full_name.split('-')
        campaign = components[4].to_s
        customer.campaings.each do |codecampaing|
          if campaign == codecampaing.campaing_code
            real_routes.push(full_adress: "#{r}", name:"#{full_name}")
            rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
            audios_result.push({url: "#{rinx}"})
          end
        end
      end
    end
    ahoy.track "Ingreso a los audios", title: "Se ha ingresado a los audios por #{customer.email} - #{Time.now}", customer:customer.id, campaign: params[:code]
    conde_entreviwer = "OUT"
    phone = "9"
    @scoped_audios_results = result_audios_proccess_no_campaing(audios_result, conde_entreviwer, phone) 
    @scoped_audios_results = @scoped_audios_results.paginate(:page => params[:page], :per_page => 50)
    @data = real_routes 
    @multi_download_file_name = "" 
    @customer = customer
  end

  def audio_selected
  end

  def audio_search_files
    require 'will_paginate/array'
    customer = current_customer if current_customer
    customer = Customer.find(params[:id]) if !current_customer
    conde_entreviwer = "OUT#{params[:conde_entreviwer]}"
    phone = "9#{params[:phone]}"
    @customer = customer
    if !params[:hour].nil?
    hour = "#{params[:hour]}#{params[:minute]}"
    
    if hour.mb_chars.length == 4
      hour = hour
    else
      hour = "0#{hour}"
    end

    else
    hour = "000"
    end

    puts "******************>>>>>>>>>#{hour}<<<<<<<<<<<<<****************************"
    puts params
    ##### dates #######
    format_date = params[:date].gsub!('/',',')
    if !params[:todate].empty?
    format_second_date = params[:todate].gsub!('/',',')
    end
    arr = format_date.split(',').collect! {|n| n.to_i}
    if !params[:todate].empty?
    arr2 = format_second_date.split(',').collect! {|n| n.to_i}
    end


    if params[:todate].empty? 
    format_date = Date.new(arr[2],arr[0],arr[1])
    year = arr[2].to_s
    month = arr[0]
    if "#{arr[0]}".mb_chars.length == 2
      month = arr[0]
    else
      month = "0#{arr[0]}"
    end
    day = arr[1].to_s
    routeAU = "#{Rails.root}/public/audios/#{year}#{month}/#{year}#{month}#{day}/*"
    t = Time.new
    t = t.to_f
    multi_download_name = "#{Rails.root}/public/audiosdown/#{year}#{month}#{day}/#{format_date}-#{t}.zip"
    puts routeAU
    audios_result_no_tuning = Dir.glob(routeAU)
    audios_result = []
    real_routes = []
    audios_result_no_tuning.each do |r|
      full_name = r.split('/').last
      components = full_name.split('-')
      campaign = components[4]
      myhour = components[2].to_s
      myhour = myhour.slice(0,4)

      if hour == "000"
        if params[:code].empty?
          customer.campaings.each do |codecampaing|
            if campaign.to_i == codecampaing.campaing_code.to_i
              puts "**********************parte 1"
              real_routes.push(full_adress: "#{r}", name:"#{full_name}")
              rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
              audios_result.push({url: "#{rinx}"})
            end
          end 
        else
          if campaign.to_i == params[:code].to_i
            real_routes.push(full_adress: "#{r}", name:"#{full_name}")
            rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
            audios_result.push({url: "#{rinx}"})
          end
        end
      else
        if myhour == hour
          timevalidate = true
        else
          timevalidate = false
        end
        if timevalidate
            if params[:code].empty?
              customer.campaings.each do |codecampaing|
                  if campaign.to_i == codecampaing.campaing_code.to_i
                    real_routes.push(full_adress: "#{r}", name:"#{full_name}")
                    rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
                    audios_result.push({url: "#{rinx}"})
                  end
              end 
            else
              if campaign.to_i == params[:code].to_i
                real_routes.push(full_adress: "#{r}", name:"#{full_name}")
                rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
                audios_result.push({url: "#{rinx}"})
              end
            end
          else
          puts "Hora no coincide #{myhour}"
          end

      end
    end
    ahoy.track "Search File", title: "Se ha realizado una busqueda de archivos de la campaña #{params[:code]} por #{customer.email} - #{Time.now}", customer:customer.id, campaign: params[:code]
    
    if params[:code].empty?
      @scoped_audios_results = result_audios_proccess_no_campaing(audios_result, conde_entreviwer,phone)  
      @data = real_routes 
      @multi_download_file_name = multi_download_name 
      @name_file = format_date
      @campaign = "all"
    else
    @scoped_audios_results = result_audios_proccess(audios_result,params[:code], conde_entreviwer, phone)  
    @data = real_routes 
    @multi_download_file_name = multi_download_name 
    @name_file = format_date
    @campaign = params[:code]
    end
    else
    ######  filtrado por dos fechas #######
    d1 = Date.new(arr[2],arr[0],arr[1])
    d2 = Date.new(arr2[2],arr2[0],arr2[1])

    if d1 == d2
       d2 = d2 + 1.day
       d1 = d1 - 1.day
    end

    days_into_date = (d2 - d1).to_i
    puts days_into_date
    puts d1
    puts d2



    array_dates = []

    days_into_date.times do |i|
      date = d2 - i.day
      date = "#{date.strftime('%Y''%m')}/#{date.strftime('%Y''%m''%d')}"
      date = date.to_s
      array_dates.push(date)
    end

    #puts array_dates
    ###### preocesando resultados #######
    audios_result = []
    real_routes = []
    array_dates.each do |araydate|
      #puts araydate
      routeAU = "#{Rails.root}/public/audios/#{araydate}/*"
      audios_result_no_tuning = Dir.glob(routeAU)
      ###### estrayendo audios ######
      audios_result_no_tuning.each do |r|
        #puts r
        full_name = r.split('/').last
        components = full_name.split('-')
        campaign = components[4].to_s
        myhour = components[2].to_s
        myhour = myhour.slice(0,4)
         

        if  hour != "000"
          if myhour.to_i == hour.to_i
            timevalidate = true
            puts "#{myhour} ********** #{hour} "
            puts "timevalidate verdadero"
          else
            timevalidate = false
          end

          if timevalidate
            if params[:code].empty?
              puts "Ingresando a campañas "
              customer.campaings.each do |codecampaing|
                if "#{campaign}" == "#{codecampaing.campaing_code}"
              
                  real_routes.push(full_adress: "#{r}", name:"#{full_name}")
                  rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
                  audios_result.push({url: "#{rinx}"})
                  puts "#{r} - #{full_name} - #{rinx}"
                end
              end
            else
              puts "comparando #{params[:code]} vs #{campaign}"
              if "#{params[:code]}" == "#{campaign}"
                real_routes.push(full_adress: "#{r}", name:"#{full_name}")
                rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
                audios_result.push({url: "#{rinx}"})
                puts "#{r} - #{full_name} - #{rinx}"
              end
            end
          else
           # puts "Hora no coincide con busqueda"
          end
        else
          if params[:code].empty?
            customer.campaings.each do |codecampaing|
              if campaign == codecampaing.campaing_code
                real_routes.push(full_adress: "#{r}", name:"#{full_name}")
                rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
                audios_result.push({url: "#{rinx}"})
              end
            end
          else
          puts "tipo n ********************** date"
            if params[:code].to_i == campaign.to_i
              real_routes.push(full_adress: "#{r}", name:"#{full_name}")
              rinx = r.gsub!("#{Rails.root}/public", "#{host_url}")
              audios_result.push({url: "#{rinx}"})
            end
           
          end
        end
       
      end
    end
    
    ahoy.track "Busqueda de audios a los audios", title: "Busqueda de audios del #{d1} al #{d2} por #{customer.email} - #{Time.now}", customer:customer.id, campaign: params[:code]
    @scoped_audios_results = result_audios_proccess_no_campaing(audios_result, conde_entreviwer,phone) 
    #puts @scoped_audios_results 
    @data = real_routes 
    @name_file = d2
    t = Time.new
    t = t.to_f
    @multi_download_file_name =  "#{Rails.root}/public/audiosdown/#{d2.strftime('%Y''%m''%d')}/#{d2}-#{t}.zip"
    dir = "#{Rails.root}/public/audiosdown/#{d2.strftime('%Y''%m''%d')}"
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    end
  end

  def zip_compress_download
    customer = current_customer if current_customer
    customer = current_admin if !current_customer
    require 'zip'
    data = eval(params[:data])
    zipfile_name = params[:file_name]
    puts data
    puts zipfile_name
    name_file = params[:name_file] 
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      data[:acdata].each do |d|
        adress  = d[:full_adress]
        name = d[:name]
        zipfile.add(name, adress)
      end
      zipfile.get_output_stream("#{name_file}-#{Time.now}") { |os| os.write "Archivo compreso de #{name_file} descargado #{Time.now}" }
    end
    rinx = zipfile_name.gsub!("#{Rails.root}/public", "#{host_url}")
    ahoy.track "Download zip File", title: "Se ha descargado #{name_file}-#{Time.now} por #{customer.email} - #{Time.now}", customer:customer.id, archivo: rinx

    redirect_to "#{rinx}"
  end

  def create_backup
    customer = current_customer if current_customer
    customer = Customer.find(params[:id]) if !current_customer
     require 'zip'
     new_folder = "#{Rails.root}/public/backups/#{customer.id}"
     unless File.directory?(new_folder)
       FileUtils.mkdir new_folder
       else
        puts "El directorio ya existe se prosede a guardar el respaldo"
     end
     t = Time.new
     t = t.to_f
     name_file = "campaña-#{params[:campaign]}c-#{t}-#{Time.now}.zip"
     zipfile_name = new_folder +"/"+ name_file
      data = eval(params[:data])
      puts zipfile_name
      Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
        data[:acdata].each do |d|
          adress  = d[:full_adress]
          name = d[:name]
          zipfile.add(name, adress)
        end
        zipfile.get_output_stream("#{name_file}") { |os| os.write "Archivo compreso de #{name_file} descargado #{Time.now}" }
      end
      rinx = zipfile_name.gsub!("#{Rails.root}/public", "#{host_url}")
      ahoy.track "Backup zip File", title: "Se ha respaldado #{name_file}-#{Time.now} por #{customer.email} - #{Time.now}", customer:customer.id, archivo: rinx
  end

  def view_backups
    folder_backups = "#{Rails.root}/public/backups/#{current_customer.id}"
     if File.directory?(folder_backups)
       @data = Dir.glob("#{Rails.root}/public/backups/#{current_customer.id}/*")
       backup_result = []
       @data.each do |r|
        puts r
        backup_result.push({real_path: "#{r}", url: "#{r.gsub!("#{Rails.root}/public", "#{host_url}")}"})
       end
       @data = backup_result
       else
       @data = 0
     end
  end

  def delete_backup

    FileUtils.rm params[:real_path]
    flash[:notice] = "Se ha eliminado correctamente el respaldo"
    redirect_to :back
    
  end

  def notify
    @notices = Notice.where(customer_id: current_customer.id).paginate(:page => params[:page], :per_page => 2).order('id DESC')
  end

  def result_audios_proccess(audios_result, campaign_code, conde_entreviwer, phone)
    proces_results = []
    audios_result.each do |au|
      url = au[:url]
      full_name = au[:url].split('/').last
      components = full_name.split('-')
      entreviwer = components[0]
      audio_date = components[1].to_date
      campaign = components[4].to_s
      phone_i = components[3].to_s
      name = components[5].to_s

      case conde_entreviwer
      when 'OUT'
        ent = true
      when entreviwer    
        ent = true
      when !entreviwer && !'OUT'
        ent = false
      end

      case phone 
      when "9"
        pho = true
      when phone_i
        pho = true
      when !phone_i && !'9'
        pho = false
      end
      if campaign_code.to_s == campaign 
        if ent && pho
        proces_results.push({
          url: url,
          full_name: full_name,
          name: name,
          date: audio_date,
          campaign: campaign,
          components: components
        })
        end
      end
    end

    @result = proces_results.to_a
    puts "#{@result.count} ---- total a enviar "
    @result
  end

  def result_audios_proccess_no_campaing(audios_result, conde_entreviwer, phone)
    proces_results = []
    audios_result.each do |au|
      url = au[:url]
      full_name = au[:url].split('/').last
      components = full_name.split('-')
      entreviwer = components[0]
      audio_date = components[1].to_date
      campaign = components[4].to_s
      phone_i = components[3].to_s
      name = components[5].to_s

      case conde_entreviwer
      when 'OUT'
        ent = true
      when entreviwer    
        ent = true
      when !entreviwer && !'OUT'
        ent = false
      end


      case phone 
      when "9"
        pho = true
      when phone_i
        pho = true
      when !phone_i && !'9'
        pho = false
      end

      if ent && pho
      proces_results.push({
        url: url,
        full_name: full_name,
        name: name,
        date: audio_date,
        campaign: campaign,
        components: components
      })
     end
    end

    @result = proces_results.to_a
    puts "#{@result.count} ---- total a enviar "
    @result

  end



end
