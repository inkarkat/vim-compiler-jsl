" Vim compiler file
" Compiler:     JavaScript Lint (http://www.javascriptlint.com)
" Maintainer:   Ingo Karkat <ingo@karkat.de>
"
" DEPENDENCIES:
"  - $TOOLBOXHOME points to the base directory of the toolbox that contains the
"    used tools. 
"  - jsl (http://www.javascriptlint.com)
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

execute 'CompilerSet makeprg=\"\"$TOOLBOXHOME\\tools\\JavaScript\\jsl.exe\"\ -nologo\ -nofilelisting\ -nosummary\ $*\ -process\ \"%\"\"'

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
CompilerSet errorformat=%A%f(%l):\ %m,%-Z,%-C%p^,%-C%.%#

