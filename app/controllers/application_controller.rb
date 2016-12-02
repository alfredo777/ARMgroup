class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :host_url
  helper_method :customer_act_search
  helper_method :authenticate_any
  helper_method :head_clean
  helper_method :array_agroup
  helper_method :agrouped_table
  helper_method :media
  helper_method :mediana
  helper_method :moda
  helper_method :group_var_by_codes
  helper_method :name_by_code
  helper_method :names_by_code
  helper_method :dinamic_counter_view
  helper_method :current_path_info
  helper_method :text_xx_counter_view
  helper_method :find_var_text_prototype
  before_action :configure_permitted_parameters, if: :devise_controller?

  def host_url
=begin    
    if Rails.env == "Production"
      @h = "http://www.research-ss.com"
    else  
      @h = "http://localhost:3000"
    end
=end
    @h = "http://www.research-ss.com"
  end

  def current_path_info
    @current_uri = request.env['PATH_INFO']
  end

  def customer_act_search(id, relation)
    @id = id.to_i
    @string = "properties LIKE '%\""+"#{relation}"+"\":"+"#{@id}"+"%'"
  end

  def array_agroup(array)
    @x = array.each_with_object(Hash.new(0)) {|e, h| h[e] += 1}
  end


  def head_clean(heads)
    variables_not_necesary = ["Respondent", "DataCollection", "DataCleaning", "DataCollection.", "Respondent.", "DataCleaning.", ".Origin", ".Status", ".Variant", "Respondent.Origin", "DataCollection.Status", "DataCollection.FinishTime", "DataCollection.InterviewEngine", "DataCollection.InterviewerTimeZone", "DataCollection.Removed", "DataCleaning.ReviewStatus"]
    @heads = heads
    variables_not_necesary.each do |vn|
      @heads.each_with_index do |ar, index|
        if "#{ar}".downcase.include?(vn.downcase)
          @heads.delete(ar)
        end
      end
    end
    @heads
  end

  def media(array, n)
    puts "*********** #{array}"
    puts "*********** #{n}"
    new_array = []
    array[:arrayIN].each do |a|
      q = a[1].to_f * n.to_f
      new_array.push(q.to_f)
    end

    l = new_array.size
    sum = 0
    new_array.each do |nr|
      sum = sum.to_f + nr.to_f
    end

    @media = (sum.to_f / l.to_f).round(2)    
  end #208022

  def mediana(array,n)
    puts "*********** #{array}"
    puts "*********** #{n}"
    new_array = []
    array[:arrayIN].each do |a|
      q = a[0].to_f
      new_array.push(q)
    end

    sorted = new_array.sort
    len = sorted.length

    @mediana = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end


  def moda(array,n)
    new_array = []
    array[:arrayIN].each do |a|
      q = a[0].to_f
      new_array.push(q.to_f)
    end

    freq = new_array.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @moda = new_array.max_by { |v| freq[v] }
  end

  def group_var_by_codes(table, codes, var)
    puts codes
    puts var
  end

  def dinamic_counter_view(camping,indx)
    cc = ReportDinamicView.where(campaing_id: camping, function_or_index: indx).count

    if cc > 0
      true
    else
      false
    end

  end

  def find_var_text_prototype(campaing, vary,token)
    schema = campaing.work_schemas.last
    codex = []
    schema.table_works.each do |table|
       table.colum_in_table_works.each do |column|
         if column.register_in_data_base == vary
           if table.response_code == true
           codes = eval(table.response_codes)
           codes.each do |code|
            if code["code"].to_i == token.to_i
              valorem = code["value"]
              codex.push(valorem)
            end
            end
           end
         end
       end
    end
    if codex.length != 0
      @code = codex[0]
      else
      @code = token
    end
  end

  def text_xx_counter_view(camping,indx)
    cc = ReportDinamicView.where(campaing_id: camping, function_or_index: indx)
    cc.each do |c|
      if c.legend.nil?
        @cc = nil
      else
        @cc = c.legend
      end
    end
    @cc
  end

  def names_by_code(list, variables, table)
    puts list
    puts variables
    #puts table
    words = ""
    table.each do |t|
      words = "#{words}" +" "+ "#{t[variables]}"
    end
    words = words.downcase
    #puts words

    @list = eval(list)

    words = words.split(" ")

    frequencies = Hash.new(0)


  
    words.each do |word|
      frequencies[word] += 1
    end
    array = []
    @list.each do |lxz|
      varix = lxz['li']
      fr = frequencies["#{varix}"]
      #puts fr

      array.push({"text": "#{varix}", "weight": fr})
    end

    puts array
     
    @array = array

  end

  def name_by_code(code, codes)
    select_var = []
    #puts "#{code} *************************"
    codes.each do |c|
      #puts "#{c} **********<z<z<z<z"
      if c['code'].to_i == code.to_i
         select_var.push(c['value'])
      end
    end

    @re = select_var[0]
  end


  def agrouped_table(table, data_base, type_date=false)
      last_group_array = []
      table.colum_in_table_works.each do |column|
         agroup_array = []
         data_base.each_with_index do |h, index|
          data_collection = {}
          if type_date == true
            groped_x = h[column.register_in_data_base].to_date
          else
            groped_x = h[column.register_in_data_base]
          end
          data_collection[column.register_in_data_base] = groped_x
          agroup_array.push(data_collection)
        end
        last_group_array.push(agroup_array)
      end


    keys_init = []
    array_init = []
    array_init_1 = []
    last_group_array.each do |st|
      hashed = {}
      hashed1 = {}
      table.colum_in_table_works.each do |column|
        data_in_array = []
        keys_init.push("variable")
        registeratio = column.register_in_data_base
        group_hash = st.group_by { |u| 
          u[registeratio] 
          }.map { |k, v| 
          hashed["#{k}"] = (v.size.to_f/st.count.to_f).round(5)
          if v != nil
          data_in_array.push(v.size.to_i)
          end
          keys_init.push("#{k}")
        }
        hashed1["data"] = data_in_array
      end
      array_init.push(hashed)
      array_init_1.push(hashed1)
    end

    array_init.each_with_index do |ary, index|
      ary["variable"] = table.colum_in_table_works[index].register_in_data_base
    end

    array_init_1.each_with_index do |ary, index|
      ary["name"] = table.colum_in_table_works[index].register_in_data_base
    end

    keys_init = keys_init.uniq

    @table = {heads: keys_init, data: array_init, array_chart_1: array_init_1}

  end

  def authenticate_any!
    if admin_signed_in?
        true
    else
        authenticate_customer!
    end
end

  protected

  def configure_permitted_parameters
    if Rails.env.production?
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    else
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    end
  end
end
