
@protocol QEntryElementDelegate <NSObject>

@optional
- (void)QShouldChangeCharactersInRangeForElement:(QEntryElement *)element;
- (void)QEditingChangedForElement:(QEntryElement *)element;
- (void)QDidBeginEditingElement:(QEntryElement *)element;
- (void)QDidEndEditingElement:(QEntryElement *)element;
- (void)QShouldReturnForElement:(QEntryElement *)element;
- (void)QMustReturnForElement:(QEntryElement *)element;

@end