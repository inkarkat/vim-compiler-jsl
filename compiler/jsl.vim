" Vim compiler file
" Compiler:     JavaScript Lint (http://www.javascriptlint.com)
" Maintainer:   Ingo Karkat <ingo@karkat.de>
"
" DEPENDENCIES:
"  - jsl (http://www.javascriptlint.com). 
"  - jsl.cmd wrapper in this script's directory. 
"
" USAGE:
"   :make
"
" REVISION	DATE		REMARKS 
"	001	20-Mar-2009	file creation

if exists('current_compiler')
    finish
endif
let current_compiler = 'jsl'

if ! (has('win32') || has('win64'))
    echohl ErrorMsg
    let v:errmsg = "FIXME: This compiler plugin is currently limited to Windows!"
    echomsg v:errmsg
    echohl None
    finish
endif

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
    command -nargs=* CompilerSet setlocal <args>
endif

" The jsl.exe wrapper script resides in this script's directory. 
let s:scriptDir = escape( expand('<sfile>:p:h'), ' \' )
execute 'CompilerSet makeprg=\"\"' . s:scriptDir . '\\jsl.cmd\"\ -nologo\ -nofilelisting\ -nosummary\ $*\ -process\ $*\ \"%\"\"'
unlet s:scriptDir

" sample output: 
"C:\TEMP\jsl\jsl-test.js(9): warning: test for equality (==) mistyped as assignment (=)?
"    if (x = y) {
".............^
"
"C:\TEMP\jsl\jsl-test.js(21): lint warning: missing break statement
"    case 1: z = --x;
"....^
"
"C:\TEMP\jsl\jsl-test.js(20): lint warning: undeclared identifier: z
"C:\TEMP\jsl\jsl-test.js(21): lint warning: undeclared identifier: z

" Errorformat: Cp. |errorformat-javac|
" JavaScript Lint emits an empty line after each "pointer line". If we filter
" this away by having the multiline pattern end with "%-Z", the error column
" somehow is counted as a non-virtual column, which is wrong. So we let the
" pattern end with the "pointer line", and filter away the empty line in the
" wrapper. 
"CompilerSet errorformat=%A%f(%l):\ %m,%-Z,%-C%p^,%-C%.%#
CompilerSet errorformat=%A%f(%l):\ %m,%-Z%p^,%-C%.%#

