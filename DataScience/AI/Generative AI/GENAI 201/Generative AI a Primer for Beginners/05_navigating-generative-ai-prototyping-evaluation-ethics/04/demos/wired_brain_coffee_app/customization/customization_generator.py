import openai

class CustomizationGenerator:
    def __init__(self, gpt_api_key):
        self.gpt_api_key = gpt_api_key

    def customize_coffee_cup_design(self, customer_preferences, prototype_description):
        prompt = f"Generate a description of a customized coffee cup design based on the following customer preferences:\n"
        for attribute, value in customer_preferences.items():
            prompt += f"{attribute}: {value}\n"
        prompt += f"\nPrototype description:\n{prototype_description}\n"

        openai.api_key = self.gpt_api_key

        response = openai.Completion.create(
            engine="text-davinci-002",
            prompt=prompt,
            max_tokens=150
        )

        generated_description = response['choices'][0]['text']
        return generated_description