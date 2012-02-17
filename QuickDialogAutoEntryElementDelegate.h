// created by Iain Stubbs but based on QuickDialogEntryElementDelegate.h
//                                

#import <Foundation/Foundation.h>

@class QAutoEntryElement;
@class QAutoEntryTableViewCell;

@protocol QuickDialogAutoEntryElementDelegate <NSObject>

@optional
- (BOOL)QEntryShouldChangeCharactersInRangeForElement:(QAutoEntryElement *)element andCell:(QAutoEntryTableViewCell *)cell;
- (void)QEntryEditingChangedForElement:(QAutoEntryElement *)element  andCell:(QAutoEntryTableViewCell *)cell;
- (void)QEntryDidBeginEditingElement:(QAutoEntryElement *)element  andCell:(QAutoEntryTableViewCell *)cell;
- (void)QEntryDidEndEditingElement:(QAutoEntryElement *)element andCell:(QAutoEntryTableViewCell *)cell;
- (void)QEntryShouldReturnForElement:(QAutoEntryElement *)element andCell:(QAutoEntryTableViewCell *)cell;
- (void)QEntryMustReturnForElement:(QAutoEntryElement *)element andCell:(QAutoEntryTableViewCell *)cell;

@end
