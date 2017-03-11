require 'csv'
require 'erb'

Dir.foreach('./sets') do |item|
  next if item == '.' or item == '..'

  csv_text = File.read("./sets/#{item}")
  @title = item.gsub('.csv','')
  @lego_pieces = []

  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    @lego_pieces << row.to_hash
  end

  @slice_count = @lego_pieces.count/2

  # render template
  template = File.read('./checklist_template.html.erb')
  result = ERB.new(template).result(binding)

  # write result to file
  File.open("./checklists/#{item.gsub('.csv','.html')}", 'w+') do |f|
    f.write result
    puts "- #{item.gsub('.csv','')}"
  end
end
