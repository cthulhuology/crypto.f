\ pki.f

PACKAGE pki

\ TODO
: init ( filename -- ) ;
: sign ( message -- sig ) ;
: verify ( message sig -- ) ;
: encrypt ( message -- buffer ) ;
: decrypt ( buffer -- message ) ;

END-PACKAGE
