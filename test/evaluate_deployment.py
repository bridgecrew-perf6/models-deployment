from  test_service import TestStationService

test=TestStationService()

print("Testing sklearn classifier")
print("Single prediction")
test.test_successful_single_sklearn_response()
print("Batch prediction")
test.test_successful_batch_sklearn_response()
print("Fail single prediction")
test.test_fail_single_sklearn_response()
print("Fail batch prediction")
test.test_fail_batch_sklearn_response()


print("Testing pytorch classifier")
print("Single prediction")
test.test_successful_single_pytorch_response()
print("Batch prediction")
test.test_successful_batch_pytorch_response()

print("Fail single prediction")
test.test_fail_single_pytorch_response()
print("Fail batch prediction")
test.test_fail_batch_pytorch_response()



print("Testing astromech classifier")
print("Single prediction")
test.test_successful_single_astromech_response()
print("Batch prediction")
test.test_successful_batch_astromech_response()
print("Fail single prediction")
test.test_fail_single_astromech_response()
print("Fail batch prediction")
test.test_fail_batch_astromech_response()




