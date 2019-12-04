#!/bin/bash
# Lark.sh

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
CYAN=$(tput setaf 6)
#NC=$(tput setaf 7)
NC=$(tput sgr0)
BLINK=$(tput blink)

function printWin() {
	echo "Oh, $name"
	echo "I'm so happy you survived! Over these past two weeks I've been so impressed by your una${CYAN}bash${NC}ed curiosity and bravery."
	echo "You have proven yourself to be a fair and fearless feline who is worthy of my love."
	echo "As such, you are now allowed in and out of the house whenever you want. Also, you can come and stop by for a crumpet and tea whenever you’re hungry or thirsty."
	echo "See you soon!"
}

function printLose() {
	echo "Oh no, another cat gone, what a tragedy! Your una${CYAN}bash${NC}ed curiosity and stupidity didn’t seem to help you too much in your survival."
	echo "Well, maybe in your next life you’ll live past the two-week mark. Cats have 9 lives after all, right?"
	echo "Now, where can I put this disgusting, lifeless thing?"
}

clear

function save() {
	echo "$nestCount" > $save
	echo "$birdCount" >> $save
	echo "$dayCount" >> $save
	echo "$chance" >> $save
	echo "$catLoc" >> $save
	echo "$userName" >> $save
	echo "${nestIntArray[*]}" >> $save
	echo "${nestArray[*]}" >> $save
	echo "$eggCount" >> $save
	echo "$cat9BirdCount" >> $save
	echo "$hardMode" >> $save
	echo "$missionTask" >> $save
	echo "$birdCollected" >> $save
	echo "$previousBirdCount" >> $save
}

function getSave() {
	nestCount=$( sed -n '1'p $save )
	birdCount=$( sed -n '2'p $save )
	dayCount=$( sed -n '3'p $save )
	chance=$( sed -n '4'p $save )
	catLoc=$( sed -n '5'p $save )
	userName=$( sed -n '6'p $save )
	nestIntArray=$( sed -n '7'p $save )
	nestArray=$( sed -n '8'p $save )
	eggCount=$( sed -n '9'p $save )
	cat9BirdCount=$( sed -n '10'p $save )
	hardMode=$( sed -n '11'p $save )
	missionTask=$( sed -n '12'p $save )
	birdCollected=$( sed -n '13'p $save )
	previousBirdCount=$( sed -n '14'p $save )
}

function attack() {
	clear
	echo -e "${BLINK}stalking...${NORMAL}"
	sleep 2
	clear
	echo -e "${BLINK}pouncing...${NORMAL}"
	sleep 2
	clear
}

