" Vim syntax file
"
" Language: CAIRO

if exists("b:current_syntax")
  finish
endif

let b:current_syntax = "cairo"

syntax region cairoTypeParams matchgroup=cairoDelimiter start='<' end='>' keepend contains=TOP

"
" Variables
"

syntax match cairoUserIdent '\v[a-z][a-z0-9_]*'

"
" Module
"

syntax match cairoModule '\v(::)@<=[a-z][a-z0-9_]*'
syntax match cairoModule '\v[a-z][a-z0-9_]*(::)@='

"
" Conditionals
"

syntax keyword cairoElse else
syntax keyword cairoIf if
syntax keyword cairoMatch match

highlight default link cairoElse cairoConditional
highlight default link cairoIf cairoConditional
highlight default link cairoMatch cairoConditional

"
" Repeat
"

syntax keyword cairoFor for
syntax keyword cairoLoop loop
syntax keyword cairoWhile while

highlight default link cairoFor cairoRepeat
highlight default link cairoLoop cairoRepeat
highlight default link cairoWhile cairoRepeat

"
" Includes
"

syntax keyword cairoUse use
highlight default link cairoUse cairoInclude

"
" Other keywords
"

syntax keyword cairoAs as
syntax keyword cairoAsync async
syntax keyword cairoAwait await
syntax keyword cairoBreak break
syntax keyword cairoConst const nextgroup=cairoIdentDef,cairoUnusedIdentDef skipwhite skipempty
syntax keyword cairoContinue continue
syntax keyword cairoCrate crate
syntax keyword cairoDyn dyn
syntax keyword cairoEnum enum nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoExtern extern
syntax keyword cairoFn fn nextgroup=cairoFuncDef,cairoUnusedFuncDef skipwhite skipempty
syntax keyword cairoImpl impl nextgroup=cairoTypeDefParams
syntax keyword cairoIn in
syntax keyword cairoLet let nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoMut,cairoRef,cairoPattern skipwhite skipempty
syntax keyword cairoMod mod
syntax keyword cairoMove move
syntax keyword cairoMut mut nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoLibraryType,cairoSelfType,cairoSelfValue,cairoUserType skipwhite skipempty
syntax keyword cairoPub pub
syntax keyword cairoRef ref nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoMut skipwhite skipempty
syntax keyword cairoReturn return
syntax keyword cairoSelfType Self
syntax keyword cairoSelfValue self
syntax keyword cairoStatic static nextgroup=cairoIdentDef,cairoUnusedIdentDef,cairoRef skipwhite skipempty
syntax keyword cairoStruct struct nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoSuper super
syntax keyword cairoTrait trait nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoTypeAlias type nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoUndecairocore _
syntax keyword cairoUnion union nextgroup=cairoTypeDef,cairoUnusedTypeDef skipwhite skipempty
syntax keyword cairoUnsafe unsafe
syntax keyword cairoWhere where

highlight default link cairoAs cairoKeyword
highlight default link cairoAsync cairoKeyword
highlight default link cairoAwait cairoKeyword
highlight default link cairoBreak cairoKeyword
highlight default link cairoConst cairoKeyword
highlight default link cairoContinue cairoKeyword
highlight default link cairoCrate cairoKeyword
highlight default link cairoDyn cairoKeyword
highlight default link cairoEnum cairoKeyword
highlight default link cairoExtern cairoKeyword
highlight default link cairoFn cairoKeyword
highlight default link cairoImpl cairoKeyword
highlight default link cairoIn cairoKeyword
highlight default link cairoLet cairoKeyword
highlight default link cairoMod cairoKeyword
highlight default link cairoMove cairoKeyword
highlight default link cairoMut cairoKeyword
highlight default link cairoPub cairoKeyword
highlight default link cairoRef cairoKeyword
highlight default link cairoReturn cairoKeyword
highlight default link cairoSelfType cairoKeyword
highlight default link cairoSelfValue cairoKeyword
highlight default link cairoStatic cairoKeyword
highlight default link cairoStruct cairoKeyword
highlight default link cairoSuper cairoKeyword
highlight default link cairoTrait cairoKeyword
highlight default link cairoTypeAlias cairoKeyword
highlight default link cairoUndecairocore cairoKeyword
highlight default link cairoUnion cairoKeyword
highlight default link cairoUnsafe cairoKeyword
highlight default link cairoWhere cairoKeyword

