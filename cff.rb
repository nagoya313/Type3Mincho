require 'nokogiri'

file = File.open('cff.org.xml')
diff_file = File.open('cff.new.xml')
doc = Nokogiri::XML(file)
diff_doc = Nokogiri::XML(diff_file)

list = [
  #'cid10487', # 偽
  #'cid10989', # 写
  #'cid11679', # 匿
  #'cid11889', # 又
  #'cid17302', # 庶
  #'cid24144', # 淚
  #'cid25535', # 為
  #'cid41217', # 逃
  #'cid41408', # 遍
  #'cid41498', # 遮
  #'cid44847', # 韻
  # 徒
  # 従
  # 縦
  # 襲
  # 籠
  # 冒
  # 帽
  # 闇
]

list.each do |elem|
  diff_doc.xpath("//CharString[@name = '#{elem}']").each do |e|
    puts e
    change = doc.xpath("//CharString[@name = '#{elem}']").first
    puts change
    change.content = e.text
    puts change
  end
end

File.open('new_cff.xml', 'w') do |file|
  file.puts doc.to_xml
end
