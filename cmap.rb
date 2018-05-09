# encoding: utf-8
require 'nokogiri'
require './cmap_replace_table'

doc = Nokogiri::XML(File.open('cmap.org.xml'))

CmapReplaceTable::LIST.each_with_index do |elem, index|
  if elem[:code] == sprintf('0x%04x', elem[:kanji].ord)
    puts "#{elem[:kanji]}(#{elem[:code]}) replace cmap.[#{index + 1}/#{CmapReplaceTable::LIST.size}]"
  else
    raise "code:#{elem[:code]} != kanji: #{elem[:kanji]}(#{sprintf('%04x', elem[:kanji].ord)})"
  end
  doc.xpath("//map[@code = '#{elem[:code]}']").each do |e|
    e['name'] = elem[:name]
  end
end

File.open('cmap.new.xml', 'w') do |file|
  file.puts doc.to_xml
end
