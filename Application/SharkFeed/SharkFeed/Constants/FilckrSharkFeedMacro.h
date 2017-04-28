//
//  FilkrSharkFeedConstants.h
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//




// *************************************************************************************************
#pragma mark -
#pragma mark Application Singleton Instance


#define APP_MANAGER ([FlickrSharkFeedApplicationManager sharedInstance])


// *************************************************************************************************
#pragma mark -
#pragma mark Block Macros


/**
 * Executes the given block on a background thread.
 *
 * @param aBlock the block to be executed
 */
#define EXECUTE_BLOCK_ON_BACKGROUND_THREAD(aBlock)                                                 \
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), aBlock);


/**
 * Executes the given block on the main thread.
 *
 * @param aBlock the block to be executed
 */
#define EXECUTE_BLOCK_ON_MAIN_THREAD(aBlock) dispatch_sync(dispatch_get_main_queue(), aBlock);


// *************************************************************************************************
#pragma mark -
#pragma mark NSThread Macros


/**
 * Ensures the current method is executed on the main thread.  If the method is called on any other
 * thread other than the main thread, the method calls itself on the main thread using the
 * performSelectorOnMainThread:withObject:waitUntilDone: method.
 *
 * NOTE: This macro must be used at the begining of the method.
 *
 * @param anObject the object to pass to the performSelectorOnMainThread:withObject:waitUntilDone:
 * method
 */
#define ENSURE_EXECUTION_ON_MAIN_THREAD(anObject)                                                  \
if (![NSThread isMainThread]) {                                                                \
[self performSelectorOnMainThread:_cmd withObject:anObject waitUntilDone:YES];             \
return;                                                                                    \
}



//**************************************************************************************************
#pragma mark -
#pragma mark Common

#define IMAGE_BACKGROUND_NETWORK @"network_communication_background"
#define IMAGE_NAVIFATION @"navigation"
#define IMAGE_HOMESCREEN @"homeScreen"
#define IMAGE_HOME_BUTTON @"homeButton"
#define LAUNCH_HOME_SCREEN @"LaunchNav"









