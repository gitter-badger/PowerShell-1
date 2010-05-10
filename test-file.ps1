# st: trimTrailingWhiteSpaceOnSave false

# ================================================================================
# ********************************************************************************
# WARNING!

# * tidy command (GrammarDev) messes up the gramm3r with -mi; -m seems to work fine,
#     though.
#   The problem is that it inserts \n after some <string> plus spaces
#   To correct: s/<string>\n/<string>; s/<string>\s+/<string>
# ********************************************************************************
# ================================================================================


<#
    Let's see what embedded docs in comments look like...
    TODO: inside here, .<tab> should present list of doc keywords
    
    .synopsis
    this is some text

    .PARAMETER eco
#>

get-thing | out-withyou > $null # destroy

# Same with line comment:
# .synopsis
# TODO: .<tab> should present list of doc keywords here too

# TODO: extract user's session vars and style those too.
# TODO: sytyle all ps automatic variables
$a = $false, $true, $null

# STRINGS ===============================================================

""""
"''"
""
"Eco this is a string"
"`$(hey!)"
"`"This contains `n some `$escaped characters.`b, even quotes `""
"""There are some things that don't""."

"This is more complicated $(get-item | out-string)."
"This is more complicated $(get-item | each-object { out-string } )."
"This is more ""complicated $(get-item; "This is illegal `"()" | foreach-object { () } )."

# TODO: keywords get styled here and they shouldn't
# TODO: % alias could be styled with a lookbehind |i ???
"This is deeply nested $( stuff-here | %{ why-would { $( ("you, do this anyway")) }})"

"This string is 
valid"

"This string is `
valid but the ` is consumed."

"This string is ``
valid but the ` isn't consumed."

"This string is ` 
valid. There's a space at the end."

'This is a valid `
string.'

"Some variables $true here and $false there $_"
"Some escaped variables `$true here and `$false there `$_"

''

# Note there are no escaped sequences here but for ''.
'This is some `n ''$%&/ string too '''

'This should be a string $(get-onions | very-boring | yeah-right)'


@"
   "This is a here string
   here."  `n no escaped chars here.
   But surely $vars are just ${variables here too!}
"@

# Variables:
$this_is_a_vaAriable = 100
${this ` is a variable name} = 100,500
$global:variable
$private:heyyou # Not documented, but it seems to work. TODO: teST!
$script:blah_blah
${script: stupid variable name}

"We need $global:variables in; strings ${ tooh-torooh }"

# TODO: fix this:
@"
    "We need $global:variables in; strings ${ tooh-torooh }"
"@

# array expressions
@( this-is | an-expression | "that evaluates $(to-an | array)");

# array operator

$a = 1,2,3,4
$a = "This, shouldn't be, styled."
$a = $("Guess what, happens ""here, hey""" | "Hm... $(""this, is"" strange.)")

# numeric constants
100, 200, 300
1E+73
0xaf20fff
.5
100.500
100d
.5d
10.5d
1E+3d
0xaf20fffmb
.5gb
100.500kb
100dmb
.5dgb
10.5dmb
1E+3dgb
10*10

# file ext shouldn't be styled as numeric
this-isnot.ps1
a_mistake.here.ps1
"anothermistake.ps1"

switch -regex {
    "abc" { }
    default { "$(this is it)" }


}

do {
 }

get-item $()

if (10 -cgt 100) { }
$a -is $b
$b -contains $c
$x -notcontains $c
100 -and 0

$abc += 200

"this text" >| here.txt; epic-fail

"This $(
        get-item -lt (gi $("this is") -filter "txt.txt"); 10 -gt 11 | out-string | set-content $(gi sublime:output.txt) )"""

# FIXME:
# heredocs also admit subexps. but single pairs of quote are not invalid!
@"
    $(1 -lt 0 | get-item | out-thing "j")
    "This is a normal string."
    """""""
    'This is a single quoted string.'
    # this is not a comment.
"@

@'
    -gt "This that"
'@

What the heck?

0..10 | foreach-object {
            "something $_"
}
"This should not be a {scriptblock}"
{ this-is $(it-at | ) 
}
