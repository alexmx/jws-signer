# JWS Signer
[![Twitter: @amaimescu](https://img.shields.io/badge/contact-%40amaimescu-blue.svg)](https://twitter.com/amaimescu)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/alexmx/ios-ui-automation-overview/blob/master/LICENSE)

Apply JWS Signatures [RFC-7515](https://tools.ietf.org/html/rfc7515) to JSON files using a [PKCS #12](https://en.wikipedia.org/wiki/PKCS_12) certificate.

This CLI app uses **RS256** (RSA Signature with SHA-256) algorithm to sign the files.

#### Available commands:

```
Usage: jws-signer.rb [options]
    -i, --input JWS PAYLOAD          The input JSON file to be signed (payload).
    -h, --header JWS HEADER          The JWS header.
    -c P12 CERTIFICATE,              The p12 certificate to be used for signing.
        --certificate
    -p P12 CERTIFICATE PASSPHRASE,   The p12 certificate passphrase.
        --passphrase
    -o, --output OUTPUT              The JWS signed json file.
        --public-key                 Print certificate public key.
        --help                       Show help message.
```


#### Create a JWS signature for an input JSON file

Command:
```bash

./jws-signer.rb -i 'examples/input.json' -c 'examples/certificate.p12' -p "12345"

```

Output JWS:
```
eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.Intcblx0XCJ0ZXN0VmFsdWUxXCI6IDEsXG5cdFwidGVzdFZhbHVlMlwiOiBcIkhlbGxvIFdvcmxkXCIsXG5cdFwidGVzdFZhbHVlM1wiOiBbXG5cdFx0XCJ2YWx1ZTFcIiwgXCJ2YWx1ZTJcIlxuXHRdXG59Ig.ApjljNFAK6K7pynkGUO8nPBiKTPipIvAwpHR_oeqXB7SJIrkyR05JH8fA7uIrY7c_FYGXAnLdvPuMULWdaZdWfMcmV_LrZoOBx4fqfs5gQff4H8K5dIoenxW0U5m19ncEb0AQ6gVNQDSwFDxvHg4Sqigm0CDivFZfKGq17Q8bUpYMZov0QSnRSIAh3mwlS4F6ayqrHskfnyMhQvWwRupz7oUg8knU5aZ89hfQnv3vVDkMh0CVXG1gvkrzSHTvlEgt5M1oKJVJ5SPUjz-_QnhmPJLIo56VRQsDXbERK2uXEWU6bpz9Dvo6OeYGdpgnMxek-__uY50aIRWr1PKvLE6QA
```


#### Get the public key from the certificate:

Command:
```bash

./jws-signer.rb -c 'examples/certificate.p12' -p "12345" --public-key

```

Output public key:
```bash
-----BEGIN CERTIFICATE-----
MIIDPzCCAiegAwIBAgIBATANBgkqhkiG9w0BAQsFADBNMRYwFAYDVQQDDA1BbGV4
IE1haW1lc2N1MQswCQYDVQQGEwJNRDEmMCQGCSqGSIb3DQEJARYXbWFpbWVzY3Uu
YWxleEBnbWFpbC5jb20wHhcNMTcwNTE5MTQ1NTA3WhcNMTgwNTE5MTQ1NTA3WjBN
MRYwFAYDVQQDDA1BbGV4IE1haW1lc2N1MQswCQYDVQQGEwJNRDEmMCQGCSqGSIb3
DQEJARYXbWFpbWVzY3UuYWxleEBnbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUA
A4IBDwAwggEKAoIBAQC3JgKF6YwYT2ySqeGDT9ny7C+xH/4RhPDZz14Z1ZSHTRP7
8A4FSzgA8ziqw5tcsoLfRn2EoT7J1O3EawC2FRYTGNUghhXninDl46yoa8bxaUXG
q29aRkqV6k0FEcsCctjpcpdVLvgJnL09HtFRxHCcUKMTsk1d2447yA6BFF9b4kMV
dBAZgURZOv/LZXeKRtzqdDv0BhgrkgkCHwCqK/4SAd2543yAn7OGc1zFbZ3iYeBD
Ng79B7lhHl7/EZy3eK+F5ZKPat6fW+8UMReqko6AfzPLhVdUeETBb/HhP9Cv8zNx
ELnRDGrkeXU338euiXPDF4Iw65pGTl918d6Mm9vRAgMBAAGjKjAoMA4GA1UdDwEB
/wQEAwIHgDAWBgNVHSUBAf8EDDAKBggrBgEFBQcDAzANBgkqhkiG9w0BAQsFAAOC
AQEAkePumIMzOPqEnMIG54+DY4Gj0n/8OKcI4csXOnZy5O7A2hkzN6SLDHRl1JKf
T19ALfhKQw//UCno66nah+ppneovmnjyAsdCEgxw1NBF4amM0EeAOH9S9rvyAW5p
96NiHXpnBwwgqj39ArOAn7uBinBYaP98eX8NUMrwBKyWfEpePw6oDh0OlEyLeJmy
lHn368nlZPkLDOV0n6d3EJZXHzkjNPCCx5FuTwpQiX/kAYO4rS2gJykbmN1PR5Kw
oK5KHbdbGMbEE1+5oGQyI6joNghmzYGMC63BRwxWSbLbJai4AseCYpl6kTtq6vmh
kjuYDF1LW6ACyY2hJOzZRqG0fA==
-----END CERTIFICATE-----
```

#### Validate JWS signature:
1) Go to [jwt.io](https://jwt.io/);
2) Paste the ouptut JWS to the *Ecoded* text box;
3) Paste the public key to the *Verify Signature* text box;
4) The output message should be *Signature Verified*.
5) Enjoy!

## License
This project is licensed under the terms of the MIT license. See the LICENSE file.