function commandCase() {
	echo
	echo "Enter a command in the format COMMAND [FLAG] PARAMETER (s to skip):"
	read -p "$PWD > " inputCom ComArg1 ComArg2
	case "$inputCom" in
		"cd")
    		if [ -d $ComArg1 ]; then
    			echo "Climbing to $ComArg1..."
	    		cd $ComArg1
    		else 
    			echo "$ComArg1 is not a directory.."
    			echo
	    		scareSpecific
    		fi
    		commandCase
    	;;
    	"ls")
    	    if [ "$ComArg1" == "-a" ] || [ "$ComArg1" == "-la" ] || [ "$ComArg1" == "-al" ] || [ -d $ComArg1 ] || [ -f $ComArg1 ]; then
	    		if [ -d $ComArg2 ] || [ -f $ComArg2 ] || [ -z $ComArg2 ];then
    				ls $ComArg1 $ComArg2
    			else
    				echo "$ComArg2 is not a file or directory..."
	    			echo
    				scareSpecific
    			fi
	   		else 
    			echo "$ComArg1 is not a valid argument..."
	    		echo
		    	scareSpecific
    		fi
    		commandCase
	    ;;
    	"cat")
			pathVar1=$( echo "$ComArg1" | awk -F'/' '{print $1}' )
			pathVar2=$( echo "$ComArg1" | awk -F'/' '{print $2}' )
			pathVar3=$( echo "$ComArg1" | awk -F'/' '{print $3}' )
			pathVar4=$( echo "$ComArg1" | awk -F'/' '{print $4}' )
			if [ -f $ComArg1 ] && [ ! -z $ComArg1 ]; then
				cat $ComArg1
				echo
        		birdTestVar=$( cat $ComArg1 )
				if [ $birdTestVar == "BIRD!" ]; then
          			echo "You caught this bird!" > $ComArg1
          			(( birdCount = $birdCount + 1 ))
          			echo $ComArg1
          			local catBalls=$( getLoc $ComArg1 )
                	for ((i = 1 ; i <= $nestCount ; i++)); do
                  		if [ "$catLoc" == "${nestIntArray[$i]}" ]; then
                    		nestIntArray[$i]=$(( nestIntArray[$1] - 1 ))
                    		echo "yes"
                		fi
              		done
					return
				else
					echo "You caught this $birdTestVar!" > $ComArg1
					return
        		fi
			elif [ -z $ComArg1 ]; then
				echo "No argument passed to cat..."
				echo
				scareSpecific
			elif [ ! -z $ComArg1 ]; then
				if [ -f "$pathVar1/$pathVar2/$pathVar3/$pathVar4" ] && [ ! -z $pathVar4 ]; then
            		echo "test1"
					echo
					scareSpecific $ComArg1
				elif [ -f "$pathVar1/$pathVar2/$pathVar3" ] || [ -d "$pathVar1/$pathVar2/$pathVar3" ] && [ ! -z $pathVar3 ]; then
            		echo "test2"
					echo
					scareSpecific $ComArg1
          		elif [ -f "$pathVar1/$pathVar2" ] || [ -d "$pathVar1/$pathVar2" ] && [ ! -z $pathVar2 ]; then
            		echo "test3"
					echo
					scareSpecific $ComArg1
				elif [ -f $pathVar1 ] || [ -d $pathVar1 ] && [ ! -z $pathVar1 ]; then
            		echo "test4"
					echo
					scareSpecific $ComArg1
         		else
         			echo "$ComArg1 is not a viable pathname or file..."
					echo
					scareSpecific
				fi
			else 
				echo "$ComArg1 is not a file..."
				echo
				scareSpecific
			fi
			commandCase
		;;
		"chmod")
			if [ "$ComArg1" == "+rwx" ] || [ "$ComArg1" == "+wrx" ] || [ "$ComArg1" == "+xrw" ] || [ "$ComArg1" == "+rxw" ] || [ "$ComArg1" == "+xwr" ] || [ "$ComArg1" == "+wxr" ] || [ "$ComArg1" == "+x" ] || [ "$ComArg1" == "+w" ] || [ "$ComArg1" == "+r" ] || [ "$ComArg1" == "+rw" ]  || [ "$ComArg1" == "+wr" ] || [ "$ComArg1" == "+xw" ] || [ "$ComArg1" == "+wx" ]  || [ "$ComArg1" == "+rx" ]  || [ "$ComArg1" == "+xr" ]; then
				if [ -d $ComArg2 ] || [ -f $ComArg2 ]; then
					chmod $ComArg1 $ComArg2
				fi
			else
				echo "$ComArg1 and/or $ComArg2 are not valid arguments..."
				echo
				scareSpecific
			fi
			commandCase
		;;
		s|S|"Skip")
		;;
		q|Q)
			exit
		;;
		*)
			echo "$inputCom is not a valid command..."
			echo
			scareSpecific
			commandCase
		;;
	esac
}

function getLoc() {
	local currentDir="$1"
	local sizeMax="${#currentDir}"
	if [ "$currentDir" == "$PWD" ]; then
		local sizeMin="$(expr ${#currentDir} - 28)"
	else
		local sizeMin="$(expr ${#currentDir} - 26)"
	fi
	currentDir="${currentDir:$sizeMin:$sizeMax}"
	currentDir=($(echo $currentDir | tr -d -c 0-9))
	if [ "${#currentDir}" == 0 ]; then
		currentDir="0001"
	elif [ "${#currentDir}" == 1 ]; then
		(( currentDir=$currentDir * 1000 + 1 ))
	elif [ "${#currentDir}" == 2 ]; then
		(( currentDir=$currentDir * 100 + 1 ))
	elif [ "${#currentDir}" == 3 ]; then
		(( currentDir=$currentDir * 10 + 1 ))
	fi
	echo "$currentDir"
}

function goToCatLoc() {
	TreeIntDef="${catLoc:0:1}"
	BrnchAIntDef="${catLoc:1:1}"
	BrnchBIntDef="${catLoc:2:1}"
	BrnchIntBDef="${catLoc:3:1}"
	if [ "$TreeIntDef" == 0 ]; then
		cd "$PWD/garden"
	elif [ "$BrnchAIntDef" ==  0]; then
		cd "$PWD/garden/tree$TreeIntDef"
	elif [ "$BrnchBIntDef" == 0 ]; then
		cd "$PWD/garden/tree$TreeIntDef/branch$BrnchAIntDef"
	else
		cd "$PWD/garden/tree$TreeIntDef/branch$BrnchAIntDef/branch$BrnchBIntDef"
	fi
}

function scareRandom() {
	if [ "$nestCount" == 0 ]; then
		break
	fi
	num=$((1 + RANDOM % 3)) # Picks a random number between 1 and 3 to see if a nest is scared off
	if [ 2 -eq $num ]; then
		randnum=$((1 + RANDOM % $nestCount))
		echo "It looks like you scared the bird away" > "${nestArray[$randnum]}"
		echo "A bird was scared away"
		nestIntArray[$randnum]=$((nestIntArray[$randnum] - 1))
	else
		echo "No birds were scared away!"
	fi
}

