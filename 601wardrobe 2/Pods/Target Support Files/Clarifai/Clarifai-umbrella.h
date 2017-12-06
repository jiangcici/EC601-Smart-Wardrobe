#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ClarifaiApp.h"
#import "ClarifaiConcept.h"
#import "ClarifaiConstants.h"
#import "ClarifaiCrop.h"
#import "ClarifaiGeo.h"
#import "ClarifaiImage.h"
#import "ClarifaiInput.h"
#import "ClarifaiLocation.h"
#import "ClarifaiModel.h"
#import "ClarifaiModelVersion.h"
#import "ClarifaiOutput.h"
#import "ClarifaiOutputFace.h"
#import "ClarifaiOutputFocus.h"
#import "ClarifaiOutputRegion.h"
#import "ClarifaiSearchResult.h"
#import "ClarifaiSearchTerm.h"
#import "NSArray+Clarifai.h"
#import "NSDictionary+Clarifai.h"
#import "ResponseSerializer.h"

FOUNDATION_EXPORT double ClarifaiVersionNumber;
FOUNDATION_EXPORT const unsigned char ClarifaiVersionString[];

