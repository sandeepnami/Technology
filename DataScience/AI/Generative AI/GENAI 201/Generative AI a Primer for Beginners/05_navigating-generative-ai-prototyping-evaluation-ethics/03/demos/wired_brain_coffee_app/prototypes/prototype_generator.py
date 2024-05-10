import openai

class PrototypeGenerator:
    def __init__(self, gpt_api_key):
        self.gpt_api_key = gpt_api_key
    
    def generate_prototype_coffee_cup_design(self):
        prompt = "Generate a description of a prototype coffee cup design with color, shape, and size.\n"

        openai.api_key = self.gpt_api_key
        response = openai.Completion.create(
            engine = "text-davinci-002",
            prompt=prompt,
            max_tokens=150
        )

        print(response)
        generated_description = response['choices'][0]['text']
        return generated_description