# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Parser::Application.config.secret_key_base = '52e7cebd3fdea35e1ac667499fb44ff388325df352c4c119a454b61ad1c6d3cbf40279fe123b5abb028b369c1f2c4e353294891da760d42b1805b0068e67dfd0'
