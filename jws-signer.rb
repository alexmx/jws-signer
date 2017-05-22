require 'optparse'
require 'json'
require 'jwt'
require 'openssl'

Process.setproctitle("JWS Signer")

# Default CLI options
options = {
    :input_json => 'input.json',
    :certificate => 'certificate.p12',
    :passphrase => '12345',
    :output => 'signed-output.json'
}

OptionParser.new do |parser|
    parser.banner = "Usage: jws-signer.rb [options]"
    
    # Specify input JSON file to be signed
    parser.on("-i", "--input JSON FILE", "The input JSON file to be signed.") do |input_json|
        options[:input_json] = input_json
    end

    # Specify .p12 certificate to be used for signing
    parser.on("-c", "--certificate P12 CERTIFICATE", "The p12 certificate to be used for signing.") do |certificate|
        options[:certificate] = certificate
    end

    # Specify .p12 certificate passphrase
    parser.on("-p", "--passphrase P12 CERTIFICATE PASSPHRASE", "The p12 certificate passphrase.") do |passphrase|
        options[:passphrase] = passphrase
    end

    # Specify output JWS signed file
    parser.on("-o", "--output OUTPUT", "The JWS signed json file.") do |output|
        options[:output] = output
    end

    # Print help
    parser.on("-h", "--help", "Show help message.") do
        puts parser
        exit
    end
end.parse!

# Read input JSON file
def get_json_payload(input_json_path)
    return File.read(input_json_path)
end

# Read .p12 certificate private key
def get_rsa_private_key(certificate_path, passphrase)
    p12 = OpenSSL::PKCS12.new(File.read(certificate_path), passphrase)
    return p12.key
end

# Get JWS encoded and signed output
def get_jws_output(payload, rsa_private_key)
    JWT.encode(payload, rsa_private_key, 'RS256')
end

payload = get_json_payload(options[:input_json])
rsa_private_key = get_rsa_private_key(options[:certificate], options[:passphrase])

jws_output = get_jws_output(payload, rsa_private_key)

if jws_output
    File.write(options[:output], jws_output)
end
