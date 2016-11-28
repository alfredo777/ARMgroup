class ReporteadorController < ApplicationController
  layout "internreporteador"
  #caches_page :public_view

  #caches_page :show
  def index
  end

  def load_base
  end

  def upload_base
     @report_base = RequestBaseToReport.new
     @report_base.csv_adress = params[:file] 
     @report_base.campaing_id = params[:campaing]
     @report_base.save

     if  @report_base.save
       table = read_table(@report_base.csv_adress)
       @report_base.update_attribute(:base_in_text, "#{table}")
       puts @report_base
       puts "El atributo del registro #{@report_base.id} ha sido actualizado"
       flash[:notice] = "Base de datos preparada"
     else
       flash[:notice] = "Error de prepración"
     end

     redirect_to :back

  end

  def add_view_access
    @report = ReportDinamicView.new
    @report.function_or_index = params[:indx]
    @report.campaing_id = params[:campaing]
    if params.has_key?(:function) 
    @report.function = params[:function]
    end
    if params.has_key?(:params_to_send) 
      @report.html_content = params[:params_to_send].to_json
    end
    @report.save
    @hid = params[:proccessid]
    respond_to do |format|
      format.js
    end
  end

  def delete_view_acces
   cind =  ReportDinamicView.where(campaing_id: params[:camping], function_or_index: params[:indx])
   cind.each do |er|
     er.destroy
   end

   redirect_to :back
  end


  def add_text_view_acces
    cind =  ReportDinamicView.where(campaing_id: params[:camping], function_or_index: params[:indx])
    cind.each do |er|
    er.legend = params[:text]
    er.save
    end

    redirect_to :back
  end

  def public_view
    require "csv"
    @report_parts = ReportDinamicView.where(campaing_id: params[:campaing])
    name_table = RequestBaseToReport.find(params[:id])
    @table_in = name_table
    table = eval(name_table.base_in_text)
    @hashx = table[:data]
    heads = table[:heads]

    @n = @hashx.count
    @heads  = head_clean(heads)
    head_array = []
    heads.each_with_index do |head, index|
      head_array.push(head)
    end

    @head_array = "#{head_array}"


    grouped = agrop_by_function(@hashx, "DataCollection.StartTime", true)
    @group = grouped[:arrayIN]
    puts @group

    @campaing = Campaing.find(params[:campaing])
    @work_schema = @campaing.work_schemas.last
    @post = "lol"
    respond_to do |format|
      format.html { render layout: "second_intern" }
      #format.pdf  { 
       # html = render_to_string(:layout => false , :action => "public_view", :formats => :html)
       # kit = PDFKit.new(html)
        #kit.stylesheets << "#{Rails.root}/public/stylesheets/application.scss"
       # send_data(kit.to_pdf, :filename => "ARM informe #{@campaing.campaing_title}.pdf",
        #  :type => 'application/pdf', :disposition => 'inline')        
        #return
       #}
    end

  end

  def view_base
    require "csv"
    name_table = RequestBaseToReport.find(params[:id])
    @table_in = name_table
    table = eval(name_table.base_in_text)
    @hashx = table[:data]
    heads = table[:heads]

    @n = @hashx.count
    @heads  = head_clean(heads)
    head_array = []
    heads.each_with_index do |head, index|
      head_array.push(head)
    end

    @head_array = "#{head_array}"


    grouped = agrop_by_function(@hashx, "DataCollection.StartTime", true)
    @group = grouped[:arrayIN]
    puts @group

    @campaing = Campaing.find(params[:campaing])
    @work_schema = @campaing.work_schemas.last

  end

  def agroup_var_in_my_table
    name_table = RequestBaseToReport.find(params[:id])
    table = eval(name_table.base_in_text)
    @hashx = table[:data]
    @group = agrop_by_function(@hashx, params[:agroupby], params[:date], true) 
    @variable = params[:agroupby]
    hash_chart = @group[:arrayIN]
    @to_id = params[:to_id]
    @campaing = name_table.campaing
    @name_t = name_table


    @n = @hashx.count

    array_chart = []

    hash_chart.each do |aa|
      array_chart.push({name:aa[0],y:(aa[1].to_f * 100).round(2)})
    end

    @chart_data = array_chart.to_json


    puts @group

    respond_to do |format|
      unless params.has_key?(:js) 
      format.html
      else
      format.js
      end
    end
  end

  def agroup_two_or_mor_vars_in_my_table
    name_table = RequestBaseToReport.find(params[:id])
    table = eval(name_table.base_in_text)
    @hashx = table[:data]
    @to_id = params[:to_id]
    @campaing = name_table.campaing
    @name_t = name_table

    variables = params[:vars].split(',')
    varacces = []
    variables.each do |v|
      varacces.push("#{v}")
    end 

    @n = @hashx.count

    @head = variables
    puts "#{varacces}"   
    @data = advanced_agrouped(@hashx, varacces)
    puts @data
    @variables = variables

    respond_to do |format|
     unless params.has_key?(:js) 
      format.html
      else
      format.js
      end
    end
  end

  def crossover_of_variables
    ###### datos generales para operaciones #######
    name_table = RequestBaseToReport.find(params[:id])
    table = eval(name_table.base_in_text)
    @hashx = table[:data]
    @campaing = name_table.campaing
    @name_t = name_table
    @to_id = params[:to_id]
    @n = @hashx.count


    ###### columna ########

    columnas = params[:cols].split(',')
    varcols = []
    columnas.each do |v|
      varcols.push("#{v}")
    end 

    @columnas = columnas

    ###### fila #########

    filas = params[:rows].split(',')
    varfils = []
    filas.each do |v|
      varfils.push("#{v}")
    end 

    @filas = filas

    ####### cruce ########

    @data = multiple_variable_crossover(@hashx,varcols,varfils)
    @table =  @data[:data]
    @x = @data[:values_in_col]
    @y = @data[:values_in_row]

    respond_to do |format|
      unless params.has_key?(:js) 
      format.html
      else
      format.js
      end
    end
  end