function scareSpecific() {
	if [ -z "$1" ]; then
		local tempVal=$( getLoc $PWD )
	else
		local tempVal=$( getLoc $1 )
	fi
	local TreeIntDef="${tempVal:0:1}"
	local BrnchAIntDef="${tempVal:1:1}"
	local BrnchBIntDef="${tempVal:2:1}"
	local BirdIntDef="${tempVal:3:1}"
	local flag=0

	for ((i = 1; i < $nestCount; i++)); do
		tempValDef=${nestIntArray[$i]}
		TreeInt="${nestIntArray[$i]:0:1}"
		BrnchAInt="${nestIntArray[$i]:1:1}"
		BrnchBInt="${nestIntArray[$i]:2:1}"
		BirdInt="${nestIntArray[$i]:3:1}"

		if [ "$tempVal" -ne $tempValDef ] && [ "$BirdInt" -ne 0 ]; then
	    	if [ $TreeIntDef -eq $TreeInt ]; then
    			if [ $BrnchAIntDef -eq $BrnchAInt ]; then
    				if [ $BirdIntDef -ne 0 ]; then
	    		    	nestIntArray[$i]=$((nestIntArray[$i] - 1))
    		    		flag=1
    		    		echo "It looks like you scared the bird away" > ${nestArray[$i]}
	    	    	fi
		    	elif [ $BrnchBIntDef -eq $BrnchBInt -a $BrnchBIntDef -ne 0 -a $BrnchAIntDef -eq 0 ]; then
    				if [ $BirdIntDef -ne 0 ]; then
    					nestIntArray[$i]=$((nestIntArray[$i] - 1))
    					flag=1
    					echo "It looks like you scared the bird away" > ${nestArray[$i]}
		    		fi
    			elif [ $BrnchAIntDef -eq $BrnchAInt -a $BrnchBIntDef -eq 0 ]; then
    				nestIntArray[$i]=$((nestIntArray[$i] - 1))
    				flag=1
	    			echo "It looks like you scared the bird away" > ${nestArray[$i]}
	    		elif [ $BrnchAIntDef -eq 0 ]; then
    				nestIntArray[$i]=$((nestIntArray[$i] - 1))
    				flag=1
	    			echo "It looks like you scared the bird away" > ${nestArray[$i]}
	    		fi
    		fi
		fi
	done
	if [ $flag -eq 1 ]; then
 		echo "Oh no! At least one bird flew away!"
	fi
}

function cont() {
	echo
	read -p "Press enter to continue..."
}

