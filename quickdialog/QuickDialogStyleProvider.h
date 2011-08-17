//
//  Created by escoz on 7/29/11.
//

@protocol QuickDialogStyleProvider                                 

@optional

-(void) cell:(UITableViewCell *)cell willAppearForElement:(QElement *)element atIndexPath:(NSIndexPath *)indexPath; 

@end