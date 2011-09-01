# AWK functions for distbb

#use "multisub.awk"

function quote_html_symbols (s){
	return multisub(s, "<:&lt;   >:&gt;   &:&amp;")
}
