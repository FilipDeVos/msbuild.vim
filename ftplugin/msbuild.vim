" Vim filetype plugin file
" Language:     msbuild	
" Maintainer:   Filip De Vos. Based on the xml ftplugin	
" Last Changed: 22 Sep 2010 

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

setlocal commentstring=<!--%s-->
setlocal comments=s:<!--,m:\ \ \ \ \ ,e:-->

setlocal formatoptions-=t
if !exists("g:ft_xml_autocomment") || (g:ft_xml_autocomment == 1)
    setlocal formatoptions+=croql
endif


" XML:  thanks to Johannes Zellner and Akbar Ibrahim
" - case sensitive
" - don't match empty tags <fred/>
" - match <!--, --> style comments (but not --, --)
" - match <!, > inlined dtd's. This is not perfect, as it
"   gets confused for example by
"       <!ENTITY gt ">">
if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_words =
     \  '<:>,' .
     \  '<\@<=!\[CDATA\[:]]>,'.
     \  '<\@<=!--:-->,'.
     \  '<\@<=?\k\+:?>,'.
     \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
     \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'
endif

"
" For Omni completion, by Mikolaj Machowski.
if exists('&ofu')
  setlocal ofu=xmlcomplete#CompleteTags
endif
command! -nargs=+ XMLns call xmlcomplete#CreateConnection(<f-args>)
command! -nargs=? XMLent call xmlcomplete#CreateEntConnection(<f-args>)


" Change the :browse e filter to primarily show xml-related files.
if has("gui_win32")
    let  b:browsefilter="MsBuild Files (*.proj)\t*.proj\n" .
		\	"CsProject Files (*.csproj)\t*.csproj\n" .
		\	"VbProject Files (*.vbproj)\t*.vbproj\n"
		\	"All Files (*.*)\t*.*\n"
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal commentstring< comments< formatoptions<" .
		\     " | unlet! b:match_ignorecase b:match_words b:browsefilter"

" Restore the saved compatibility options.
let &cpo = s:save_cpo

" set the compiler
compiler msbuild
