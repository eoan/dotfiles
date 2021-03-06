alias gdrive='google-drive-ocamlfuse -label mine ~/gdrive'
alias standrive='google-drive-ocamlfuse standrive'
alias no-gdrive='fusermount -u gdrive'
alias no-standrive='fusermount -u standrive'
alias s='cat ~/sc'
alias regenerate='sudo apt-get update && sudo apt-get upgrade'
alias get='sudo apt-get install'
alias moc='padsp mocp'
alias phd="vim -S $HOME/phd/.phdsession.vim"
alias SalliesMinutes='wmctrl -r :ACTIVE: -N Terminal && cp /home/aj/Documents/sallies/.template.mkd /home/aj/Documents/sallies/meeting_$(date +%F).mkd && sed -i "1 s/Date/$(date +%d | sed s/^0//)$(grep $(date +%d) /home/aj/Documents/sallies/.datecheat | sed s/.*#//)\ $(date +%B)/" /home/aj/Documents/sallies/meeting_$(date +%F).mkd && pandoc --smart --template=/home/aj/.vim/pandoc-templates/ajpdf --latex-engine=xelatex /home/aj/Documents/sallies/meeting_$(date +%F).mkd -o /home/aj/Documents/sallies/meeting_$(date +%F).pdf && evince /home/aj/Documents/sallies/meeting_$(date +%F).pdf 2>/dev/null & sleep 5 && wmctrl -r meeting_$(date +%F).pdf -e 0,-82,-60,1117,1210 && sleep 1 && wmctrl -a Terminal && vim /home/aj/Documents/sallies/meeting_$(date +%F).mkd'
alias DemoSalliesMinutes='wmctrl -r :ACTIVE: -N Terminal && cp /home/aj/Documents/sallies/.demo-template.mkd /home/aj/Documents/sallies/demo-meeting_$(date +%F).mkd && sed -i "1 s/Date/$(date +%d | sed s/^0//)$(grep $(date +%d) /home/aj/Documents/sallies/.datecheat | sed s/.*#//)\ $(date +%B)/" /home/aj/Documents/sallies/demo-meeting_$(date +%F).mkd && pandoc --smart --template=/home/aj/.vim/pandoc-templates/ajpdf --latex-engine=xelatex /home/aj/Documents/sallies/demo-meeting_$(date +%F).mkd -o /home/aj/Documents/sallies/demo-meeting_$(date +%F).pdf && evince /home/aj/Documents/sallies/demo-meeting_$(date +%F).pdf 2>/dev/null & sleep 5 && wmctrl -r demo-meeting_$(date +%F).pdf -e 0,-82,-60,1117,1210 && sleep 1 && wmctrl -a Terminal && vim /home/aj/Documents/sallies/demo-meeting_$(date +%F).mkd'
alias RemindMeTo="echo $1 >> $HOME/notepad"
alias Pandoc="pandoc --smart --template=$HOME/.vim/pandoc-templates/ajpdf --latex-engine=xelatex inputfile.mkd -o outputfile.pdf"
function Password() { openssl rand -base64 "$1"|sed ':a;N;$!ba;s/\n//g'|sed s/=//g|cut -c 1-"$1"; }

