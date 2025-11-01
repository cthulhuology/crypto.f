
PACKAGE ssl

XLIBRARY ssl libssl.so

PRIVATE

FUNCTION: BIO_f_base64		( -- m )		\ method to base64 encode all data

FUNCTION: BIO_s_mem 		( -- m ) 		\ returns memory allocation function 

FUNCTION: BIO_new		( a -- a )		\ returns a new bio using mehthod 
FUNCTION: BIO_set		( a m -- i )		\ sets method on existing bio, 0 fail
FUNCTION: BIO_free		( a -- i )		\ frees a bio 
FUNCTION: BIO_vfree		( a -- )		\ ditto but no return
FUNCTION: BIO_free_all		( a -- )		\ frees a full chain

FUNCTION: BIO_push		( a a -- a )		\ append a bio chain
FUNCTION: BIO_pop		( b -- a )		\ removes bio b and return remainder`

FUNC
FUNCTION: BIO_set_flags		( b f -- )		\ sets flags on a bio
FUNCTION: BIO_test_flags	( b f -- i )		\ test flags on a bio
FUNCTION: BIO_clear_flags	( b f -- )		\ clears the flags on a bio

FUNCTION: BIO_ctrl		( b i i a -- i )	\ do a bio command



PUBLIC

\ nearly all the bio calls got through BIO_ctrl 

$0 CONSTANT BIO_NOCLOSE
$1 CONSTANT BIO_CLOSE

1  CONSTANT BIO_CTRL_RESET      	\ opt - rewind/zero etc 
2  CONSTANT BIO_CTRL_EOF        	\ opt - are we at the eof 
3  CONSTANT BIO_CTRL_INFO       	\ opt - extra tit-bits 
4  CONSTANT BIO_CTRL_SET        	\ man - set the 'IO' type 
5  CONSTNAT BIO_CTRL_GET        	\ man - get the 'IO' type 
6  CONSTANT BIO_CTRL_PUSH       	\ opt - internal, used to signify change 
7  CONSTANT BIO_CTRL_POP        	\ opt - internal, used to signify change 
8  CONSTANT BIO_CTRL_GET_CLOSE  	\ man - set the 'close' on free 
9  CONSTANT BIO_CTRL_SET_CLOSE  	\ man - set the 'close' on free 
10 CONSTANT BIO_CTRL_PENDING    	\ opt - is their more data buffered 
11 CONSTANT BIO_CTRL_FLUSH      	\ opt - 'flush' buffered output 
12 CONSTANT BIO_CTRL_DUP        	\ man - extra stuff for 'duped' BIO 
13 CONSTANT BIO_CTRL_WPENDING   	\ opt - number of bytes still to write 
14 CONSTANT BIO_CTRL_SET_CALLBACK   	\ opt - set callback function 
15 CONSTANT BIO_CTRL_GET_CALLBACK	\ opt - set callback function 

29 CONSTANT BIO_CTRL_SET_PEEK		\ BIO_f_buffer special 
30 CONSTANT BIO_CTRL_SET_FILENAME	\ BIO_s_file special 

31 CONSTANT BIO_CTRL_DGRAM_CONNECT		\ datagram special
32 CONSTANT BIO_CTRL_DGRAM_SET_CONNECTED	\ connected socket pass thru

33 CONSTANT BIO_CTRL_DGRAM_SET_RECV_TIMEOUT	\ setsockopt
34 CONSTANT BIO_CTRL_DGRAM_GET_RECV_TIMEOUT	\ getsockopt
35 CONSTANT BIO_CTRL_DGRAM_SET_SEND_TIMEOUT
36 CONSTANT BIO_CTRL_DGRAM_GET_SEND_TIMEOUT

37 CONSTANT BIO_CTRL_DGRAM_GET_RECV_TIMER_EXP	\ timeout exceptions
38 CONSTANT BIO_CTRL_DGRAM_GET_SEND_TIMER_EXP

33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_
33 CONSTANT BIO_CTRL_DGRAM_

128 CONSTANT BIO_C_FILE_SEEK

133 CONSTANT BIO_C_FILE_TELL 

\ helper method for all the calls that pass no real params

: _BIO_op 0 0 BIO_ctrl ;

\ bio file operations, replaces all the #define methods in bio.h

: BIO_reset ( b -- i ) BIO_CTRL_RESET _bIO_op ;
: BIO_eof ( b -- i ) BIO_CTRL_EOF _BIO_op ;
: BIO_set_close ( b f -- i ) BIO_CTRL_SET_CLOSE swap 0 BIO_ctrl ;
: BIO_get_close ( b -- i ) BIO_CTRL_GET_CLOSE _BIO_op ;
: BIO_pending ( b -- i ) BIO_CTRL_PENDING _BIO_op ;
: BIO_wpending ( b -- i ) BIO_CTRL_WPENDING _BIO_op ;
: BIO_flush ( b -- i ) BIO_CTRL_FLUSH _BIO_op ;
: BIO_tell ( b -- i ) BIO_C_FILE_TELL _BIO_op ;
: BIO_seek ( b i -- i ) BIO_C_FILE_SEEK swap 0 BIO_ctrl ;
: 

: BIO_get_mem_ptr 

: /ssl openssl +order ;

END-PACKAGE

