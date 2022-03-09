require "net/http";
require "json";

def reqs (url)

  begin

    uri = URI(url)
    req = Net::HTTP::Get.new(uri)

    req["User-Agent"] = "Mozilla/5.0 (Android 10; Mobile; rv:94.0) Gecko/94.0 Firefox/94.0"
    req["Referer"] = "http://cnes.datasus.gov.br/pages/profissionais/consulta.jsp"

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http|
      http.request(req)
    }

    response = JSON.parse(res.body)

    msg = ''

    for i in response
      for k, v in i
        #puts(k, v)
        begin
          msg += k.upcase + " " + v + "\n"
        rescue
        end
      end
     msg += "--------------------\n"
    end

    response = msg[..-24]
  rescue Exception => e
    response = "*NENHUMA INFORMAÇÃO ENCONTRADA!*"
  end

  return response
end

Sair = true

while true
  system "clear||cls"
  print "1 - Nome\n2 - CPF\n3 - Sair\n>> "
  option = gets.chomp
  system "clear||cls"
  case option
    when "1"
       print "DIGITE O NOME COMPLETO >> "
       info = gets.chomp.gsub(" ","%20").upcase
       msg = reqs("http://cnes.datasus.gov.br/services/profissionais?nome=%s"%info)
    when "2"
       print "DIGITE O CPF >> "
       info = gets.chomp.gsub(" ","")
       msg = reqs("http://cnes.datasus.gov.br/services/profissionais?cpf=%s"%info)
    when "3"
       break
    else
       msg = "Opção inválida!"
  end

  system "clear||cls"
  print msg+"\n\n< Aperte Enter > ";gets.chomp
end
