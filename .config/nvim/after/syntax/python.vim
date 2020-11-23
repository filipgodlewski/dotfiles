" File headers
syn match   pythonShebang       '\%^#!.*$'
syn match   pythonCoding        '\%^.*\%(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$'

" Importing
syn keyword pythonImport        import as
syn match   pythonImport        '^\s*\zsfrom\>'

" Classes
syn keyword pythonClassVar      self cls other containedin=pythonStrInterReg nextgroup=pythonVariable,pythonFunction
syn match   pythonVariable 	'\w\.\(\h\w*\)\@>\(__\)\@<!\((\)\@!'hs=s+2 display containedin=pythonStrInterReg

" Statements
syn match   pythonStatement     '\v\.@<!<await>'
syn match   pythonFunction      '\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*' display contained
syn match   pythonFunction      '\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\ze\%(\s*(\)'
syn match   pythonStatement     '\<async\s\+def\>' nextgroup=pythonFunction skipwhite
syn match   pythonStatement     '\<async\s\+with\>'
syn match   pythonStatement     '\<async\s\+for\>'
syn match   pythonStatement     '\<from\>'
syn keyword pythonOperator	and in is not or containedin=pythonStrInterReg
syn keyword pythonOperator	elif else if containedin=pythonStrInterReg
syn keyword pythonStatement	False None True containedin=pythonStrInterReg

" Builtin Functions
syn keyword pythonBuiltin	abs all any bin bool bytearray callable chr
syn keyword pythonBuiltin	classmethod compile complex delattr dict dir
syn keyword pythonBuiltin	divmod enumerate eval filter float format
syn keyword pythonBuiltin	frozenset getattr globals hasattr hash
syn keyword pythonBuiltin	help hex id input int isinstance
syn keyword pythonBuiltin	issubclass iter len list locals map max
syn keyword pythonBuiltin	memoryview min next object oct open ord pow
syn keyword pythonBuiltin	print property range repr reversed round set
syn keyword pythonBuiltin	setattr slice sorted staticmethod str
syn keyword pythonBuiltin	sum super tuple type vars zip __import__
syn keyword pythonBuiltin	ascii bytes exec
syn keyword pythonBuiltin	append sort reverse extend insert remove pop count
syn keyword pythonBuiltin	capitalize casefold center encode endswith expandtabs
syn keyword pythonBuiltin	find format_map index
syn keyword pythonBuiltin	isalnum isaplha isdecimal isdigit isidentifier islower
syn keyword pythonBuiltin	isnumeric isprintable isspace istitle isupper
syn keyword pythonBuiltin	breakpoint

" Builtin Objects
syn keyword pythonBuiltin       __doc__ __file__ __name__ __package__ containedin=pythonFunction
syn keyword pythonBuiltin       __qualname__ __module__ __defaults__ __code__ containedin=pythonFunction
syn keyword pythonBuiltin       __globals__ __dict__ __closure__ __annotations__ __kwdefaults__ containedin=pythonFunction
syn keyword pythonBuiltin       __new__ __init__ __post_init__ __init_subclass__ __del__ __repr__ containedin=pythonFunction
syn keyword pythonBuiltin       __str__ __bytes__ __format__ containedin=pythonFunction
syn keyword pythonBuiltin       __lt__ __le__ __eq__ __ne__ __gt__ __ge__ containedin=pythonFunction
syn keyword pythonBuiltin       __hash__ __bool__ containedin=pythonFunction
syn keyword pythonBuiltin       __getattr__ __getattribute__ __setattr__ __delattr__ __dir__ containedin=pythonFunction
syn keyword pythonBuiltin       __get__ __set__ __delete__ __set_name__ containedin=pythonFunction
syn keyword pythonBuiltin       __slots__ __weakref__ containedin=pythonFunction
syn keyword pythonBuiltin       __mro_entries__ __prepare__ __class__ containedin=pythonFunction
syn keyword pythonBuiltin       __instancecheck__ __subclasscheck__ containedin=pythonFunction
syn keyword pythonBuiltin       __class_getitem__ __call__ containedin=pythonFunction
syn keyword pythonBuiltin       __len__ __length_hint__ __getitem__ __setitem__ __delitem__ containedin=pythonFunction
syn keyword pythonBuiltin       __missing__ __iter__ __reversed__ __contains__ containedin=pythonFunction
syn keyword pythonBuiltin       __add__ __sub__ __mul__ __matmul__ __truediv__ __floordiv__ containedin=pythonFunction
syn keyword pythonBuiltin       __mod__ __divmod__ __pow__ __lshift__ _rshift__ containedin=pythonFunction
syn keyword pythonBuiltin       __and__ __xor__ __or__ containedin=pythonFunction
syn keyword pythonBuiltin       __radd__ __rsub__ __rmul__ __rmatmul__ __rtruediv__ __rfloordiv__ containedin=pythonFunction
syn keyword pythonBuiltin       __rmod__ __rdivmod__ __rpow__ __rlshift__ _rshift__ containedin=pythonFunction
syn keyword pythonBuiltin       __rand__ __rxor__ __ror__ containedin=pythonFunction
syn keyword pythonBuiltin       __iadd__ __isub__ __imul__ __imatmul__ __itruediv__ __ifloordiv__ containedin=pythonFunction
syn keyword pythonBuiltin       __imod__ __idivmod__ __ipow__ __ilshift__ _rshift__ containedin=pythonFunction
syn keyword pythonBuiltin       __iand__ __ixor__ __ior__ containedin=pythonFunction
syn keyword pythonBuiltin       __neg__ __pos__ __abs__ __invert__ __complex__ containedin=pythonFunction
syn keyword pythonBuiltin       __int__ __float__ __index__ __round__ __trunc__ containedin=pythonFunction
syn keyword pythonBuiltin       __floor__ __ceil__ containedin=pythonFunction
syn keyword pythonBuiltin       __enter__ __exit__ __await__ containedin=pythonFunction
syn keyword pythonBuiltin       __loader__ __spec__ __path__ __cached__ containedin=pythonFunction
syn keyword pythonBuiltin       __debug__ containedin=pythonFunction
syn keyword pythonBuiltin       NotImplemented Ellipsis

