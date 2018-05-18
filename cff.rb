require 'nokogiri'

file = File.open('cff.diff.xml')
doc = Nokogiri::XML(file)

=begin
doc.xpath('//CFFFont').each do |element|
  element['name'] = 'Type3Mincho-Regular'
  puts element['name']
end

doc.xpath('//Notice').each do |element|
  element['value'] = "Copyright (c) 2018, nagyoya313, with Reserved Font Name 'Type 3'. | Copyright © 2017 Adobe Systems Incorporated (http://www.adobe.com/), with Reserved Font Name 'Source'."
  puts element
end

doc.xpath('//FullName').each do |element|
  element['value'] = 'Type 3 Mincho Regular'
  puts element
end

doc.xpath('//FamilyName').each do |element|
  element['value'] = 'Type 3 Mincho'
  puts element
end

doc.xpath('//FontName').each do |element|
  element['value'] = element['value'].sub!(/SourceHanSerif/, 'Type3Mincho')
  puts element
end
=end

File.open('cff.new.xml', 'w') do |file|
  file.puts doc.to_xml
end
