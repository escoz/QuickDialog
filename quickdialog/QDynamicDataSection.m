#import "QDynamicDataSection.h"
#import "QuickDialog.h"
#import "QEmptyListElement.h"

@implementation QDynamicDataSection {
    NSString *_emptyMessage;
}
@synthesize emptyMessage = _emptyMessage;


- (QDynamicDataSection *)init {
    self = [super init];
    if (self) {
        _emptyMessage = @"Empty";
        [self addElement:[[QLoadingElement alloc] init]];
    }
    return self;
}

- (void)bindToObject:(id)data {

    [self.elements removeAllObjects];

    [super bindToObject:data];
    
    if (self.elements.count>0) //elements exist
        return;
    
    NSArray *collection;
    
    for (NSString *each in [self.bind componentsSeparatedByString:@","]) {
        NSArray *bindingParams = [each componentsSeparatedByString:@":"];
        NSString *propName = [((NSString *) [bindingParams objectAtIndex:0]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *valueName = [((NSString *) [bindingParams objectAtIndex:1]) stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if ([propName isEqualToString:@"iterate"]) {
            collection = [data valueForKey:valueName];
        }
    }

    
    if (collection==nil)
        [self addElement:[[QLoadingElement alloc] init]];
    
    if (collection!=nil && collection.count==0)
        [self addElement:[[QEmptyListElement alloc] initWithTitle:_emptyMessage Value:nil]];
}


@end
