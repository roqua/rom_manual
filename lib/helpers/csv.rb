module CsvHelper
  def csv(string, col_sep: ';')
    data = CSV.parse(string, col_sep: col_sep)

    output = ""
    output << "<table>"

    output << "<thead>"
    data[0..0].each do |row|
      output << "<tr>"
      row.each do |cell|
        output << "<th>#{cell}</th>"
      end
      output << "</tr>"
    end
    output << "</thead>"

    output << "<tbody>"
    data[1..-1].each do |row|
      output << "<tr>"
      row.each do |cell|
        output << "<td>#{cell}</td>"
      end
      output << "</tr>"
    end
    output << "</tbody>"

    output << "</table>"
    output
  end
end

include CsvHelper
