require 'ostruct'
require "f1sales_custom/parser"
require "f1sales_custom/source"

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when is from website' do
    let(:email){ 
      email = OpenStruct.new
      email.to = [email: 'website@lojateste.f1sales.org'],
      email.subject = 'Contato | santoshd.com.br',
      email.body = "Contato Site | santoshd.com.br\n*Nome:* Leonardo Assennato\n*E-mail:* leonardo@dspa.com.br\n*Telefone:* (13)9973-35346\n*Mensagem:* teste de email\n*Veículo:* - IRON 883¿\n*Data de envio:* 26/11/2019 11:32:00"

      email
    }

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains website as source name' do
      expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[0][:name])
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Leonardo Assennato')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('leonardo@dspa.com.br')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('13997335346')
    end


    it 'contains product' do
      expect(parsed_email[:product]).to eq('- IRON 883¿')
    end

    it 'contains messange' do
      expect(parsed_email[:message]).to eq('teste de email')
    end

  end
end
