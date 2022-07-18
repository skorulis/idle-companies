require 'json'

file = File.read('./Config/config.json')

config = JSON.parse(file)

output = "enum Fontello: String {\n"
glyphs = config["glyphs"]

glyphs.each { |glyph|
    puts glyph
    parts = glyph["css"].split("-") 
    puts parts
    name = ""
    parts.each_with_index { | value, index |
        if index == 0
            name += value
        else
            name += value.capitalize
        end
    }


    code = glyph["code"]
    code = code.to_s(16)

    output += "\tcase #{name} = \"\\u{#{code}}\"\n"
}

output += "}"

File.write("Companies/Theme/Fontello.swift", output)