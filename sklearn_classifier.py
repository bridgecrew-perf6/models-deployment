import string
from typing import  List, Tuple

from joblib import load
from sklearn.linear_model import LogisticRegression


class SklearnClassifier():
    def __init__(self,sklearn_model_path: string):
        self.model: LogisticRegression = load(sklearn_model_path)

    def predict(self, input_data: List[List[float]]):
        probas = self.model.predict_proba(input_data).tolist()
        return probas