" Builtin Types
syn match   pythonBuiltin       '\v\.@<!<%(object|bool|int|float|tuple|str|list|dict|set|frozenset|bytearray|bytes)>'

" Builtin Exceptions
syn keyword pythonStatement     raise nextgroup=pythonExceptions skipwhite
syn keyword pythonExceptions	BaseException Exception
syn keyword pythonErrors	ArithmeticError BufferError
syn keyword pythonErrors	LookupError
syn keyword pythonErrors	EnvironmentError
syn keyword pythonErrors	AssertionError AttributeError
syn keyword pythonErrors	EOFError FloatingPointError GeneratorExit
syn keyword pythonErrors	ImportError IndentationError
syn keyword pythonErrors	IndexError KeyError KeyboardInterrupt
syn keyword pythonErrors	MemoryError NameError NotImplementedError
syn keyword pythonErrors	OSError OverflowError ReferenceError
syn keyword pythonErrors	RuntimeError StopIteration SyntaxError
syn keyword pythonErrors	SystemError SystemExit TabError TypeError
syn keyword pythonErrors	UnboundLocalError UnicodeError
syn keyword pythonErrors	UnicodeDecodeError UnicodeEncodeError
syn keyword pythonErrors	UnicodeTranslateError ValueError
syn keyword pythonErrors	ZeroDivisionError
syn keyword pythonErrors	BlockingIOError BrokenPipeError
syn keyword pythonErrors	ChildProcessError ConnectionAbortedError
syn keyword pythonErrors	ConnectionError ConnectionRefusedError
syn keyword pythonErrors	ConnectionResetError FileExistsError
syn keyword pythonErrors	FileNotFoundError InterruptedError
syn keyword pythonErrors	IsADirectoryError NotADirectoryError
syn keyword pythonErrors	PermissionError ProcessLookupError
syn keyword pythonErrors	RecursionError StopAsyncIteration
syn keyword pythonErrors	TimeoutError
syn keyword pythonErrors	IOError VMSError WindowsError
syn keyword pythonWarnings	BytesWarning DeprecationWarning FutureWarning
syn keyword pythonWarnings	ImportWarning PendingDeprecationWarning
syn keyword pythonWarnings	RuntimeWarning SyntaxWarning UnicodeWarning
syn keyword pythonWarnings	UserWarning Warning
syn keyword pythonWarnings	ResourceWarning

" Numbers
syn match   pythonNumber        '\<\d\>' display containedin=pythonStrInterReg
syn match   pythonNumber        '\<[1-9][_0-9]*\d\>' display containedin=pythonStrInterReg
syn match   pythonNumber        '\<\d[jJ]\>' display containedin=pythonStrInterReg
syn match   pythonNumber        '\<[1-9][_0-9]*\d[jJ]\>' display containedin=pythonStrInterReg
syn match   pythonNumber        '\<0[xX][_0-9a-fA-F]*\x\>' display containedin=pythonStrInterReg " hex
syn match   pythonNumber        '\<0[oO][_0-7]*\o\>' display containedin=pythonStrInterReg " oct
syn match   pythonNumber        '\<0[bB][_01]*[01]\>' display containedin=pythonStrInterReg " bin

" Decorators
syn match   pythonDecorator     '^\s*\zs@' display nextgroup=pythonDecoratorName skipwhite
syn match   pythonDecoratorName '\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\)*' display contained
syn match   pythonDot           '\.' display containedin=pythonDecoratorName,pythonVariable,pythonFunction

" Python 3 byte strings
syn region pythonBytes          start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes          start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes          start=+[bB]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell
syn region pythonBytes          start=+[bB]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest2,pythonSpaceError,@Spell

syn match pythonBytesError      '.\+' display contained
syn match pythonBytesContent    '[\u0000-\u00ff]\+' display contained contains=pythonBytesEsc,pythonBytesEscError containedin=pythonBytes