function maximus() {
	local option
	if [ "$dayCount" == 1 ] || [ "$chance" -lt 3 ]; then
		chance=$((1 + RANDOM % 2))
	fi
	local answer
	local bribe
	echo
	echo "What do you want, peasant?"
	select option in Talk Help Bribe Leave Quit; do
        	case "$option" in
        	"Talk")
				echo "Why should I waste my time on meaningless chatter with you?"
				break 2
			;;
			"Help")
				echo "So you want my help do you?"
				echo "Fine, I'll tell you about the other cats."
				read -p "What cat do you want to know about? (2-9), l to leave, q to quit): " answer
				echo
				case "$answer" in
					2) 
						if [ "$chance" == 1 ]; then
							echo "This cat acts like a general and orders all the other cats around."
							echo "He doesn't like the new cats like you who have no skill."
							# Insert echo statement saying what this cat does to help
						else
							echo "This cat acts like a general but is a total wuss on the inside."
							echo "You could probably go over there and take any birds you get from him if you threatened him."
						fi
						break 2
					;;
					3)
						if [ "$chance" == 1 ]; then
							echo "This cat is a neat freak and is always going on about the correct way to eat the birds."
							echo "As long as your being neat, he'll like you. So stay neat."
							# Insert echo statement saying what this cat does to help
						else
							echo "This cat is a slob who doesn't care how big a mess he makes as long as he gets his food."
							echo "If he sees you eating and you're taking your time, he will take your dinner."
						fi
						break 2
					;;
					4)
						if [ "$chance" == 1 ]; then
							echo "This cat is a lot like you. Take that as you will."
							echo "She's probably the only cat who would willingly get along with someone like you."
							# Insert echo statement saying what this cat does to help
						else
							echo "This cat only thinks about herself and nobody else."
							echo "If you see her, just ignore her and walk away."
						fi
						break 2
					;;
					5)
						if [ "$chance" == 1 ]; then
							echo "This cat is one you should avoid at all cost."
							echo "They will try and do whatever they can to get other cats birds."
							# Insert echo statement saying what this cat does to help
						else
							echo "This cat is just about the nicest cat you'll ever meet."
							echo "She's a good hunter so she's willing to help out new cats like yourself."
						fi
						break 2
					;;
					6)
						if [ "$chance" == 1 ]; then
							echo "This cat likes birds. A lot."
							echo "He'll collect other cats birds and hold on to them as reserves for himself."
							# Insert echo statement saying what this cat does to help
						else
							echo "This cat isn't that big a fan of birds."
							echo "Chances are, you can persuade him to give you his birds."
						fi
						break 2
					;;
					7)
						if [ "$chance" == 1 ]; then
							echo "This cat is mad all the time."
							echo "It's probably best to ignore him or else you'll get yelled at."
							# Insert echo statement saying what this cat does to help
						else
							echo "This cat is pretty normal aside from being a bit quite."
							echo "You could probably ask him for help if you wanted."
						fi
						break 2
					;;
					8)
						if [ "$chance" == 1 ]; then
							echo "This cat loves hunting for birds. It's all he does."
							echo "The one thing to watch out for is that he's super clumsy."
							echo "If you asked, he would probably go and find some birds for you."
						else
							echo "This cat doesn't like going out to get birds."
							echo "They just want to stay inside and be pampered like I am."
						fi
						break 2
					;;
					9)
						if [ "$chance" == 1 ]; then
							echo "If you ever see her, you won't be able to talk to her."
							echo "She's super shy and is scared of the birds."
							echo "Since she doesn't get any birds I don't know how much longer she has. Not that I care."
						else
							echo "This cat hates everything and everyone."
							echo "Best just to avoid her least you want to have scars."
						fi
						break 2
					;;
					l|L)
						echo "Stop wasting my precious time, flea."
						break 2
					;;
					q|Q)
						exit
					;;
					*)
						echo "Don't test me runt."
						echo
					;;
					esac
			;;
			"Bribe")
				echo "Oh. What is it you have there? A bird?"
				read -p "If your're willing, I can take it off your hands. (y/n) " bribe
				case "$bribe" in
					y|Y)
						echo "Why thank you, 10."
						if [ $birdCount -gt 0 ]; then
							(( birdCount = $birdCount - 1 ))
							chance=1
						else
							chance=3
						fi
						break 2
					;;
					n|N)
						echo "Well that is a shame."
						break 2
					;;
					"Quit")
						exit
					;;
					*)
						echo "Don't test me, runt."
					;;
				esac
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
				echo "Don't test me, runt."
				echo
			;;
		esac
	done
	cont
}

