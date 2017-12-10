# EC601-Smart-Wardrobe

The Smart Wardrobe is an iOS app that can help users create an inventory of their clothes and also match them to create complete outfits in a short period of time.

The basic functions of the App are:
1. Create an inventory of the users clothes.
2. Organize them based on the category.
3. Allow the user to create sets of clothes for various occassions and seasons.
4. Create sets of clothes from the user's inventory for a specific season or occassion.
5. Matching clothes.


HOW TO RUN OUR CODE (YOU NEED XCODE/MAC SINCE OUR PROJECT IS IOS APP AND WRITTEN IN SWIFT):

- First, download the "601wardrobe 2" folder as a zip file.
- Second, unzip the zip file and a folder called "601wardrobe 2" will come up.
- Download the coreML model from this link: https://drive.google.com/file/d/1g40tqptDSHUX7Q7etqA5kCumVjMyEMJ-/view?usp=sharing
- Then, move this coreML zip file to the folder containing the Xcode files and unzip it. 
- Then, open the folder and run "601wardrobe.xcworkspace" in Xcode. You might need to add the coreML model into projec navigator section. 
- Last, build and run the code with a simulator in Xcode. 

SOME SCREENSHOTS FROM OUR APP:


<img height="200" src="https://github.com/jiangcici/EC601-Smart-Wardrobe/blob/master/App%20Screenshots/IMG_1766.PNG" /> <img height="200" src="https://github.com/jiangcici/EC601-Smart-Wardrobe/blob/master/App%20Screenshots/IMG_1767.PNG" /> <img height="200" src="https://github.com/jiangcici/EC601-Smart-Wardrobe/blob/master/App%20Screenshots/IMG_1768.PNG" /> <img height="200" src="https://github.com/jiangcici/EC601-Smart-Wardrobe/blob/master/App%20Screenshots/IMG_1769.PNG" />


cnn_our_dataset.ipynb
This python notebook contains the keras CNN model that we have used to train our dataset. 
We have managed to achieve an accuracy of 81%.

prediction_cnn.ipynb
This python notebook contains the python code used to get the predictions of our trained model.
 
train.py
This contains the code to create a 200* 200 grayscale image dataset from our existing dataset and then trains the model.It saves the trained model.

converter.py
This python code converts the saved keras model into a coreml model using the coreml python tools. The resultant coreml model can be directly integrated into the ios app.

Image_dataset: The folder image_resized contains our dataset.

It is a dataset of 246 images(200 * 200 pixels each) in 5 categories:
0-Dress(55 images)
1-Heels(38 images)
2-Shoes(50 images)
3-Tees(50 images)
4-Trousers(50 images)
