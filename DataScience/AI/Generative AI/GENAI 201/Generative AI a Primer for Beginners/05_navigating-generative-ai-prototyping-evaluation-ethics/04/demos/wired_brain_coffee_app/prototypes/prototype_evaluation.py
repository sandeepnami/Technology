class PrototypeEvaluation:
    def evaluate_prototype(self, generated_description):
        evaluation_score = self.calculate_evaluation_score(generated_description)
        return evaluation_score

    def calculate_evaluation_score(self, generated_description):
        return len(generated_description)