syn match pythonBytesEsc        +\\[abfnrtv'"\\]+ display contained
syn match pythonBytesEsc        '\\\o\o\=\o\=' display contained
syn match pythonBytesEscError   '\\\o\{,2}[89]' display contained
syn match pythonBytesEsc        '\\x\x\{2}' display contained
syn match pythonBytesEscError   '\\x\x\=\X' display contained
syn match pythonBytesEsc        '\\$'

syn match pythonUniEsc          '\\u\x\{4}' display contained
syn match pythonUniEscError     '\\u\x\{,3}\X' display contained
syn match pythonUniEsc          '\\U\x\{8}' display contained
syn match pythonUniEscError     '\\U\x\{,7}\X' display contained
syn match pythonUniEsc          '\\N{[A-Z ]\+}' display contained
syn match pythonUniEscError     '\\N{[^A-Z ]\+}' display contained

" Strings
syn region pythonString         start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonString         start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonString         start=+'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest,pythonSpaceError,@Spell
syn region pythonString         start=+"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest2,pythonSpaceError,@Spell

syn region pythonFString        start=+[fF]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonFString        start=+[fF]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,@Spell
syn region pythonFString        start=+[fF]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest,pythonSpaceError,@Spell
syn region pythonFString        start=+[fF]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonBytesEsc,pythonBytesEscError,pythonUniEsc,pythonUniEscError,pythonDocTest2,pythonSpaceError,@Spell

" Python 3 raw strings
syn region pythonRawString      start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawString      start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawString      start=+[rR]'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawString      start=+[rR]"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell

syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawFString     start=+\%([fF][rR]\|[rR][fF]\)"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEsc,@Spell
syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)'''+ skip=+\\'+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell
syn region pythonRawBytes       start=+\%([bB][rR]\|[rR][bB]\)"""+ skip=+\\"+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell

syn match pythonRawEsc          +\\['"]+ display contained

" % operator string formatting
syn match pythonStrFormatting   '%\%(([^)]\+)\)\=[-#0 +]*\d*\%(\.\d\+\)\=[hlL]\=[diouxXeEfFgGcrs%]' contained containedin=pythonString,pythonRawString,pythonBytesContent
syn match pythonStrFormatting   '%[-#0 +]*\%(\*\|\d\+\)\=\%(\.\%(\*\|\d\+\)\)\=[hlL]\=[diouxXeEfFgGcrs%]' contained containedin=pythonString,pythonRawString,pythonBytesContent

" str.format syntax
syn match pythonStrFormat       "{\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)\=\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\[\%(\d\+\|[^!:\}]\+\)\]\)*\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}" contained containedin=pythonString,pythonRawString
syn region pythonStrInterReg    start="{"he=e+1,rs=e+1 end="\%(![rsa]\)\=\%(:\%({\%(\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\|\d\+\)}\|\%([^}]\=[<>=^]\)\=[ +-]\=#\=0\=\d*,\=\%(\.\d\+\)\=[bcdeEfFgGnosxX%]\=\)\=\)\=}"hs=s-1,re=s-1 extend contained containedin=pythonFString,pythonRawFString contains=pythonStrInterpRegion,@pythonExpression
syn keyword myword HELP containedin=pythonStrInterReg
syn match pythonStrFormat       "{{\|}}" contained containedin=pythonString,pythonRawString,pythonFString,pythonRawFString

" string.Template format
syn match pythonStrTemplate     '\$\$' contained containedin=pythonString,pythonRawString
syn match pythonStrTemplate     '\${[a-zA-Z_][a-zA-Z0-9_]*}' contained containedin=pythonString,pythonRawString
syn match pythonStrTemplate     '\$[a-zA-Z_][a-zA-Z0-9_]*' contained containedin=pythonString,pythonRawString

" setup
hi          pythonClassVar      ctermfg=008 guifg=#4C566A cterm=italic gui=italic
hi link     pythonShebang       Comment
hi link     pythonCoding        Comment
hi link     pythonBuiltin       Number
hi link     pythonExceptions    pythonBuiltin
hi          pythonWarnings      ctermfg=003 guifg=#EBCB8B
hi          pythonErrors        ctermfg=001 guifg=#BF616A
hi link     pythonDecorator     pythonDecorator
hi link     pythonDecoratorName Function
hi link     pythonDot           NormalNC
hi link     pythonBytes         pythonString
hi link     pythonBytesError    pythonErrors
hi link     pythonBytesEsc      Comment
hi link     pythonBytesEscError pythonErrors
hi link     pythonBytesContent  pythonString
hi link     pythonFString       pythonString
hi link     pythonRawBytes      pythonString
hi link     pythonRawEsc        Comment
hi link     pythonRawFString    pythonString
hi link     pythonStrInterReg   SpecialChar
hi link     pythonStrFormatting SpecialChar
hi link     pythonStrFormat     SpecialChar
hi link     pythonStrTemplate   SpecialChar
hi link     pythonUniEsc        Comment
hi link     pythonUniEscError   pythonErrors
hi link     myword              WarningMsg
hi          pythonVariable      ctermfg=002 guifg=#A3BE8C cterm=bold gui=bold
