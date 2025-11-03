
PACKAGE ssl

XLIBRARY ssl libssl.so

PRIVATE

\ BIO_callback_fn 	( b iop *argp argi argl ret -- i )
\ BIO_callback_fn_ex	( b iop *argp len argi argl ret *ret -- i )

FUNCTION: BIO_get_callback 	( b -- cb )		\ get cb function
FUNCTION: BIO_set_callback	( b cb -- )		\ set cb function
FUNCTION: BIO_get_callback_ex	( b -- cbex )		\ get cbex function
FUNCTION: BIO_set_callback_ex	( b cbex -- )		\ set cbex function

FUNCTION: BIO_get_callback_arg	( b -- a )		\ char* return
FUNCTION: BIO_set_callback_arg  ( b a -- )		\ set char* 

FUNCTION: BIO_method_name	( b -- a )		\ get the method name char*
FUNCTION: BIO_method_type	( b -- t )		\ returns type flag

\ base64 encoders
FUNCTION: BIO_f_base64		( -- m )		\ method to base64 encode all data

\ memory functions
FUNCTION: BIO_s_mem 		( -- m ) 		\ returns memory allocation function 
FUNCTION: BIO_s_secmem 		( -- m ) 		\ returns memory allocation function 
FUNCTION: BIO_new_mem_buf	( a  i -- a )		\ bio from memory region

\ socket functions
FUNCTION: BIO_s_socket		( -- a )		\ listen socket
FUNCTION: BIO_s_connect		( -- a ) 		\ remote socket
FUNCTION: BIO_s_accept		( -- a )		\ client socket

\ files
FUNCTION: BIO_s_fd		( -- a )		\ socket file descriptor 
FUNCTION: BIO_s_log		( -- a )		\ socket logger
FUNCTION: BIO_s_bio		( -- a )		\ socket bio pipe
FUNCTION: BIO_s_null		( -- a )		\ socket null
FUNCTION: BIO_f_null		( -- a )		\ file null
FUNCTION: BIO_f_buffer		( -- a )		\ buffer
FUNCTION: BIO_f_linebuffer	( -- a )		\ line buffer
FUNCTION: BIO_f_nbio_test	( -- a )		\ 

\ datagram
FUNCTION: BIO_s_datagram	( -- a )		\ datagram socket
FUNCTION: BIO_dgram_non_fatal_error ( e -- i )		\ datagram error
FUNCTION: BIO_new_dgram		( fd f -- a )		\ f is close flag

[defined] USE_SCTP [if] 
\ sctp
FUNCTION: BIO_s_datagram_sctp	( -- a ) 		\ sctp datagram
FUNCTION: BIO_new_dgram_sctp	( fd f -- a )		\ f is close flag
FUNCTION: BIO_dgram_is_sctp	( a -- i )		\ test if sctp
FUNCTION: BIO_dgram_sctp_notification_cb	( a cb c --  i )	\ callback w/ context
\ callback is a ( bio context buffer -- ) method
FUNCTION: BIO_dgram_sctp_wait_for_dry ( a -- i )	\ 
FUNCTION: BIO_dgram_sctp_msg_waiting  ( a -- i )	\ 
[then]

\ bio functions
FUNCTION: BIO_new		( a -- a )		\ returns a new bio using mehthod 
FUNCTION: BIO_free		( a -- i )		\ frees a bio 
FUNCTION: BIO_vfree		( a -- )		\ ditto but no return
FUNCTION: BIO_free_all		( a -- )		\ frees a full chain

