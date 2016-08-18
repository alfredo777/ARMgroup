class CustomerFilesController < ApplicationController
  before_action :authenticate_any!, only: [:open_file]
  before_action :authenticate_customer!, except: [:open_file]
  layout "intern"

  def shared
    @customer = current_customer
  end

  def open_file
   @file = SharedFile.find(params[:id])
   @type = @file.name.split('.').last 
   if current_customer
   ahoy.track "Open File", title: "El archivo fue abierto #{@file.name} por #{current_customer.email} - #{Time.now}", customer:current_customer.id, archivo:params[:id].to_i
   end
  end

  def audio_search
    audios_result = [

      {url: "http://www.research-ss.com/rockstars/OUT20204-20140505-111915-956966591-1399306755.7199979.mp3"},

      {url: "http://www.research-ss.com/rockstars/OUT22003-20140505-131948-957735674-1399313988.7207900.mp3"},

      {url: "http://www.research-ss.com/rockstars/OUT20112-20140505-103114-9013336143393-1399303874.7195631.mp3"},

      {url: "http://www.research-ss.com/rockstars/OUT22103-20160712-100721-90445544764441-1468336041.3348215.wav"}
    ]

    @scoped_audios_results = result_audios_proccess(audios_result)
  end

  def audio_selected
  end

  def notify
    @notices = Notice.where(customer_id: current_customer.id).paginate(:page => params[:page], :per_page => 2).order('id DESC')
  end

  def result_audios_proccess(audios_result)
    proces_results = []
    audios_result.each do |au|
      url = au[:url]
      full_name = au[:url].split('/').last
      components = full_name.split('-')
      audio_date = components[1].to_date
      name = components[4].to_s
      proces_results.push({
        url: url,
        full_name: full_name,
        name: name,
        date: audio_date,
        components: components
      })
    end

    @result = proces_results.to_a

  end



end