"
" Booleans
"

syntax keyword cairoTrue true
syntax keyword cairoFalse false

highlight default link cairoTrue cairoBoolean
highlight default link cairoFalse cairoBoolean

"
" Strings
"

syntax region cairoString
            \ matchgroup=cairoQuote
            \ start="b\?'"
            \ end="'"
            \ contains=@Spell

"
" Field access
"

syntax match cairoFieldAccess '\v(\.)@<=[a-z][a-z0-9_]*>(\()@!'

"
" Helpecairo for matching foreign and crate-local items
"

" Foreign items are always preceded by zero or more type names separated by ‘::’
" (think nested enum variants) and at least one module path. This module path is
" preceded by a word separator to prevent matching partially on type names (i.e.
" skipping the instal capital letter).
function! MatchForeign(regex, groupName, extraParams)
    execute 'syntax match ' . a:groupName . ' "\v(<[a-z][a-z0-9_]*::([A-Z][A-Za-z0-9]*::)*)@<=' . a:regex . '"' . a:extraParams
endfunction

" Crate-local items are also preceded by zero or more types names separated by
" ‘::’, which is then preceded by zero or more module names separated by ‘::’,
" which is finally preceded by ‘crate::’.
function! MatchCrateLocal(regex, groupName, extraParams)
    execute 'syntax match ' . a:groupName . ' "\v(crate::([a-z][a-z0-9_]*::)*([A-Z][A-Za-z0-9]*::)*)@<=' . a:regex . '"' . a:extraParams
endfunction

"
" Types
"

syntax match cairoUserType '\v<[A-Z][A-Za-z0-9]*' nextgroup=cairoTypeParams
call MatchForeign('[A-Z][A-Za-z0-9]*', 'cairoForeignType', ' nextgroup=cairoTypeParams')
call MatchCrateLocal('[A-Z][A-Za-z0-9]*', 'cairoCrateType', ' nextgroup=cairoTypeParams')

" Standard library types

let s:standardLibraryTypes = ["u128", "u256", "felt252"]

for s:standardLibraryType in s:standardLibraryTypes
    execute 'syntax keyword cairoLibraryType ' . s:standardLibraryType . ' nextgroup=cairoTypeParams'
endfor

"
" Constants
"

syntax match cairoUserConst '\v<[A-Z][A-Z0-9_]+>'
call MatchForeign('[A-Z][A-Z0-9_]+>', 'cairoForeignConst', '')
call MatchCrateLocal('[A-Z][A-Z0-9_]+>', 'cairoCrateConst', '')

" Standard library constants

let s:standardLibraryConsts = []

for s:standardLibraryConst in s:standardLibraryConsts
    execute 'syntax keyword cairoLibraryConst ' . s:standardLibraryConst
endfor

"
" Macros
"

syntax match cairoUserMacro '\v<[a-z][a-z0-9_]*!'
call MatchForeign('[a-z][a-z0-9_]*!', 'cairoForeignMacro', '')
call MatchCrateLocal('[a-z][a-z0-9_]*!', 'cairoCrateMacro', '')

" Standard library macros