#Cat 2
# Global variables needed: missionTask birdCollected previousBirdCount
# birdCollected is just a subtraction done at the start of the day: birdCollected="$(($birdCount - $previousBirdCount))"
# previousBirdCount is as follows: previousBirdCount=$birdCount at the start of the part of the game when you go after birds.
function cat2() {
	local randChance
	local option
	local task
	task=2
	echo
	echo "Speak your mind, solider."
	select option in Talk Mission Complete Leave Quit; do
		case "$option" in
			"Talk")
				echo "I am busy organizing 9 different cats and assigning missions for them all."
				echo "Do you really think I have time to be listening to you, solider?"
				break 2
			;;
			"Mission")
				echo "I have a mission for you, solider."
				echo "I need you to gather some of the twigs from the bird nests."
				randChance=$((1 + RANDOM % 10))
				missionTask=$(($nestCount / $randChance))
				echo "You need to get $missionTask twigs to complete the mission."
				echo "Good luck solider."
				task=1
				break 2
			;;
			"Complete")
				if [ "$task" == 1 ]; then
					echo "How can you complete a mission that you haven't even attempted yet magot."
				else
					echo "Have you completeted your mission, solider?"
					if [ "$birdCollected" >= "$missionTask" ]; then
						echo "Well done, solider."
						(( birdCount = $birdCount + 1 ))
						echo "You got one bird."
					else
						echo "You couldn't do it I see. Better luck next time."
						(( missionTask = $missionTask + 126 ))
					fi
					task=2
				fi
				break 2
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function cat3() {
	local option
	local choice
	echo
	echo "Stop! Don't take another step or your going to ruin the perfect grass."
	select option in Talk Question Leave Quit; do
		case "$option" in
			"Talk")
				echo "I only have time to talk from 3:47:16 to 3:50:00."
				echo "Any other time would ruin my perfect schedule."
				break 2
			;;
			"Question")
				echo "What do you want to know?"
				echo "Each cost one bird."
				select choice in cd ls cat chmod; do
					case "$choice" in
						"cd")
							if [ "$birdCount" -ge 1 ]; then
								cat LarkFolder/cd | less
								echo ""
								(( birdCount = $birdCount - 1 ))
							else
								echo "You do know you need a bird for my flawless advice."
							fi
							break 2
						;;
						"ls")
							if [ "$birdCount" -ge 1 ]; then
								cat LarkFolder/ls | less
								echo ""
								(( birdCount = $birdCount - 1 ))
							else
								echo "You do know you need a bird for my flawless advice."
							fi
							break 2
						;;
						"cat")
							if [ "$birdCount" -ge 1 ]; then
								cat LarkFoldercat | less
								echo""
								(( birdCount = $birdCount - 1 ))
							else
								echo "You do know you need a bird for my flawless advice."
							fi
							break 2
						;;
						"chmod")
							if [ "$birdCount" -ge 1 ]; then
								cat LarkFolderchmod | less
								echo ""
								(( birdCount = $birdCount - 1 ))
							else
								echo "You do know you need a bird for my flawless advice."
							fi
							break2
						;;
					esac
				done
				break 2
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function cat4() {
	local option
	local randChance1
	local randChance2
	echo
	echo "How've you been, 10?"
	select option in Talk Assistance Leave Quit; do
		case "$option" in
			"Talk")
				echo "I really don't have much to talk about right now. Sorry."
				break 2
			;;
			"Assistance")
				echo "If you need some help I can give you some."
				randChance1=$((1 + RANDOM % 2))
				if [ $randChance1 == 1 ]; then
					randChance2=$((1 + RANDOM % 20))
					if [ "$randChance2" -le 6 ]; then
						echo "Take this bird I got."
						(( birdCount = $birdCount + 1 ))
					elif [ "$randChance2" -ge 7 ] || [ "$randChance2" -le 12 ]; then
						echo "Take these birds I have."
						(( birdCount = $birdCount + 2 ))
					elif [ "$randChance2" -le 13 ] || [ "$randChance2" -ge 15 ]; then
						echo "Take these birds I have."
						(( birdCount = $birdCount + 3 ))
					elif [ "$randChance2" -le 16 ] || [ "$randChance2" -ge 18 ]; then
						echo "Take these birds I have."
						(( birdCount = $birdCount + 4 ))
					elif [ $randChance2 == 19 ]; then
						echo "Take these birds I have."
						(( birdCount = $birdCount + 5 ))
					fi
					break 2
				else
					echo "I'm sorry but I don't have any birds I can spare today."
					break 2
				fi
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function cat5() {
	local option
	local randChance1
	echo
	echo "'Snickers'"
	select option in Talk Assistance Leave Quit; do
		case "$option" in
			"Talk")
				echo "'Sigh' What do you want?"
				break 2
			;;
			"Help")
				echo "So you want 'my' help do you? Fine, I'll help."
				randChance1=$((1 + RANDOM % 20))
				if [ "$randChance1" -le 4 ]; then
					echo "I know I was supposed to help you, but I'm gonna help myself to some of your birds."
					echo "You don't mind, right."
					(( birdCount = $birdCount / 2 ))
				elif [ "$randChance1" -ge 6 ] || [ "$randChance1" -le 8 ]; then
					echo "Actually I'm busy right now so I'm not gonna do anything."
				elif [ $randChance1 == 9 ] || [ $randChance1 == 10 ]; then
					echo "This isn't going to happen again you know. Here."
					(( birdCount = $birdCount * 1.5 ))
					if [ $($birdCount % 2) -ne 0 ]; then
						(( birdCount = $birdCount + 0.5 ))
					fi
				fi
				break 2
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function cat6() {
	local option
	echo
	echo "So, do you have anything for my collection?"
	select option in Talk Trade Leave Quit; do
		case "$option" in
			"Talk")
				echo "If you aren't going to do business then your a waste of my time."
				break 2
			;;
			"Trade")
				echo "Talking business aye. What have you got?"
				select goods in Bird Egg Cancel Quit; do
					case "$goods" in
						"Bird")
							echo "I already have plenty of birds in my collection."
							echo "No deal."
							break 3
						;;
						"Egg")
							echo "Hold on, don't tell me you found an egg. Those are super rare."
							read -p "Here's my offer: I'll take the egg. In exchange, I'll give you 5 birds? (y/n/barter) " deal
							case "$deal" in
								y|Y)
									echo "Pleasure doing business with you."
									(( eggCount = $eggCount - 1 ))
									(( birdCount = $birdCount + 5 ))
									break 3
								;;
								n|N)
									echo "Not gonna take it, aye. That's fine."
									echo "Just know that I'm always here for business."
									break 3
								;;
								"barter"|"Barter")
									echo "You got guts trying to barter with me but my deal isn't changing."
									break 3
								;;
								"Quit")
									exit
								;;
								*)
									echo "So, we gotta deal or not?"
									echo "Make your mind kid. I ain't got all day."
								;;
							esac
						;;
						"Cancel")
							echo "Wimping out are we."
						;;
						"Quit")
							exit
						;;
						*)
						;;
					esac
				done
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function cat7() {
	local option
	local answer
	local clarification
	echo
	echo "Can't you see I'm busy?"
	select option in Talk Quiz Leave Quit; do
		case "$option" in
			"Talk")
				echo "I thought I said that I'm BUSY RIGHT NOW!"
				break 2
			;;
			"Quiz")
				echo "You really want something to do don't you? Fine then answer my question and leave me alone."
				read -p "What is my favorite thing to do?" answer
				case "$answer" in
					"Paint")
						read -p "WRONG ANS- wait, what did you say?" clarification
						case "$clarification" in
							"Paint")
								echo "Wow. You actually got it. How'd you know?"
								echo "Here. Take this."
								(( eggCount = $eggCount + 1 ))
								break 2
							;;
							"Quit")
								exit
							;;
							*)
								echo "Okay. I was just hearing things."
								echo "Anyway, WRONG ANSWER, STUPID!"
								break 2
							;;
						esac
						break 2
					;;
					"Quit")
						exit
					;;
					*)
						echo "WRONG ANSWER, STUPID!"
						break 2
					;;
				esac	
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function cat8() {
	local option
	echo
	echo "How may I be of assistance, mere apprentice?"
	select option in Talk Help Leave Quit; do
		case "$option" in
			"Talk")
				echo "Come to hear the tales of my glory, have you? Well I'll be happy to share with you."
				echo "It all started 5 years ago, back in my young days as a mere apprentice like you."
				read -p "You feel this story may go on for a while. Do you want to keep listening? (y|n) " choice
				case "$choice" in
					y|Y)
						cat LarkFolder/cat8text | less
						break 2
					;;
					n|N)
						echo "What do you mean you don't have time for my grand saga?"
						break 2
					;;
				esac
			;;
			"Help")
				echo "So, you come seeking the aid of a glorious knight such as myself."
				read -p "Ask for help? (y|n) " assistance
				case "$assistance" in
					y|Y)
						scare=$((1 + RANDOM % 10))
						if [ "$scare" -gt 1 ]; then
							scareRandom
							echo "The birds were smart today. The managed to catch on to my noble plan."
						else
							
							echo "My amazing prowess as a knight has let me locate the birds for you."
							echo "The birds today are located in the following: "
							echo
							echo ${nestArray[*]}
						fi
						break 2
					;;
					n|N)
						echo "So, you want to prove your own mettle, do you. I wish you the best of luck, apprentice."    
						break 2
					;;
				esac
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
		esac
	done
	cont
}

