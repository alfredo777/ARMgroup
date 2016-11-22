class WorkSchemasController < ApplicationController
  before_action :authenticate_admin!

  layout "intern"

  before_action :set_work_schema, only: [:show, :edit, :update, :destroy]
  
  # GET /work_schemas
  # GET /work_schemas.json
  def index
    @work_schemas = WorkSchema.all
  end

  # GET /work_schemas/1
  # GET /work_schemas/1.json
  def show
    shchemas = @work_schema.campaing.request_base_to_reports.last
    puts shchemas 
    name_table = shchemas 
    @table_in = name_table
    table = eval(name_table.base_in_text)
    @hashx = table[:data]
    @heads = table[:heads]
  end

  # GET /work_schemas/new
  def new

    name_table = RequestBaseToReport.find(params[:id])
    @table_in = name_table
    table = eval(name_table.base_in_text)
    hashx = table[:data]
    heads = table[:heads]
    @heads = head_clean(heads)

    @base  =  params[:hash_base];
    @work_schema = WorkSchema.new
  end

  # GET /work_schemas/1/edit
  def edit
  end

  def json_schema
    @work_schema = WorkSchema.new
  end

  def json_schema_create
    @json = params[:file]
    file = File.read("#{@json.path}")
    data_hash = JSON.parse(file)
    questions = data_hash["questions"]
    nameS = "SCHEMA-" + SecureRandom.hex(10)
    @schema = WorkSchema.create(name: nameS, campaing_id: params[:campaing])
    puts nameS
    questions.each do |question|
      
      quest_var = question["variable"]
      quest_tag = question["tag"]
      quest_wordcloud = question["wordcloud"]
      quest_response_code = question["response_code"]
      quest_others = question["others"]
      quest_response_codes = question["response_codes"]
      quest_wordcloud_words = question["wordcloud_words"]

      @table_work = TableWork.create(work_schema_id: @schema.id , register_in_data_base: quest_var, alias: quest_tag, wordcloud: quest_wordcloud, response_code: quest_response_code, others: quest_others, response_codes: quest_response_codes, wordcloud_words: quest_wordcloud_words )
      puts quest_tag
      puts quest_var
      question["questions_dependent"].each do |qu|
         add_var = qu["variable"]
         puts add_var

        @column = ColumInTableWork.create(table_work_id: @table_work.id , register_in_data_base: add_var, alias: add_var)
      end

    end


    redirect_to @schema
  end

  # POST /work_schemas
  # POST /work_schemas.json
  def create
    @work_schema = WorkSchema.new(work_schema_params)

    respond_to do |format|
      if @work_schema.save
        format.html { redirect_to @work_schema, notice: 'Work schema was successfully created.' }
        format.json { render :show, status: :created, location: @work_schema }
      else
        format.html { render :new }
        format.json { render json: @work_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_schemas/1
  # PATCH/PUT /work_schemas/1.json
  def update
    respond_to do |format|
      if @work_schema.update(work_schema_params)
        format.html { redirect_to @work_schema, notice: 'Work schema was successfully updated.' }
        format.json { render :show, status: :ok, location: @work_schema }
      else
        format.html { render :edit }
        format.json { render json: @work_schema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_schemas/1
  # DELETE /work_schemas/1.json
  def destroy
    @work_schema.destroy
    respond_to do |format|
      format.html { redirect_to work_schemas_url, notice: 'Work schema was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_schema
      @work_schema = WorkSchema.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_schema_params
      params.require(:work_schema).permit(:name, :customer_id, :campaing_id, table_works_attributes:[:work_schema_id,:register_in_data_base,:priority,:alias, colum_in_table_works_attributes:[:table_work_id, :register_in_data_base, :priority, :alias]])
    end
end
