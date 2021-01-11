#! /bin/sh

GIT_LOGO=$(printf '\uf1d3')
git_branch() {
	git branch &> /dev/null

	# if return status of previous command is 0, then only proceed
	gitStatus=$?
    [[ $gitStatus -ne 0 ]] && echo -ne ""
    if [[ $gitStatus -eq 0 ]]; then
        local git_branch=$(git branch | grep '*' | awk '{print $2}')
        echo -ne "%F{#4de393}" $GIT_LOGO "" $git_branch "%f"
    fi
}


# Icons:  : f457, : f467,  : f440

gitInfo()  {
    git branch &> /dev/null
    gitStatus=$?
    [[ $gitStatus -ne 0 ]] && echo ""

    [[ $gitStatus -eq 0 ]] && git status --porcelain | awk '
		BEGIN { 
			ORS="";
			mod=0; dirty=0; 
		}
		{
			if ($1 == "M") mod+=1; 
			if ($1 == "??") dirty+=1; 
		}
		END {
			if (mod > 0) print " %F{#e9ff5c}", mod, "%f";
			if (dirty > 0) print "%F{#36ff9e}", dirty, "%f";
		}
	'
}