function cat9() {
	local option
	echo
	echo "'Whimper'"
	select option in Talk Give Leave Quit; do
		case "$option" in
			"Talk")
				echo "I-I-I'm s-sorry but I-I can't t-t-talk to o-o-others."
				break 2
			;;
			"Give")
				if [ "$birdCount" -gt 0 ]; then
					echo "You decide to leave a bird next to cat 9."
					echo "As you leave you turn to see her looking your way for a moment."
					(( birdCount = $birdCount - 1 ))
					(( cat9BirdCount = $cat9BirdCount + 1 ))
					if [ "$cat9BirdCount" == 3 ]; then
						echo "W-Wait!"
						echo "H-H-Here, as t-thanks for helping m-me."
						echo "Cat 9 gives you a egg and runs off."
						(( eggCount = $eggCount + 1 ))
						cat9BirdCount=-1000
					fi
				else
					echo -e "You think to yourself, \"Cat 9 has to be starving.\""
				fi
				break 2
			;;
			"Leave")
				break
			;;
			"Quit")
				exit
			;;
			*)
				echo "'Whimper'"
			;;
		esac
	done
	cont
}

function birdbath() {
	clear
	echo "This aquatic garden attraction offers water to drink and the potential to ${GREEN}cat${NC}ch a dumb ${CYAN}bird${NC}."
	select option in drink "wait for a bird" leave Quit; do
		case "$option" in
			"drink")
				echo "You take a sip of the stagnant water and think you just got a new parasite."
				break 2
			;;
			"wait for a bird")
				read -p ": " command location
				attack
				case "$command" in
					"cat")
						if [ "$location" == "birdbath" ] || [ "$location" == "bird" ]; then
							if [ 1 == $((1 + RANDOM % 5)) ]; then									
								(( birdCount = $birdCount + 1 ))
								echo "You got a bird!"
							else
								echo "You missed and the bird flew away."
							fi
						else
							echo "You knocked over the bird bath and scared away the bird!"
							echo "The ruckus may have scared some birds from the trees."
							clear
							echo -e "${BLINK}waiting...${NORMAL}"
							sleep 2
							scareRandom
						fi
						break 2
					;;
					q|Q)
						exit
					;;
					*)
						echo "You knocked over the bird bath and scared away the bird!"
						echo "The ruckus may have scared some birds from the trees."
						clear
						echo -e "${BLINK}waiting...${NORMAL}"
						sleep 2
						scareRandom
						break 2
					;;
				esac
			;;
			"leave")
				echo "No birds today. You leave disappointed."
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	cont
}

