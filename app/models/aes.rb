

require "openssl"
require "base64"

module Aes

  # performs AES Encryption using 128-bit key and a block
  # size of 16. The encrypted text also contains the IV which
  # is sent over to the LMS.
  BS = 16

  def self.decrypt ciph, key
    ciph, iv = Base64.urlsafe_decode64(ciph).split("||/")

    de = OpenSSL::Cipher::Cipher.new("aes-128-cfb")
    de.decrypt
    de.key = key[0..15]
    de.iv = iv
    plain = de.update(ciph) + de.final
    plain = plain[0...-plain[-1].ord]
  end

  def self.encrypt text,key
  	
    pad = -> (s) { s +  (BS - s.length % BS).chr * (BS - s.length % BS) }
    en = OpenSSL::Cipher::Cipher.new("aes-128-cfb")
    en.encrypt
    en.key = key[0..15]
    iv = en.random_iv
    text = pad.call(text)
    data = (en.update(text) + en.final) + "||/" + iv
    Base64.urlsafe_encode64(data)
  end
end