FUNCTION: BIO_push		( a a -- a )		\ append a bio chain
FUNCTION: BIO_pop		( b -- a )		\ removes bio b and return remainder`

FUNCTION: BIO_get_new_index	( -- i )		\ ????
FUNCTION: BIO_set_flags		( b f -- )		\ sets flags on a bio
FUNCTION: BIO_test_flags	( b f -- i )		\ test flags on a bio
FUNCTION: BIO_clear_flags	( b f -- )		\ clears the flags on a bio

FUNCTION: BIO_ctrl		( b i i a -- i )	\ do a bio command
FUNCTION: BIO_int_ctrl		( b i i i -- i )	\ do a bio command with iarg 
FUNCTION: BIO_ptr_ctrl		( b i i -- a )		\ do a bio command pointer ret

FUNCTION: BIO_nread0		( b *a -- i )		\ 
FUNCTION: BIO_nread		( b *a i -- i )		\ read bytes
FUNCTION: BIO_nwrite0		( b *a -- i )		\ 
FUNCTION: BIO_nwrite		( b *a i -- i )		\ write bytes

PUBLIC

\ BIO callback returns
$01 CONSTANT BIO_CB_FREE
$02 CONSTANT BIO_CB_READ
$03 CONSTANT BIO_CB_WRITE
$04 CONSTANT BIO_CB_PUTS
$05 CONSTANT BIO_CB_GETS
$06 CONSTANT BIO_CB_CTRL
$80 CONSTANT BIO_CB_RETURN

\ nearly all the bio calls got through BIO_ctrl 

$0 CONSTANT BIO_NOCLOSE
$1 CONSTANT BIO_CLOSE

\ BIO_ctrl ops
1  CONSTANT BIO_CTRL_RESET      	\ opt - rewind/zero etc 
2  CONSTANT BIO_CTRL_EOF        	\ opt - are we at the eof 
3  CONSTANT BIO_CTRL_INFO       	\ opt - extra tit-bits 
4  CONSTANT BIO_CTRL_SET        	\ man - set the 'IO' type 
5  CONSTANT BIO_CTRL_GET        	\ man - get the 'IO' type 
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

39 CONSTANT BIO_CTRL_DGRAM_MTU_DISCOVER		\ set DF bit on egress packets

40 CONSTANT BIO_CTRL_DGRAM_QUERY_MTU		\ ask kernel for MTU
47 CONSTANT BIO_CTRL_DGRAM_GET_FALLBACK_MTU
41 CONSTANT BIO_CTRL_DGRAM_GET_MTU		\ get cached MTU
42 CONSTANT BIO_CTRL_DGRAM_SET_MTU		\ set cached MTU

43 CONSTANT BIO_CTRL_DGRAM_MTU_EXCEEDED		\ check if write exceeded MTU

46 CONSTANT BIO_CTRL_DGRAM_GET_PEER
44 CONSTANT BIO_CTRL_DGRAM_SET_PEER		\ dest addr

45 CONSTANT BIO_CTRL_DGRAM_SET_NEXT_TIMEOUT	\ DTLS handshake timeout
48 CONSTANT BIO_CTRL_DGRAM_SET_DONT_FRAG
49 CONSTANT BIO_CTRL_DGRAM_GET_MTU_OVERHEAD

50 CONSTANT BIO_CTRL_DGRAM_SCTP_SET_IN_HANDSHAKE
51 CONSTANT BIO_CTRL_DGRAM_SCTP_ADD_AUTH_KEY
52 CONSTANT BIO_CTRL_DGRAM_SCTP_NEXT_AUTH_KEY
53 CONSTANT BIO_CTRL_DGRAM_SCTP_AUTH_CCS_RCVD
60 CONSTANT BIO_CTRL_DGRAM_SCTP_GET_SNDINFO
61 CONSTANT BIO_CTRL_DGRAM_SCTP_SET_SNDINFO
62 CONSTANT BIO_CTRL_DGRAM_SCTP_GET_RCVINFO
63 CONSTANT BIO_CTRL_DGRAM_SCTP_SET_RCVINFO
64 CONSTANT BIO_CTRL_DGRAM_SCTP_GET_PRINFO
65 CONSTANT BIO_CTRL_DGRAM_SCTP_SET_PRINFO
70 CONSTANT BIO_CTRL_DGRAM_SCTP_SAVE_SHUTDOWN

71 CONSTANT BIO_CTRL_DGRAM_SET_PEEK_MODE

\ fd consts
$02 CONSTANT BIO_FP_READ
$04 CONSTANT BIO_FP_WRITE
$08 CONSTANT BIO_FP_APPEND
$10 CONSTANT BIO_FP_TEXT

\ fd flags
$01 CONSTANT BIO_FLAGS_READ
$02 CONSTANT BIO_FLAGS_WRITE
$04 CONSTANT BIO_FLAGS_IO_SPECIAL
$07 CONSTANT BIO_FLAGS_RWS
$08 CONSTANT BIO_FLAGS_SHOULD_RETRY
$00 CONSTANT BIO_FLAGS_UPLINK

\ base64 passing control flag
$100 CONSTANT BIO_FLAGS_BASE64_NO_NL

\ memory bio flags
$200 CONSTANT BIO_FLAGS_MEM_RDONLY
$400 CONSTANT BIO_FLAGS_NONCLEAR_RST
$800 CONSTANT BIO_FLAGS_IN_EOF

\ mostly POSIX wrappers
100 CONSTANT BIO_C_SET_CONNECT
101 CONSTANT BIO_C_DO_STATE_MACHINE
102 CONSTANT BIO_C_SET_NBIO
104 CONSTANT BIO_C_SET_FD
105 CONSTANT BIO_C_GET_FD
106 CONSTANT BIO_C_SET_FILE_PTR
107 CONSTANT BIO_C_GET_FILE_PTR
108 CONSTANT BIO_C_SET_FILENAME
109 CONSTANT BIO_C_SET_SSL
110 CONSTANT BIO_C_GET_SSL
111 CONSTANT BIO_C_SET_MD
112 CONSTANT BIO_C_GET_MD
113 CONSTANT BIO_C_GET_CIPHER_STATUS
114 CONSTANT BIO_C_SET_BUF_MEM
115 CONSTANT BIO_C_GET_BUF_MEM_PTR
116 CONSTANT BIO_C_GET_BUFF_NUM_LINES
117 CONSTANT BIO_C_SET_BUFF_SIZE
118 CONSTANT BIO_C_SET_ACCEPT
119 CONSTANT BIO_C_SSL_MODE
120 CONSTANT BIO_C_GET_MD_CTX
122 CONSTANT BIO_C_SET_BUFF_READ_DATA
123 CONSTANT BIO_C_GET_CONNECT
124 CONSTANT BIO_C_GET_ACCEPT
125 CONSTANT BIO_C_SET_SSL_RENEGOTIATE_BYTES
126 CONSTANT BIO_C_GET_SSL_NUM_RENEGOTIATES
127 CONSTANT BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT
128 CONSTANT BIO_C_FILE_SEEK
129 CONSTANT BIO_C_GET_CIPHER_CTX
130 CONSTANT BIO_C_SET_BUF_MEM_EOF_RETURN
131 CONSTANT BIO_C_SET_BIND_MODE
132 CONSTANT BIO_C_GET_BIND_MODE
133 CONSTANT BIO_C_FILE_TELL
134 CONSTANT BIO_C_GET_SOCKS
135 CONSTANT BIO_C_SET_SOCKS
136 CONSTANT BIO_C_SET_WRITE_BUF_SIZE
137 CONSTANT BIO_C_GET_WRITE_BUF_SIZE
138 CONSTANT BIO_C_MAKE_BIO_PAIR
139 CONSTANT BIO_C_DESTROY_BIO_PAIR
140 CONSTANT BIO_C_GET_WRITE_GUARANTEE
141 CONSTANT BIO_C_GET_READ_REQUEST
142 CONSTANT BIO_C_SHUTDOWN_WR
143 CONSTANT BIO_C_NREAD0
144 CONSTANT BIO_C_NREAD
145 CONSTANT BIO_C_NWRITE0
146 CONSTANT BIO_C_NWRITE
147 CONSTANT BIO_C_RESET_READ_REQUEST
148 CONSTANT BIO_C_SET_MD_CTX
149 CONSTANT BIO_C_SET_PREFIX
150 CONSTANT BIO_C_GET_PREFIX
151 CONSTANT BIO_C_SET_SUFFIX
152 CONSTANT BIO_C_GET_SUFFIX
153 CONSTANT BIO_C_SET_EX_ARG
154 CONSTANT BIO_C_GET_EX_ARG
155 CONSTANT BIO_C_SET_CONNECT_MODE

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

: BIO_get_flags ( b -- i ) -1 BIO_test_flags ;
: BIO_set_retry_special ( b -- i ) BIO_FLAGS_IO_SPECIAL BIO_FLAGS_SHOULD_RETRY or BIO_set_flags ;
: BIO_set_retry_read ( b -- i ) BIO_FLAGS_READ BIO_FLAGS_SHOULD_RETRY or BIO_set_flags ;
: BIO_set_retry_write ( b -- i ) BIO_FLAGS_WRITE BIO_FLAGS_SHOULD_RETRY or BIO_set_flags ;
: BIO_clear_retry_flags ( b -- i ) BIO_FLAGS_RWS BIO_FLAGS_SHOULD_RETRY or BIO_clear_flags ;
: BIO_get_retry_flags ( b -- i ) BIO_FLAGS_RWS BIO_FLAGS_SHOULD_RETRY or BIO_test_flags ;

: BIO_should_read ( a -- i ) BIO_FLAGS_READ BIO_test_flags ;
: BIO_should_write ( a -- i ) BIO_FLAGS_WRITE BIO_test_flags ;
: BIO_should_io_special ( a -- i ) BIO_FLAGS_IO_SPECIAL BIO_test_flags ;
: BIO_should_retry_type ( a -- i ) BIO_FLAGS_RWS BIO_test_flags ;
: BIO_should_retry ( a -- i ) BIO_FLAGS_SHOULD_RETRY BIO_test_flags ;

: BIO_get_mem_data ( b *a -- i ) BIO_CTRL_INFO swap 0 swap BIO_ctrl ;
: BIO_set_mem_buf ( b a c -- i ) BIO_C_SET_BUF_MEM swap rot BIO_ctrl ;
: BIO_get_mem_ptr ( b *a -- i ) BIO_C_GET_BUF_MEM_PTR swap 0 swap BIO_ctrl ;
: BIO_set_mem_eof_return ( b v -- i ) BIO_C_SET_BUF_MEM_EOF_RETURN swap 0 BIO_ctrl ;

: BIO_get_buffer_num_lines ( b -- i ) BIO_C_GET_BUFF_NUM_LINES _BIO_op ;
: BIO_set_buffer_size ( b i -- i ) BIO_C_SET_BUFF_SIZE swap 0 BIO_ctrl ;
: BIO_set_read_buffer_size ( b i -- i ) BIO_C_SET_BUFF_SIZE swap 0 BIO_int_ctrl ;
: BIO_set_write_buffer_size ( b i -- i ) BIO_C_SET_BUFF_SIZE swap 1 BIO_int_ctrl ;
: BIO_set_buffer_read_data ( b a i -- i ) BIO_C_SET_BUFF_READ_DATA swap rot BIO_ctrl ;


: /ssl ssl +order ;

END-PACKAGE

