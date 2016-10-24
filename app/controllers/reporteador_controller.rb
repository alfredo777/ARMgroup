class ReporteadorController < ApplicationController
  layout "intern"

  def index
  end

  def view_base
    require "csv"
    name_table = "UNEFONPREPAGOCOMP1-cvx.csv"
    table = read_table(name_table)
    @hashx = table[:data]
    @heads = table[:heads]
    head_array = []
    @heads.each_with_index do |head, index|
      head_array.push(head)
    end

    @head_array = "#{head_array}"


    grouped = agrop_by_function(@hashx, "DataCollection.StartTime", true)
    @group = grouped[:arrayIN]
    puts @group

  end
  ######## lector de tablas #######
  def read_table(name_table)
    require "csv"
    readCsv = "#{Rails.root}/public/reporter/#{name_table}"
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
  def agrop_by_function(datacollection, param_to_agroup, type_date)
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
    hashedART = {}
    group_hash = agroup_array.group_by_day { |u| u[:group_factor] }.map { |k, v| hashedART["#{k}"] = v.size }
    group_hash = hashedART
    puts group_hash
    #group_array = agroup_array.group_by_day { |u| u[:group_factor] }.map { |k, v| last_group_array.push(v.size) }
    #puts group_array
    group_array = agroup_array.group_by_day { |u| u[:group_factor] }.map { |k, v| ["#{k}", v.size] }
    puts group_array

    @grouped = {arrayIN: group_array, hashIN: group_hash }
  end
  ########### agrupación por rango de parametros ##########+
  def agroup_by_param_range(table, param_1, param_2)
  end
end
