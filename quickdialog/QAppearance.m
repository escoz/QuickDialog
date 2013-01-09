
@implementation QAppearance {

    NSMutableDictionary *_dict;
}

- (id)init {
    self = [super init];
    if (self) {
        _dict = [NSMutableDictionary new];
    }

    return self;
}

- (id)initWithObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt {
    _dict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys count:cnt];
    return self;
}
- (NSUInteger)count {
    return [_dict count];
}
- (id)objectForKey:(id)aKey {
    return [_dict objectForKey:aKey];
}
- (NSEnumerator *)keyEnumerator {
    return [_dict keyEnumerator];
}


- (void)setObject:(NSString *)object forKey:(NSString *)key {
    [_dict setObject:object forKey:key];

}
@end
