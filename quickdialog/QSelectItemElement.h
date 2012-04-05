//
//  QSelectItemElement.h
//  QuickDialog
//
//  Created by HiveHicks on 23.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QLabelElement.h"
#import "QuickDialogTableView.h"
#import "QLabelElement.h"
#import "QSelectSection.h"

@interface QSelectItemElement : QLabelElement
{
    NSUInteger _index;
    QSelectSection *_selectSection;
}

- (QSelectItemElement *)initWithIndex:(NSUInteger)integer selectSection:(QSelectSection *)section;

@end