private 
  ######## lector de tablas #######
  def read_table(name_table)
    require "csv"
    readCsv = "#{Rails.root}/public#{name_table}"
    varoni = []

    n = 0

    headers = extract_heads(readCsv)

    new_file = CSV.foreach(readCsv, { :headers => true, :skip_blanks => true, encoding:'iso-8859-1:utf-8',:row_sep => :auto, :col_sep => ";"}) do |row|
      headhers = {}

      headers.each do |h|
        headhers["#{h}"] = row.to_h["#{h}"]
      end
      varoni.push(headhers)

    end
    @varoni = {data: varoni, heads: headers}
  end

  ###### lectura de cabezales de la tabla #######
  def extract_heads(name_table)
    headers = CSV.read(name_table, { :headers => true, :skip_blanks => true, encoding:'iso-8859-1:utf-8',:row_sep => :auto, :col_sep => ";"}).headers
    @heads = headers
  end
  ########## agrupación de tablas por parametro #############
  def agrop_by_function(datacollection, param_to_agroup, type_date, porcent=false)
    if porcent
     porcent = datacollection.count
     else
     porcent = 1
    end
    agroup_array = []
    last_group_array = []
    @hashx.each_with_index do |h, index|
      data_collection = {}
      if type_date == true
        groped_x = h[param_to_agroup].to_date
      else
        groped_x = h[param_to_agroup]
      end
      data_collection[:group_factor] = groped_x

      agroup_array.push(data_collection)
    end
    if type_date == true
    hashedART = {}
    group_hash = agroup_array.group_by_day { |u| u[:group_factor] }.map { |k, v| hashedART["#{k}"] = v.size.to_f/porcent.to_f }
    group_hash = hashedART
    puts group_hash
    #group_array = agroup_array.group_by_day { |u| u[:group_factor] }.map { |k, v| last_group_array.push(v.size) }
    #puts group_array
    group_array = agroup_array.group_by_day { |u| u[:group_factor] }.map { |k, v| ["#{k}", v.size.to_f/porcent.to_f] }
    puts group_array
    else
    hashedART = {}
    group_hash = agroup_array.group_by { |u| u[:group_factor] }.map { |k, v| 
    hashedART[ if !k.nil?
      "#{k}".downcase 
      else
      "null"
      end
    ] = v.size.to_f/porcent.to_f }
    group_hash = hashedART
    puts group_hash
    #group_array = agroup_array.group_by { |u| u[:group_factor] }.map { |k, v| last_group_array.push(v.size) }
    #puts group_array
    group_array = agroup_array.group_by { |u| u[:group_factor] }.map { |k, v| [
      if !k.nil?
      "#{k}".downcase 
      else
      "null"
      end, v.size.to_f/porcent.to_f] }
    puts group_array
    end

    @grouped = {arrayIN: group_array, hashIN: group_hash }
  end

  def advanced_agrouped(datacollection, params_to_agroup)
    porcent = datacollection.count
    puts params_to_agroup
    agroup_array = []

    @hashx.each_with_index do |h, index|
        data_collection = {}
        params_to_agroup.each do |param_to_agroup|
        groped_param = h[param_to_agroup]
        data_collection[param_to_agroup] = groped_param
        end
        agroup_array.push(data_collection)
    end
      
    last_group_array = []
    params_to_agroup.each do |column|
       agroup_array_x = []
       @hashx.each_with_index do |h, index|
        data_collection = {}
        groped_x = h[column]
        data_collection[column] = groped_x
        agroup_array_x.push(data_collection)
      end

      hashedART = {}
      group_hash = agroup_array_x.group_by { |u| u[column] }.map { |k, v| 
      hashedART[ if !k.nil?
        "#{k}".downcase 
        else
        "null"
        end
      ] = v.size.to_f/porcent.to_f }
      group_hash = hashedART
      group_array = agroup_array_x.group_by { |u| u[column] }.map { |k, v| [
        if !k.nil?
        "#{k}".downcase 
        else
        "null"
        end, v.size.to_f/porcent.to_f] }
      heads = hashedART.keys
      hx = {"hash": hashedART, "array": group_array, "heads": heads}

      last_group_array.push(hx)
    end

  
    group_fields = params_to_agroup

    agroup_array = agroup_array.group_by {|hash| hash.values_at(*group_fields).join ":" }.values.map do |grouped|
      counter = grouped.size
      #puts ">>> #{ grouped } "
      g_grouper = grouped.each do |g|
         g["k"] = 1
      end
      grouped.each.inject do |merged, n|
         merged.merge(n) do |key, v1, v2|
          group_fields.include?(key) ? v1 : (v1.to_i + v2.to_i)
         end
      end 
    end

    @data = {combinations: agroup_array, series: last_group_array}
     
  end
  ########### funcion de cruce de variables ##########
  def multiple_variable_crossover(datacollection, colums, rows)
    porcent = datacollection.count

    puts "#{colums}"
    puts "#{rows}"
    data_collection_advanced = []
    datacollection.each_with_index do |data, index|
      id = index + 1
      data['id'] = id
      data_collection_advanced.push(data)
    end


    last_group_array = []
    rows.each do |column|
       agroup_array_x = []
       @hashx.each_with_index do |h, index|
        data_collection = {}
        groped_x = h[column]
        data_collection[column] = groped_x
        agroup_array_x.push(data_collection)
      end

      hashedART = {}
      group_hash = agroup_array_x.group_by { |u| u[column] }.map { |k, v| 
      hashedART[ if !k.nil?
        "#{k}".downcase 
        else
        "null"
        end
      ] = v.size.to_f/porcent.to_f }
      group_hash = hashedART
      group_array = agroup_array_x.group_by { |u| u[column] }.map { |k, v| [
        if !k.nil?
        "#{k}".downcase 
        else
        "null"
        end, v.size.to_f/porcent.to_f] }
      heads = hashedART.keys
      hx = {"hash": hashedART, "array": group_array, "heads": heads}

      last_group_array.push(hx)
    end

    values_in_col = []


    colums.each do |col|
      @hashx.each_with_index do |h, index|
        values_in_col.push(h[col])
      end
    end

    values_in_col = values_in_col.uniq{|x| x}

    values_in_row = []
    adv_array = []
    last_group_array.each do |op|
       op[:heads].each do |px|
        values_in_row.push(px)
       rows.each do |row|
          values_in_col.each do |vin|
            colums.each do |col|
              hashed = {}
              hashed["row"] = row
              hashed["rowvin"] = px
              hashed["col"] = col
              hashed["colvin"] = vin
              selected = data_collection_advanced.select  {|hash| hash["#{row}"] == px if hash["#{col}"] == "#{vin}"}
              hashed["q"]= selected.count
              adv_array.push(hashed)
            end
          end
       end
      end
    end


    @crossover = {data: adv_array,values_in_row: values_in_row , values_in_col: values_in_col}

  end
end
