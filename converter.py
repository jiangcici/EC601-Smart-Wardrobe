import coremltools
coreml_model = coremltools.converters.keras.convert('keras_cnn_model_our_dataset.h5', input_names='data', image_input_names='data', is_bgr=True, output_names='species')
coreml_model.save('modelclothings.mlmodel')
