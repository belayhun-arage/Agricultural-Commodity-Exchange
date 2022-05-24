final STATUS_CODES = {
      100 : "Status Continue"                     , // RFC 7231, 6.2.1
	    101 : "Status Switching Protocols"           , // RFC 7231, 6.2.2
	    102 : "Status Processing"                   , // RFC 2518, 10.1
	    103 : "Status Early Hints"                   , // RFC 8297
	    200 : "Status OK"                           , // RFC 7231, 6.3.1
	    201 : "Status Created"                      , // RFC 7231, 6.3.2
	    202 : "Status Accepted"                     , // RFC 7231, 6.3.3
	    203 : "Status Non Authoritative Info"         , // RFC 7231, 6.3.4
	    204 : "Status No Content"                    , // RFC 7231, 6.3.5
	    205 : "Status Reset Content"                 , // RFC 7231, 6.3.6
	    206 : "Status Partial Content"               , // RFC 7233, 4.1
	    207 : "Status Multi Status"                  , // RFC 4918, 11.1
	    208 : "Status Already Reported"              , // RFC 5842, 7.1
	    226 : "Status IMUsed"                       , // RFC 3229, 10.4.1
	    300 : "Status Multiple Choices"              , // RFC 7231, 6.4.1
	    301 : "Status Moved Permanently"             , // RFC 7231, 6.4.2
	    302 : "Status Found"                        , // RFC 7231, 6.4.3
	    303 : "Status See Other"                     , // RFC 7231, 6.4.4
	    304 : "Status Not Modified"                  , // RFC 7232, 4.1
	    305 : "Status Use Proxy"                     , // RFC 7231, 6.4.5
	    307 : "Status Temporary Redirect"            , // RFC 7231, 6.4.7
	    308 : "Status Permanent Redirect"            , // RFC 7538, 3
	    400 : "Status Bad Request"                   , // RFC 7231, 6.5.1
	    401 : "Status Unauthorized"                 , // RFC 7235, 3.1
	    402 : "Status Payment Required"              , // RFC 7231, 6.5.2
	    403 : "Status Forbidden"                    , // RFC 7231, 6.5.3
	    404 : "Status Not Found"                     , // RFC 7231, 6.5.4
	    405 : "Status Method Not Allowed"             , // RFC 7231, 6.5.5
	    406 : "Status Not Acceptable"                , // RFC 7231, 6.5.6
	    407 : "Status Proxy Auth Required"            , // RFC 7235, 3.2
	    408 : "Status Request Timeout"               , // RFC 7231, 6.5.7
	    409 : "Status Conflict"                     , // RFC 7231, 6.5.8
	    410 : "Status Gone"                         , // RFC 7231, 6.5.9
	    411 : "Status Length Required"               , // RFC 7231, 6.5.10
	    412 : "Status Precondition Failed"           , // RFC 7232, 4.2
	    413 : "Status Request Entity TooLarge"        , // RFC 7231, 6.5.11
	    414 : "Status Request URI TooLong"            , // RFC 7231, 6.5.12
	    415 : "Status Unsupported Media Type"         , // RFC 7231, 6.5.13
	    416 : "Status Requested Range Not Satisfiable" , // RFC 7233, 4.4
	    417 : "Status Expectation Failed"            , // RFC 7231, 6.5.14
	    418 : "Status Teapot"                       , // RFC 7168, 2.3.3
	    421 : "Status Misdirected Request"           , // RFC 7540, 9.1.2
	    422 : "Status Unprocessable Entity"          , // RFC 4918, 11.2
	    423 : "Status Locked"                       , // RFC 4918, 11.3
	    424 : "Status Failed Dependency"             , // RFC 4918, 11.4
	    425 : "Status Too Early"                     , // RFC 8470, 5.2.
	    426 : "Status Upgrade Required"              , // RFC 7231, 6.5.15
	    428 : "Status Precondition Required"         , // RFC 6585, 3
	    429 : "Status Too Many Requests"              , // RFC 6585, 4
	    431 : "Status Request Header Fields TooLarge"  , // RFC 6585, 5
	    451 : "Status Unavailable For Legal Reasons"   , // RFC 7725, 3
	    500 : "Status Internal Server Error"          , // RFC 7231, 6.6.1
	    501 : "Status Not Implemented"               , // RFC 7231, 6.6.2
	    502 : "Status Bad Gateway"                   , // RFC 7231, 6.6.3
	    503 : "Status Service Unavailable"           , // RFC 7231, 6.6.4
	    504 : "Status Gateway Timeout"               , // RFC 7231, 6.6.5
	    505 : "Status HTTP Version Not Supported"      , // RFC 7231, 6.6.6
	    506 : "Status Variant Also Negotiates"        , // RFC 2295, 8.1
	    507 : "Status Insufficient Storage"          , // RFC 4918, 11.5
	    508 : "Status Loop Detected"                 , // RFC 5842, 7.2
	    510 : "Status Not Extended"                  , // RFC 2774, 7
	    511 : "Status Network Authentication Required", // RFC 6585, 6 

      // this one is added intentionally to represent network conn problem.
      999 : "Network Connection Problem" 
};