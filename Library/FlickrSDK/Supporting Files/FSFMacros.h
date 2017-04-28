
//  Created by PRABHAKAR, PRAJEESH on 4/14/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//

// *************************************************************************************************
#pragma mark -
#pragma mark Threads Macros


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


//**************************************************************************************************
#pragma mark -
#pragma mark Common

#define PHOTO_NETWORK_MANAGER @"photo"
#define PHOTOS_NETWORK_MANAGER @"photos"
