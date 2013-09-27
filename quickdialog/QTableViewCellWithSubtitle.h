//
//  QTableViewCellWithSubtitle.h
//  QuickDialog
//
//  Created by Hugo Doria on 9/27/13.
//
//

#import "QTableViewCell.h"

@class QElement;

@interface QTableViewCellWithSubtitle : QTableViewCell

@property (nonatomic) QLabelingPolicy labelingPolicy;
@property (nonatomic, strong) UILabel *subtitle;

- (QTableViewCell *)initWithReuseIdentifier:(NSString *)string;
- (void)applyAppearanceForElement:(QElement *)element;

@end