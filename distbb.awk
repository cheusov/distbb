# AWK functions for distbb

#use "multisub.awk"
#use "braceexpand.awk"

function quote_html_symbols (s)
{
	return multisub(s, "<:&lt;   >:&gt;   &:&amp;")
}

function prepand_pkgpath (prefix)
{
	# $0 is processed and changed!!!
	field = substr($0, 1, RLENGTH-1)
	$0 = substr($0, RLENGTH+1)
	for (i=1; i <= NF; ++i){
		if ($i ~ /[{]/){
			$i = braceexpand($i)
			gsub(/ /, "," prefix, $i)
			gsub(/[.][.]\/[.][.]\//, "../../" prefix, $i)
			$i = "{" prefix $i "}"
		}else{
			sub(/[.][.]\/[.][.]\//, "../../" prefix, $i)
			$i = prefix $i
		}
	}
	$0 = (field "=" $0)
}
