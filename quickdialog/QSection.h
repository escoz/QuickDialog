//
//  Created by escoz on 7/7/11.
//
//  To change this template use File | Settings | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QElement;
@class QRootElement;


@interface QSection : NSObject {

    NSString *_key;
    CGRect _entryPosition;

@private
    QRootElement *_rootElement;
    UIView *_headerView;
    UIView *_footerView;
}

@property(nonatomic, strong) NSString *key;

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *footer;

@property(nonatomic, retain) NSMutableArray * elements;
@property(nonatomic, retain) QRootElement *rootElement;

@property(nonatomic, readonly) BOOL needsEditing;

@property(nonatomic, retain) UIView *headerView;
@property(nonatomic, retain) UIView *footerView;
@property(nonatomic) CGRect entryPosition;

- (QSection *)initWithTitle:(NSString *)string;

- (void)addElement:(QElement *)element;

- (void)fetchValueIntoObject:(id)obj;

@end