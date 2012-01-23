
@protocol QEntryElementDelegate <NSObject>

@optional
- (void)QEntryShouldChangeCharactersInRangeForElement:(QEntryElement *)element;
- (void)QEntryEditingChangedForElement:(QEntryElement *)element;
- (void)QEntryDidBeginEditingElement:(QEntryElement *)element;
- (void)QEntryDidEndEditingElement:(QEntryElement *)element;
- (void)QEntryShouldReturnForElement:(QEntryElement *)element;
- (void)QEntryMustReturnForElement:(QEntryElement *)element;

@end