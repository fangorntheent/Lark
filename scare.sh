# scare.sh
# Runs a chance at scaring away a random nest (Sends the contents of a random nest.txt file to /dev/null)
read -p "Nest count: " nestCount
for ((i=0; i<$nestCount; i++))
do
  nestIntArray[$i]=$i
  echo $nestIntArray[$i]
done
num=$((1 + RANDOM % 3)) # Picks a random number between 1 and 3 to see if a nest is scared off
if [ 2 -eq $num ]
then
  randnum=$((1 + RANDOM % $nestCount))
  #nestIntArray[randnum] > /dev/null
  echo "A bird was scared away"
  nestIntArray[$randnum]=nestIntArray[$randum-1]
else
  echo "No birds were scared away!"
fi