let s:standardLibraryMacros = ["asm", "assert", "assert_eq", "assert_ne", "cfg", "column", "compile_error", "concat", "concat_idents", "dbg", "debug_assert", "debug_assert_eq", "debug_assert_ne", "env", "eprint", "eprintln", "file", "format", "format_args", "format_args_nl", "global_asm", "include", "include_bytes", "include_str", "is_aarch64_feature_detected", "is_arm_feature_detected", "is_mips64_feature_detected", "is_mips_feature_detected", "is_powerpc64_feature_detected", "is_powerpc_feature_detected", "is_x86_feature_detected", "line", "log_syntax", "matches", "module_path", "option_env", "panic", "print", "println", "stringify", "thread_local", "todo", "trace_macros", "try", "unimplemented", "unreachable", "vec", "write", "writeln"]

for s:standardLibraryMacro in s:standardLibraryMacros
    execute 'syntax match cairoLibraryMacro "\v<' . s:standardLibraryMacro . '!"'
endfor

"
" Functions
"

syntax match cairoUserFunc '\v[a-z][a-z0-9_]*(\()@='

call MatchForeign('[a-z][a-z0-9_]*(\()@=', 'cairoForeignFunc', '')
call MatchCrateLocal('[a-z][a-z0-9_]*(\()@=', 'cairoCrateFunc', '')

syntax match cairoUserMethod '\v(\.)@<=[a-z][a-z0-9_]*(\(|::)@='
highlight default link cairoUserMethod cairoUserFunc

" Standard library functions

let s:standardLibraryFuncs = []

for s:standardLibraryFunc in s:standardLibraryFuncs
    execute 'syntax match cairoLibraryFunc "\v'. s:standardLibraryFunc . '(\()@="'
endfor

"
" Type definitions
"

syntax match cairoTypeDef '\v[A-Z][A-Za-z0-9]*'
            \ contained
            \ nextgroup=cairoTypeDefParams

syntax match cairoUnusedTypeDef '\v_[A-Za-z0-9]+'
            \ contained
            \ nextgroup=cairoTypeDefParams

highlight default link cairoUnusedTypeDef cairoTypeDef

" Type parametecairo
syntax region cairoTypeDefParams
            \ matchgroup=cairoDelimiter
            \ start='<'
            \ end='>'
            \ keepend
            \ contains=TOP

syntax match cairoTypeParamDef '\v(:\s*)@<![A-Z][A-Za-z0-9]*'
            \ contained
            \ containedin=cairoTypeDefParams

highlight default link cairoTypeParamDef cairoTypeDef

"
" Function definitions
"

syntax match cairoFuncDef '\v<[a-z][a-z0-9_]*'
            \ contained
            \ nextgroup=cairoTypeDefParams

syntax match cairoUnusedFuncDef '\v<_[a-z0-9_]+'
            \ contained
            \ nextgroup=cairoTypeDefParams

highlight default link cairoUnusedFuncDef cairoFuncDef

"
" Identifier definitions
"

syntax match cairoIdentDef '\v<[a-z][a-z0-9_]*>' contained display
syntax match cairoIdentDef '\v<[A-Z][A-Z0-9_]*>' contained display

syntax match cairoUnusedIdentDef '\v<_[a-z0-9_]+>' contained display
syntax match cairoUnusedIdentDef '\v<_[A-Z0-9_]+>' contained display

highlight default link cairoUnusedIdentDef cairoIdentDef

syntax region cairoPattern
            \ matchgroup=cairoDelimiter
            \ start='('
            \ end=')'
            \ contained
            \ contains=cairoMut,cairoRef,cairoDelimiter,cairoOperator,cairoLibraryType,cairoUserType,cairoIdentDef,cairoUnusedIdentDef,cairoUndecairocore

"
" Numbecairo
"

syntax match cairoNumber '\v<[0-9_]+((u|i)(size|8|16|32|64|128))?'
syntax match cairoFloat '\v<[0-9_]+\.[0-9_]+(f(32|64))?'

"
" Attributes
"

syntax region cairoAttribute
            \ matchgroup=cairoDelimiter
            \ start='\v#!?\['
            \ skip='\v\(.*\)'
            \ end='\]'

