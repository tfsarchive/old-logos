require 'find'
require 'fileutils'

paths = []
entries = []
Find.find('.') do |path|
  paths << path unless FileTest.directory?(path)
end

paths.each do |path|
  if path.include?(".png") || path.include?(".PNG") 
    lib = path[2..-1]
    entries << lib
  end
end

paths.each do |path|
  if path.include?(".xcf") || path.include?(".XCF") 
    lib = path[2..-1]
    entries << lib
  end
end

File.open("index.txt","w") do |f|
  entries.each do |entry|
    f.write(entry << "\n" );
   
   end
  

  
  # Look for local library files
  entries = []
  paths.each do |path|
    if path.include?("index.txt")
      entries << path
    end
  end

  entries.each do |entry|
    unless (entry == "./index.txt")
      lib = File.open(entry,"r")
      l = lib.read
      lib.close
      
      exports = l.split("\n")
      exports.each do |export_entry|
        if export_entry.start_with?("EXPORT ")
          virtual = export_entry.split(" ")[1]
          real = export_entry.split(" ")[2]
          f.write(real << "\n")
        end
        if export_entry.start_with?("EXPORT_RATIO ")
          ratio = export_entry.split(" ")[1] 
          virtual = export_entry.split(" ")[2]
          real = export_entry.split(" ")[3]
          f.write(real << "\n")
        end
      end
    end
  end


end

  

