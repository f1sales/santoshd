require 'ostruct'
require "f1sales_custom/parser"
require "f1sales_custom/source"

RSpec.describe F1SalesCustom::Email::Parser do
  context 'when is from website' do
    let(:email){ 
      email = OpenStruct.new
      email.to = [email: 'website@lojateste.f1sales.org'],
      email.subject = 'Contato | santoshd.com.br',
      email.body = "Contato Site | santoshd.com.br\n\nNome:\t Antônio Cláudio\t\nE-mail:\t acmabreu@hotmail.com.br\t\nTelefone:\t (11)9832-55498\t\nMensagem:\t Boa noite, Favor informar se harley santos tem o\nacabamento cromado do pára-lama traseiro da harley de luxe 2017,qual o\npreço a vista e se despacha para Mogi das Cruzes SP. Att\t\nVeículo:\t - IRON 883¿\t\nData de envio:\t 03/12/2019 21:42:34"

      email
    }

    let(:parsed_email) { described_class.new(email).parse }

    it 'contains website as source name' do
      expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[0][:name])
    end

    it 'contains name' do
      expect(parsed_email[:customer][:name]).to eq('Antônio Cláudio')
    end

    it 'contains email' do
      expect(parsed_email[:customer][:email]).to eq('acmabreu@hotmail.com.br')
    end

    it 'contains phone' do
      expect(parsed_email[:customer][:phone]).to eq('11983255498')
    end


    it 'contains product' do
      expect(parsed_email[:product]).to eq('- IRON 883¿')
    end

    it 'contains messange' do
      expect(parsed_email[:message]).to eq("Boa noite, Favor informar se harley santos tem o\nacabamento cromado do pára-lama traseiro da harley de luxe 2017,qual o\npreço a vista e se despacha para Mogi das Cruzes SP. Att")
    end

  end
end
