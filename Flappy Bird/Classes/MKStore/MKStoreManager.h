

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreObserver.h"

@interface MKStoreManager : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver> {
	NSMutableArray *purchasableObjects;
	MKStoreObserver *storeObserver;
}

@property (nonatomic, retain) NSMutableArray *purchasableObjects;
@property (nonatomic, retain) MKStoreObserver *storeObserver;

- (void) requestProductData;

- (void) buyFeatureLives;

// do not call this directly. This is like a private method

- (void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) provideContent: (NSString*) productIdentifier;

+ (MKStoreManager*)sharedManager;

+ (BOOL) featureLivesPurchased;

+(void) loadPurchases;
+(void) updatePurchases;

-(void)restoreFunc;

@end
