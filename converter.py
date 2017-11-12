import coremltools   
import h5py 
coreml_model = coremltools.converters.keras.convert('./keras_cnn_model_our_dataset.h5',input_names='image',image_input_names = 'image',output_names='output',class_labels = output_labels, is_bgr=False)   
coreml_model.save('fashion.mlmodel') 
