# Ethan Thummel | Amir Bahmandar | Fabiola Sore 4/21/23

# so vivado wants a txt file for the input for initializing the ram
# customasm can produce a long string of txt without line breaks
# so this just converts the format

# Open the input and output files
with open('binstr.txt', 'r') as input_file, open('output.txt', 'w') as output_file:
    # Read the input string and split the numbers into a list
    numbers = input_file.read().strip()
    # Calculate the number of rows needed
    num_rows = (len(numbers) + 7) // 16
    # Write the rows to the output file
    for i in range(num_rows):
        row = numbers[i*16:(i+1)*16]
        output_file.write(row.ljust(16) + '\n')