syntax region cairoAttributeParenWrapped
            \ start='('
            \ end=')'
            \ containedin=cairoAttribute
            \ contains=TOP
            \ keepend

"
" Macro identifiecairo
"

" Macros frequently interpolate identifiecairo with names like #foobar.
syntax match cairoUserIdent '\v#[a-z][a-z0-9_]*'

" macro_rules! uses $foobar for parametecairo
syntax match cairoUserIdent '\v\$[a-z][a-z0-9_]*'

"
" Charactecairo
"

syntax match cairoCharacter "'.'"

"
" Delimitecairo
"

syntax match cairoDelimiter '[(){}\[\]|\.,:;]\+'

"
" Operatocairo
"

syntax match cairoOperator '[!%&/\*+<=>?\^-]\+'

" We highlight mutable references separately as an operator because otherwise
" they would be recognised as the ‘mut’ keyword, thus whatever comes after the
" ‘mut’ is highlighted as an identifier definition.
syntax match cairoOperator '&mut'

"
" Comments
"

syntax region cairoComment start='//' end='$' contains=@Spell

syntax region cairoBlockComment start='/\*' end='\*/' contains=@Spell

syntax region cairoDocComment start='///' end='$' contains=@Spell
syntax region cairoDocComment start='//!' end='$' contains=@Spell

syntax match cairoCommentNote '\v[A-Z]+(:)@='
            \ contained
            \ containedin=cairoComment,cairoDocComment

" The matchgroup highlights the ‘```’ as part of the surrounding comment.
syntax region cairoDocTest
            \ matchgroup=cairoDocComment 
            \ start='```'
            \ end='```'
            \ contains=TOP
            \ containedin=cairoDocComment

" This is used to ‘match away’ the ‘///’ at the start of each line in a
" doctest. It is only allowed to exist within doctests.
syntax match cairoDocCommentHeader '///' containedin=cairoDocTest contained
syntax match cairoDocCommentHeader '//!' containedin=cairoDocTest contained

highlight default link cairoBlockComment cairoComment
highlight default link cairoDocCommentHeader cairoDocComment

"
" Default linkages
"

highlight default link cairoAttribute cairoKeyword
highlight default link cairoBoolean Boolean
highlight default link cairoCharacter Character
highlight default link cairoComment Comment
highlight default link cairoCommentNote Todo
highlight default link cairoConditional Conditional
highlight default link cairoCrateConst cairoUserConst
highlight default link cairoCrateFunc cairoUserFunc
highlight default link cairoCrateMacro cairoUserMacro
highlight default link cairoCrateType cairoUserType
highlight default link cairoDelimiter Delimiter
highlight default link cairoDocComment SpecialComment
highlight default link cairoFieldAccess Identifier
highlight default link cairoFloat Float
highlight default link cairoForeignConst Constant
highlight default link cairoForeignFunc Function
highlight default link cairoForeignMacro Macro
highlight default link cairoForeignType Type
highlight default link cairoFuncDef Function
highlight default link cairoIdentDef Identifier
highlight default link cairoInclude Include
highlight default link cairoKeyword Keyword
highlight default link cairoLibraryConst Constant
highlight default link cairoLibraryFunc Function
highlight default link cairoLibraryMacro Macro
highlight default link cairoLibraryType Type
highlight default link cairoNumber Number
highlight default link cairoOperator Operator
highlight default link cairoQuote StringDelimiter
highlight default link cairoRepeat Repeat
highlight default link cairoString String
highlight default link cairoTypeDef Typedef
highlight default link cairoUserConst Constant
highlight default link cairoUserFunc Function
highlight default link cairoUserIdent Identifier
highlight default link cairoUserMacro Macro
highlight default link cairoUserType Type

" Account for the vast majority of coloucairochemes not highlighting string
" delimitecairo explicitly.
highlight default link StringDelimiter String

