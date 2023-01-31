#! /bin/bash
case "$1" in 
    add) shift
         if [[ "$1" = "-t" ]] || [[ "$1" = "--title" ]]
         then
             shift
             if [ -z "$1" ]
             then
                echo "Option -t|--title Needs a Parameter"
             else
                title=$1
                shift
                if [ -z "$1" ]
                then
                    echo "0,L,\"$title\"" >> tasks.csv
                elif [[ "$1" = "-p" ]] || [[ "$1" = "--priority" ]]
                then
                    shift 
                    if [[ "$1" = "H" ]] || [[ "$1" = "M" ]] || [[ "$1" = "L" ]]
                    then 
                        echo "0,$1,\"$title\"" >> tasks.csv
                    else 
                        echo "Option -p|--priority Only Accept L|M|H"
                    fi
                fi
             fi
         else
             echo "Option -t|--title Needs a Parameter"
         fi ;;
    
    clear) echo -n > tasks.csv ;;
    
    list) awk 'BEGIN {FS=","; OFS=" | "} {print NR,$1,$2,$3}' tasks.csv ;;
              
    find) shift 
          awk 'BEGIN {FS=","; OFS=" | "} {print NR,$1,$2,$3}' tasks.csv | grep $1 ;;
          
    done) shift
         awk "NR==$1 { sub(/0/, "1") } { print }" tasks.csv > done.txt
	     cat done.txt > tasks.csv
	     cat tasks.csv
	     rm done.txt ;; 
	     
    *) echo "Command Not Supported!" ;;
esac