function makeGarden() {
	local difficulty=1
	local nestDifficulty=12
	local permArray=("" r w x rw rx wr wx xr xw rwx rxw wrx wxr xrw xwr)
	prefix="$PWD/$1"
	save="$prefix/.$1.txt"
	chmod -R +rwx $prefix
	if [ -d "$prefix" ]; then
		read -p "Do you want to overwrite this existing save? (y/n) " overwrite
		case "$overwrite" in
			y|Y)
				rm -r $prefix
				mkdir $prefix
				read -p "Would you like to play on hard mode? (y/n) " hardOn
				case "$hardOn" in
					y|Y)
						hardMode=1
					;;
					n|N)
						hardMode=0
					;;
					k|K|"konami")
						hardMode=2
					;;
					q|Q)
						exit
					;;
					*)
					;;
				esac
			;;
			n|N)
				read -p "Please enter a new save name: " prefix
				if [ "$prefix" == "q" ] || [ "$prefix" == "Q" ]; then
					exit
				elif [ -d $prefix ]; then
					break
				fi
				mkdir $prefix
				save="$prefix/.$prefix.txt"

			;;
			q|Q)
				exit
			;;
			*)
				echo "That is not a valid option"
			;;
		esac
	else
		mkdir $prefix
	fi

	touch $save
	chmod +w $save
	mkdir $prefix/garden

	if [ "$hardMode" == 1 ]; then
		difficulty=5
		nestDifficulty=75
	elif [ "$hardMode" == 2 ]; then
		difficulty=5
		nestDifficulty=1000
	fi

	nestCount=0
	branchCount=0
	trees=$(($difficulty + RANDOM % 5))
	for((t = 1; t <= trees; t++)); do
		mkdir $prefix/garden/tree$t
		branch1=$(($difficulty + RANDOM % 5))
		for((b1 = 1; b1 <= branch1; b1++)); do
			mkdir $prefix/garden/tree$t/branch$b1
			branch2=$(($difficulty + RANDOM % 5))
			for((b2 = 1; b2 <= branch2; b2++)); do
				mkdir $prefix/garden/tree$t/branch$b1/branch$b2
				nest=$((1 + RANDOM % $nestDifficulty))
				(( branchCount = $branchCount + 1 ))
				if [ ! -f nest ] && [ $nest == 1 ]; then
					(( nestCount = $nestCount + 1 ))
					nestArray[$nestCount]="$prefix/garden/tree$t/branch$b1/branch$b2/nest"
					echo "BIRD!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					nestIntArray[$nestCount]=$(( t * 1000 + b1 * 100 + b2 * 10 + 1 ))
				elif [ ! -f nest ] && [ "$hardMode" == 2 ]; then
					if [ $((nest % 2)) == 1 ]; then
						echo "ROCK!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					elif [ $((nest % 3)) == 1 ]; then
						echo "ROSE!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					elif [ $((nest % 4)) == 1 ]; then
						echo "BALL!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					elif [ $((nest % 5)) == 1 ]; then
						echo "LEAF!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					elif [ $((nest % 6)) == 1 ]; then
						echo "GOAT!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					fi
				fi
			done
		done
	done

	if [ "$nestCount" == 0 ]; then
		location=false
		while [ "$location" == "false" ]; do
			trees=$(($difficulty + RANDOM % 5))
			branch1=$(($difficulty + RANDOM % 5))
			branch2=$(($difficulty + RANDOM % 5))
			if [ -d "$prefix/garden/tree$trees/branch$branch1/branch$branch2" ]; then
				(( nestCount = $nestCount + 1 ))
				nestArray[$nestCount]="$prefix/garden/tree$trees/branch$branch1/branch$branch2/nest"
				echo "BIRD!" > $prefix/garden/tree$trees/branch$branch1/branch$branch2/nest
				nestIntArray[$nestCount]=$(( t * 1000 + b1 * 100 + b2 * 10 + 1 ))
				location=true
			fi
		done
	fi

	for i in "${nestIntArray[@]}"; do
		local TreeIntDef="${i:0:1}"
		local BrnchAIntDef="${i:1:1}"
		local BrnchBIntDef="${i:2:1}"
		chmod "=${permArray[$((1 + RANDOM % 15))]}" $prefix/garden/tree$TreeIntDef/branch$BrnchAIntDef/branch$BrnchBIntDef 2>/dev/null 
		chmod "=${permArray[$((1 + RANDOM % 15))]}" $prefix/garden/tree$TreeIntDef/branch$BrnchAIntDef 2>/dev/null 
		chmod "=${permArray[$((1 + RANDOM % 15))]}" $prefix/garden/tree$TreeIntDef 2>/dev/null 
	done
}

