crypto.f - crypto bindings for SwiftForth 
-----------------------------------------

This is an experimental binding for SwiftForth for OpenSSL 3.x and implementation of JWKs and JWTs for Forth


- ssl.f	 - OpenSSL bindings, NB: we have to reimplement a lot of #defines from bio.h in Forth
- jwt.f	 - JWT functions
- jwk.f  - JWK functions
- pki.f  - crypto functions for signing, verifying, encrypting, and decrypting messages

This is very much a Work in Progress and should not be used for any purpose at all

