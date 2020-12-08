# bmilcs: vim notes

             ^
             k              Hint:  The h key is at the left and moves left.
       < h       l >               The l key is at the right and moves right.
             j                     The j key looks like a down arrow.
             v

cmd | use
--:|:--
x | del 1 character



## CHEAT SHEET
cmd | use
--:|--
o|new line
0|end of line
A|beginning of line


||verb||adverb||noun|
--:|--|--:|--|--:|--|
**d** |delete|**a** | around|**w** | word
**c** |change|**#** | number|**s** ... **)**  | sentence
**y** |yank|**t** |  search & stop before it|**p** ... **}** | paragraph
**v** |visually select|**f** |  search & land on it|**b** | block (programming)
 | | | **l**  | find string (literal or regex)|**t** | tag (html,xml) 

## WOMBO COMBO (SENTENCE)
 cmd|?
--:|--
d2w|	delete 2 words
cis|	change inside sentence (delete current > insert)
yip|	yank inside paragraph (copy current paragraph)
ct<|	change to < (delete everything until next <)

## FILE OPERATIONS
cmd | ?
--:|--
**vi** | open in vim
**:w**  | save changes
**:q!** | quit & discard
**:wq**| write your changes and exit 
**:saveas**| save your file to that location
**ZZ**| a faster way to do :wq 
