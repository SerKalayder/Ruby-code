require 'pg'
require 'sequel'

require_relative 'base_storage'
require_relative 'site_list_item'
require ::File.expand_path('../../report_generator/report', __FILE__)
require ::File.expand_path('../../report_generator/link', __FILE__)

module Storage
  class DbOrmStorage
    include SeoTools

    attr_accessor :config

    def add(report)
      reports_table = DB[:reports]
      reports_table.insert(
        :url => report.url,
        :title => report.title,
        :ip => report.ip,
        :created_at => report.date)

      headers_table = DB[:headers]
      report.headers.each do |key, value|
        headers_table.insert(
        :url => report.url,
        :key => key,
        :value => value)
      end

      links_table = DB[:links]
      counter = 1
      report.links.each do |link|
        links_table.insert(
          :number => counter,
          :url => report.url,
          :title => link.title,
          :href => link.href,
          :rel => link.rel,
          :target => link.target,
          :download => link.download)
        counter += 1
      end
    end


    def add_user
      users_table = DB[:users]
      users_table.insert(
        :email => "admin",
        :password => "12345")
    end

    def find(id)
      report = Report.new
      report_item = DB[:reports].where(id: id).first

      report.url = report_item[:url]
      report.title = report_item[:title]
      report.ip = report_item[:ip]
      report.date = report_item[:created_at]


      headers_item = DB[:headers].where(url: report.url)
      hash = Hash.new
      headers_item.each do |row|
        key = row[:key]
        value = row[:value]
        hash[key] = value
      end
      report.headers = hash

      links_item = DB[:links].where(url: report.url)

      list = Array.new
      links_item.each do |row|
        link = Link.new(row[:number], row[:title], row[:href], row[:rel],
        row[:target], row[:download])
        list << link
      end
      report.links = list

      report
    end

    def all
      list = Array.new

      reports = DB[:reports]

      reports.each do |row|
        if row[:url] != nil
          list << SiteListItem.new(row[:url], row[:created_at],
            "/report/" + row[:id].to_s)
        end
      end
      list
    end

  end
end