#user start
select option in play readme Quit; do
	case $option in
		"play")
			nestCount=0
			birdCount=0
			dayCount=1
			chance=$((1 + RANDOM % 2))
			catLoc=0001
			eggCount=0
			cat9BirdCount=0
			hardMode=0
			missionTask=0
			birdCollected=0
			previousBirdCount=$birdCount
			break
		;;
		"readme")
			cat LarkFolder/readme | less
		;;
		"Quit")
			exit
		;;
		*)
		;;
	esac
done

hasFolder=false
command=""
clear
while [ "$hasFolder" == "false" ]; do
	read -p "Do you have a save folder already? (y/n) " folderName
	case "$folderName" in
		y|Y)
			read -p "What's your save folder called? " folderName
			if [ -d  "$PWD/$folderName" ]; then
				echo "Alright, let's get started."
				hasFolder=true
				save="$PWD/$folderName/.$folderName.txt"
				getSave
				cont
			else
				echo "Uh oh. It looks like that directory doesn't exist yet."
				cont
			fi
		;;
		n|N)
			echo -e "Let's fix that. Why don't you ${GREEN}m${NC}a${GREEN}k${NC}e a new ${GREEN}dir${NC}ectory."
			read -p "${GREEN}mkdir${NORMAL} " folderName
			if [ "$folderName" == "q" ] || [ "$folderName" == "Q" ]; then
				exit
			fi
			makeGarden "$folderName"
			hasFolder=true
			read -p "What is your name? " userName
			save
			cat LarkFolder/gertrude | less
			cont
		;;
		q|Q)
			exit
		;;
		*)
		;;
	esac
done

cd $prefix/garden

for ((dayCount ; dayCount < 15 ; dayCount++)); do
	birdCollected=$(($birdCount - $previousBirdCount))
	if [ $dayCount == 1 ]; then
		clear
		read -p "I see this is your first day, would you like to go through the tutorial? (y/n) " tutorial
		case "$tutorial" in
			y|Y)
				clear
				echo "Every day you can choose a cat to talk to and ask them to ${GREEN}l${NC}i${GREEN}s${NC}t their services."
				echo "If a ${GREEN}cat${NC} finds a nest, they should pounce by narrating their actions."
				echo "If you're having trouble getting onto a certain branch, try ${GREEN}ch${NC}anging the permission ${GREEN}mod${NC}e."
				echo "You can give yourself ${GREEN}+r${NC}ead, ${GREEN}+w${NC}rite, and e${GREEN}+x${NC}ecute permissions."
				echo "Make sure you specify what you want permissions for."
				echo "If another cat tells you there's a nest on a certain branch, try checking to see if it's ${GREEN}-a${NC} hidden nest."
				echo "You can also check ${GREEN}-al${NC}l of a locations properties."
				echo "You can also try going to the birdbath to drink water or wait for a bird to stop for a bath."
				echo
				cont
			;;
			n|N)
			;;
			q|Q)
				exit
			;;
			*)
			;;
		esac
	fi
	clear
	if [ $eggCount -gt 0 ]; then
		echo "${BOLD}Day: $dayCount     | Birds: $birdCount     | Eggs: $eggCount${NORMAL}"
	else
		echo "${BOLD}Day: $dayCount     | Birds: $birdCount${NORMAL}"
	fi
	select option in Maximus Cat2 Cat3 Cat4 Cat5 Cat6 Cat7 Cat8 Cat9 Birdbath Skip Quit; do
		case "$option" in
			"Maximus")
				maximus
			;;
			"Cat2")
				cat2
			;;
			"Cat3")
				cat3
			;;
			"Cat4")
				cat4
			;;
			"Cat5")
				cat5
			;;
			"Cat6")
				cat6
			;;
			"Cat7")
				cat7
			;;
			"Cat8")
				cat8
			;;
			"Cat9")
				cat9
			;;
			"Birdbath")
				birdbath
			;;
			"Skip")
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
	commandCase
	cont
	save
done

clear
if [ "$birdCount" == 0 ]; then
	cat LarkFolder/deadcat | less
	printLose
else
	cat LarkFolder/happycat | less
	printWin
fi
echo "You finished the game with $birdCount bird(s)."

exit

