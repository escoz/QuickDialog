#import <Foundation/Foundation.h>

@class QEntryElement;
@class QEntryTableViewCell;
@class QDecimalTableViewCell;

@protocol QuickDialogEntryElementDelegate <NSObject>

@optional
- (BOOL)QEntryShouldChangeCharactersInRange:(NSRange)range withString:(NSString *)string forElement:(QEntryElement *)element andCell:(QEntryTableViewCell *)cell;
- (void)QEntryEditingChangedForElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell;
- (void)QEntryDidBeginEditingElement:(QEntryElement *)element  andCell:(QEntryTableViewCell *)cell;
- (void)QEntryDidEndEditingElement:(QEntryElement *)element andCell:(QEntryTableViewCell *)cell;
- (BOOL)QEntryShouldReturnForElement:(QEntryElement *)element andCell:(QEntryTableViewCell *)cell;
- (void)QEntryMustReturnForElement:(QEntryElement *)element andCell:(QEntryTableViewCell *)cell;

@end
