# pip install gradio
# pip install urllib3==1.25.8 incase of errors install this
# Activate Virtual Environment
# python -m venv LLM_venv  -- Create Virtual Environment
# LLM> .\LLM_venv\Scripts\activate   -- Activate Virtual Environment
# Make sure you do not name your test file as gradio.py
# http://localhost:7860/
# To come out of execution press Ctrl+C

import gradio as gr
def greet(name, intensity):
  return "Hello, " + name + "!" * int(intensity)
demo = gr.Interface(
  fn=greet,
  inputs=["text", "slider"],
  outputs=["text"],
)
demo.launch()