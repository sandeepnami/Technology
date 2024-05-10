def process_data(data):
    # This is where you would put your data processing logic
    print(f"Processing: {data}")

data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]  # This could be any large list of data
batch_size = 3  # This is the size of each batch

# Split the data into batches and process each batch
for i in range(0, len(data), batch_size):
    batch = data[i:i+batch_size]
    process_data(batch)