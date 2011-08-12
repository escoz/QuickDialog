//
//  Created by escoz on 7/29/11.
//

@protocol QuickDialogStyleProvider                                 

@optional

-(void) cell:(UITableViewCell *)cell willAppearForElement:(Element *)element atIndexPath:(NSIndexPath *)indexPath; 

@end