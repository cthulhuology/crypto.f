\ jwk.f

PACKAGE jwk

\ TODO
PUBLIC

: init ( filename -- ) ;	\ generate keys if filename doesn't exist or load
: pub  ( -- ) ;			\ vectored key selection
: priv  ( -- ) ;
: signing ( -- key ) ;		\ return signing key
: encrypting ( -- key ) ;	\ return encrypting key

PRIVATE 

: loadJWK ( filename -- ) ;	\ loads the key file
: saveJWK ( filename -- ) ; 	\ saves the key file

: signingPublicJWK  ;	 	
: signingPrivateJWK  ;
: encryptingPublicJWK ;
: encryptingPrivateJWK ;

END-PACKAGE
