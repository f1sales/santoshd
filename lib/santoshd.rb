require "santoshd/version"

require "f1sales_custom/parser"
require "f1sales_custom/source"
require "f1sales_custom/hooks"
require "f1sales_helpers"

module Santoshd
  class Error < StandardError; end
  class F1SalesCustom::Email::Source 
    def self.all
      [
        {
          email_id: 'website',
          name: 'Website'
        },
      ]
    end
  end

  class F1SalesCustom::Email::Parser
    def parse
      parsed_email = @email.body.colons_to_hash(/(Telefone|Nome|E-mail|Data de envio|Veículo|Site|Mensagem|Data).*?:/, false)

      {
        source: {
          name: F1SalesCustom::Email::Source.all[0][:name],
        },
        customer: {
          name: parsed_email['nome'],
          phone: parsed_email['telefone'].tr('^0-9', ''),
          email: parsed_email['email']
        },
        message: parsed_email['mensagem'],
        product: (parsed_email['veculo'] || ''),
      }
    end
  end
end
