# Install the transformers library
# pip install transformers
# pip install torch
# !pip install torch -- incase in jupiter notebook
from transformers import BlipProcessor, BlipForConditionalGeneration
from PIL import Image

# Initialize the processor and model from Hugging Face
processor = BlipProcessor.from_pretrained("Salesforce/blip-image-captioning-base")
model = BlipForConditionalGeneration.from_pretrained("Salesforce/blip-image-captioning-base")

# Load an image
image_path = r"C:\Users\namis\OneDrive\Professional\Technology\DataScience\AI\Generative AI\LLM\Building Generative AI-Powered Applications with Python\Module 1\IMGL1693.jpg"
image = Image.open(image_path)

# Prepare the image
inputs = processor(image, return_tensors="pt")

# Generate captions
outputs = model.generate(**inputs)
caption = processor.decode(outputs[0],skip_special_tokens=True)
 
print("Generated Caption:", caption)