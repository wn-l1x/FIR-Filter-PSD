import matplotlib.pyplot as plt

# Function to read values from file
def read_values(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()
        values = [float(value) / 256.0 for value in lines[0].strip().split()[1:]]  # Skip the label
    return values

# File paths
delay_in_file_path = "D:\\Wendy\\PSD\\delay_in_values.txt"
adder_out_file_path = "D:\\Wendy\\PSD\\adder_out_values.txt"

# Read values from files
delay_in_values = read_values(delay_in_file_path)
adder_out_values = read_values(adder_out_file_path)

# Plotting
plt.plot(delay_in_values, label='Input Signal')
plt.plot(adder_out_values, label='Output Signal')
plt.title('Input Signal vs Output Signal')
plt.xlabel('Frequency')
plt.ylabel('Amplitude')
plt.legend()
plt.show()