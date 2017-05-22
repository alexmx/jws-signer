#!/usr/bin/env ruby

require 'optparse'
require 'json'
require 'jwt'
require 'openssl'

Process.setproctitle("JWS Signer")

# Default CLI options
options = {}

OptionParser.new do |parser|
    parser.banner = "Usage: jws-signer.rb [options]"
    
    # Specify input JSON file to be signed. JWS payload
    parser.on("-i", "--input JWT PAYLOAD", "The input JSON file to be signed (payload).") do |payload|
        options[:payload] = payload
    end

    # Specify JWS header
    parser.on("-h", "--header JWS HEADER", "The JWS header.") do |jws_header|
        options[:jws_header] = jws_header
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
    parser.on("--help", "Show help message.") do
        puts parser
        exit
    end
end.parse!

# Read input JSON file
def get_json_payload(input_json_path)
    return File.read(input_json_path)
end

# Read JWS header
def get_jws_header(jws_header_path)
    jsonString = File.read(jws_header_path) if jws_header_path
    return JSON.parse(jsonString)
end

# Read .p12 certificate private key
def get_rsa_private_key(certificate_path, passphrase)
    p12 = OpenSSL::PKCS12.new(File.read(certificate_path), passphrase)
    return p12.key
end

# Get JWS encoded and signed output
def get_jws_output(header, payload, rsa_private_key)
    if header 
        JWT.encode(payload, rsa_private_key, algorithm='RS256', header_fields=header)
    else
        JWT.encode(payload, rsa_private_key, 'RS256')
    end
end

# Read inputs
header = get_jws_header(options[:jws_header])
payload = get_json_payload(options[:payload])
rsa_private_key = get_rsa_private_key(options[:certificate], options[:passphrase])

# Prepare output
jws_output = get_jws_output(header, payload, rsa_private_key)

if options[:output]
    File.write(options[:output], jws_output)
else
    puts jws_output
end

