#!/bin/bash
# Lark.sh

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2)
#NC=$(tput setaf 7)
NC=$(tput sgr0)
BLINK=$(tput blink)

clear

function attack() {
	clear
	echo -e "${BLINK}stalking...${NORMAL}"
	sleep 2
	clear
	echo -e "${BLINK}pouncing...${NORMAL}"
	sleep 2
	clear
}

function scareRandom() {
	if [ "$nestCount" == 0 ]; then
		break
	fi
	num=$((1 + RANDOM % 3)) # Picks a random number between 1 and 3 to see if a nest is scared off
	if [ 2 -eq $num ]; then
		randnum=$((1 + RANDOM % $nestCount))
		echo "${nestArray[$randnum]}"
		echo "It looks like you scared the bird away" > ${nestArray[$randnum]}
		echo "A bird was scared away"
		nestIntArray[$randnum]=$((nestIntArray[$randnum] - 1))
	else
		echo "No birds were scared away!"
	fi
}

function cont() {
	echo
	read -p "Press enter to continue..."
}

function makeGarden() {
	prefix="$PWD/$1"
	save=$prefix/$1
	if [ -d "$prefix" ]; then
		read -p "Do you want to overwrite this existing save? (y/n) " overwrite
		case "$overwrite" in
			y|Y)
				rm -r $prefix
				mkdir $prefix
			;;
			n|N)
				read -p "Please enter a new save name: " prefix
				if [ "$prefix" == "q" ] || [ "$prefix" == "Q" ]; then
					exit
				elif [ -d $prefix ]; then
					break
				fi
				mkdir $prefix
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
	echo "birdCount $birdCount" > $save

	mkdir $prefix/garden

	trees=$((1 + RANDOM % 5))
	nestCount=0
	branchCount=0
	#Trees
	for((t = 1; t <= trees; t++)); do
		mkdir $prefix/garden/tree$t
		branch1=$((1 + RANDOM % 5))
		for((b1 = 1; b1 <= branch1; b1++)); do
			mkdir $prefix/garden/tree$t/branch$b1
			branch2=$((1 + RANDOM % 5))
			for((b2 = 1; b2 <= branch2; b2++)); do
				mkdir $prefix/garden/tree$t/branch$b1/branch$b2
				nest=$((1 + RANDOM % 10))
				(( branchCount = $branchCount + 1 ))
				if [ ! -f nest ] && [ $nest == 1 ]; then
					(( nestCount = $nestCount + 1 ))
					nestArray[$nestCount]="$prefix/garden/tree$t/branch$b1/branch$b2/nest"
					touch $prefix/garden/tree$t/branch$b1/branch$b2/nest
					echo "BIRD!" > $prefix/garden/tree$t/branch$b1/branch$b2/nest
					nestArray[$nestCount]="$prefix/garden/tree$t/branch$b1/branch$b2/nest"
					nestIntArray[$nestCount]=$(( t * 1000 + b1 * 100 + b2 * 10 + 1 ))
				fi
			done
		done
	done
}
brk=false

function birdbath() {
	clear
	echo "This aquatic garden attraction offers water to drink and the potential to ${GREEN}cat${NC}ch a dumb bird."
	select option in drink "wait for a bird" leave Quit; do
		case "$option" in
			"drink")
				echo "You take a sip of the stagnant water and think you just got a new parasite."
				break
			;;
			"wait for a bird")
				read -p ": " command location
				attack
				case "$command" in
					"cat")
						if [ "$location" == "birdbath" ] || [ "$location == bird" ]; then
							if [ 1 == $((1 + RANDOM % 10)) ]; then									
								(( birdCount = $birdCount + 1 ))
								echo "You got a bird!"
							else
								echo "You missed and the bird flew away."
							fi
						else
							echo "You knocked over the bird bath and scared away the bird!"
						fi
						break
					;;
					q|Q)
						exit
					;;
					*)
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

#user start
select option in play readme Quit; do
	case $option in
		"play")
			birdCount=0
			break
		;;
		"readme")
			cat readme
		;;
		"Quit")
			exit
		;;
		*)
		;;
	esac
done

clear
read -p "What is your name? " userName
cat gertrude | less

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
			cont
		;;
		q|Q)
			exit
		;;
		*)
		;;
	esac
done

for ((i = 1 ; i < 15 ; i++)); do
	if [ $i == 1 ]; then
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
	echo "${BOLD}Day $i${NORMAL}"
	select option in Maximus Cat2 Cat3 Cat4 Cat5 Cat6 Cat7 Cat8 Cat9 Birdbath Quit; do
		case "$option" in
			"Maximus")
				break
			;;
			"Cat2")
				break
			;;
			"Cat3")
				break
			;;
			"Cat4")
				break
			;;
			"Cat5")
				break
			;;
			"Cat6")
				break
			;;
			"Cat7")
				break
			;;
			"Cat8")
				break
			;;
			"Cat9")
				break
			;;
			"Birdbath")
				birdbath
				break
			;;
			"Quit")
				exit
			;;
			*)
			;;
		esac
	done
done

echo "You finished the game with $birdCount bird(s)."

