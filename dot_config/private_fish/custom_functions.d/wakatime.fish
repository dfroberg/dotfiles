# wakatime for fish
#
# Add this to the fish_prompt function in
# ~/.config/fish/functions/fish_prompt.fish
# (or if it doesn't exist, create it).


# We've also included an example of how
# to determine the current project from the pwd.
# It'll only work without alterations if
# you happen to keep all your projects in
# ~/Sites/ on a Mac, but it's easy to modify

set -l project
set -l project
set -l gitproject (test (which git); git rev-parse --show-toplevel 2>&1)
if test -z "$gitproject"
    set  project (echo $gitproject | sed "s#^/home/$USER/\\([^/]*\\).*#\\1#")
else
    if echo (pwd) | grep -qEi "^/Users/$USER/Sites/"
        set  project (echo (pwd) | sed "s#^/Users/$USER/Sites/\\([^/]*\\).*#\\1#")
    else if echo (pwd) | grep -qEi "^/home/$USER/projects/"
        set  project (echo (pwd) | sed "s#^/home/$USER/projects/\\([^/]*\\).*#\\1#")
    else if echo (pwd) | grep -qEi "^/home/$USER/cluster/"
        set  project (echo (pwd) | sed "s#^/home/$USER/cluster/\\([^/]*\\).*#\\1#")
    else if echo (pwd) | grep -qEi "^/home/$USER/infura/*"
        set  project (echo (pwd) | sed "s#^/home/$USER/infura/\\([^/]*\\).*#\\1#")
    else
        set  project "Terminal"
    end
end

wakatime-cli --write --plugin "fish-wakatime/0.0.1" --entity-type app --project "$project" --entity (echo $history[1] | cut -d ' ' -f1) 2>&1 > /dev/null&
