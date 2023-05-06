n1 = input.s
customasm -f binstr $1 -o binstr.txt
python3 linebreakconverter.py
rm binstr.txt 