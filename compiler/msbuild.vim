" Vim compiler file
" Compiler:	msbuild
" Maintainer:   Filip De Vos	
" Last Change:  22 Sep 2010	

if exists("current_compiler")
  finish
endif
let current_compiler = "msbuild"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

" default errorformat
CompilerSet errorformat&

" default make
CompilerSet makeprg=c:/windows/microsoft.net/framework/v3.5/msbuild.exe\ /nologo\ /maxcpucount\ %
