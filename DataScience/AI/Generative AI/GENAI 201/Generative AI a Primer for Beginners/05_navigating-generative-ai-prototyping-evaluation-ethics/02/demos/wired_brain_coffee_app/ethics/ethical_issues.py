class EthicalIssues:
    def check_ethical_issues(self, generated_description):
        ethical_issues = []
        if "biased_word" in generated_description:
            ethical_issues.append("The description contains biased language.")
        return ethical_issues