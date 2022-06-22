import logging

class DataValidation:

    #trick: np.array(result).dtype 
    def data_validation(self,data):
        if not isinstance(data, list):
            logging.debug("data is not a list")
            return False
        for row in data:
            if not isinstance(row, list):
                logging.debug("row is not a list")
                return False
            if len(row) != 4:
                logging.debug("row size is not 4")
                return False
            for value in row:
                if not isinstance(value, float):
                    logging.debug("not a float")
                    return False
                if value < 0 or value > 1:
                    logging.debug("value is not between 0 and 1")
                    return False    
        return True

    def request_validation(self,request):
        if not isinstance(request, dict):
            logging.debug("request is not a dict")
            return False
        if not 'crystalData' in request:
            logging.debug("request does not contain crystalData")
            return False
        if not self.data_validation(request['crystalData']):
            logging.debug("crystalData is not valid")
            return False
        return True

    

    def predict_validation(self,result):
        if not isinstance(result, list):
            logging.debug("result is not a list")
            return False
        for row in result:
            if not isinstance(row, list):
                logging.debug("row is not a list")
                return False
            if len(row) != 3:
                logging.debug("row is not a list of length 3")
                return False
            for value in row:
                if not isinstance(value, float):
                    logging.debug("not a float")
                    return False
                if value < 0 or value > 1:
                    logging.debug("value is not between 0 and 1")
                    return False            
        return True          