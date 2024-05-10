from prototypes.prototype_generator import PrototypeGenerator
from prototypes.prototype_evaluation import PrototypeEvaluation
from customization.customization_generator import CustomizationGenerator
from customization.customization_evaluation import CustomizationEvaluation
from ethics.ethical_issues import EthicalIssues
from ethics.ethical_evaluation import EthicalEvaluation

def main():
    gpt_api_key = "<<< YOUR OPENAI API KEY GOES HERE >>>"

    prototype_gen = PrototypeGenerator(gpt_api_key)
    generated_prototype_description = prototype_gen.generate_prototype_coffee_cup_design()
    print("Prototype Description:")
    print(generated_prototype_description)

    prototype_eval = PrototypeEvaluation()
    prototype_evaluation_score = prototype_eval.evaluate_prototype(generated_prototype_description)
    print(f"Prototype Evaluation Score: {prototype_evaluation_score}")

    customer_preferences = {
        "color": "blue",
        "shape": "round",
        "size": "medium"
    }

    customization_gen = CustomizationGenerator(gpt_api_key)
    generated_customized_description = customization_gen.customize_coffee_cup_design(customer_preferences, generated_prototype_description)
    print("\nCustomized Description:")
    print(generated_customized_description)

    customization_eval = CustomizationEvaluation()
    customization_evaluation_score = customization_eval.evaluate_customized_design(generated_customized_description)
    print(f"Customization Evaluation Score: {customization_evaluation_score}")

    ethical_issues_checker = EthicalIssues()
    ethical_issues = ethical_issues_checker.check_ethical_issues(generated_customized_description)
    print("\nEthical Issues")
    print(ethical_issues)

    ethical_eval = EthicalEvaluation()
    ethical_implication_level = ethical_eval.evaluate_ethical_implications(ethical_issues)
    print(f"Ethical Implication Level: {ethical_implication_level}")

if __name__ == "__main__":
    main()