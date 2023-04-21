
customasm -f binstr input.s -o binstr.txt
python3 linebreakconverter.py
rm binstr.txt 