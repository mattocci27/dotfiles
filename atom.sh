while read list
do
  apm install $list
done < .atom/packages.txt
