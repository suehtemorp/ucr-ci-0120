import numpy as np
import matplotlib.pyplot as plt

# Load the binary data file
file_path = 'result_bytes.bin'
with open(file_path, 'rb') as file:
    data = file.read()

# Convert binary data to numpy array
data_array = np.frombuffer(data, dtype=np.uint8)

# Determine the size of the 30x30 image
image_size = 30 * 30

# Ensure we have enough data for a 30x30 image
if len(data_array) >= image_size:
    # Extract the first 30x30 values
    image_data = data_array[:image_size]
    # Reshape to 30x30 image
    image_30x30 = image_data.reshape((30, 30))
else:
    raise ValueError("Not enough data to form a 30x30 image.")

# Display the image
plt.imshow(image_30x30, cmap='gray')
plt.title("30x30 Image")
plt.axis('off')
plt.show()
