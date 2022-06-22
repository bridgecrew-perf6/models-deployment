from flask import Flask, jsonify, request, json
from sklearn_classifier import SklearnClassifier
from pytorch_classifier import PytorchClassifier
from data_validation import DataValidation
import logging
import os



app = Flask(__name__)



    
PREDICTIONS_VALUES=['blue', 'green', 'yellow']
MODELS_AVAILABLE=['sklearn', 'pytorch']

sklearn_model=SklearnClassifier("trained_models/sklearn.model")
pytorch_model=PytorchClassifier("trained_models/pytorch.model")

   


def build_response(result):
    response = {}
    response['prediction'] = []
    response['scores'] = []
    for i in range(len(result)):
        logging.debug(result[i].index(max(result[i])))
        response['prediction'].append(PREDICTIONS_VALUES[result[i].index(max(result[i]))])
        response['scores'].append(result[i])
        logging.debug(response)

    return response



@app.route('/pytorch', methods=['POST'])
@app.route('/sklearn', methods=['POST'])
@app.route('/astromech', methods=['POST'])
def predict_models():
    validator=DataValidation()
    if not request.is_json:
        logging.error("It is not a json request")
        return jsonify({"msg": "Missing JSON in request"}), 422
    
    if not validator.request_validation(request.json):
        logging.error("Request data is not valid")
        return jsonify({"error": "request is not valid"}), 422
       
    data = json.loads(request.data)
    
    logging.debug(request.path)
    if request.path == '/sklearn':
        result=sklearn_model.predict( data['crystalData'] )
    if request.path == '/pytorch':
        result=pytorch_model.predict( data['crystalData'] )
    
    if request.path == '/astromech' and data['model'] in MODELS_AVAILABLE:
        if data['model'] == 'sklearn':
            result=sklearn_model.predict( data['crystalData'] )                         
        if data['model'] == 'pytorch':
            result=pytorch_model.predict( data['crystalData'] )
    
    if request.path == '/astromech' and data['model'] not in MODELS_AVAILABLE:
        logging.error("Astromech model  is not available")
        return jsonify({"error": "model is not valid"}), 500    

    logging.debug(result)
    if not validator.predict_validation(result):
                logging.error("Result is not valid")
                return jsonify({"error": "result is not valid"}), 500  
    logging.debug(result)
    logging.info("Request processed")   
 
    return jsonify(build_response(result)),200






if __name__ == '__main__':

    LOGLEVEL = os.environ.get('LOGLEVEL', 'INFO').upper()
    logging.basicConfig(level=LOGLEVEL)

    app.run(port=3000)
