//
// Copyright 2011 ESCOZ Inc  - http://escoz.com
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License. You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
// ANY KIND, either express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//


#import "QuickDialog.h"

@interface QMultilineTextViewController ()

@end

@implementation QMultilineTextViewController {
    BOOL _viewOnScreen;
    BOOL _keyboardVisible;
    UITextView* _textView;
}

@synthesize textView = _textView;
@synthesize resizeWhenKeyboardPresented = _resizeWhenKeyboardPresented;
@synthesize willDisappearCallback = _willDisappearCallback;
@synthesize entryElement = _entryElement;
@synthesize entryCell = _entryCell;


- (id)initWithTitle:(NSString *)title
{
    if ((self = [super init]))
    {
        self.title = (title!=nil) ? title : NSLocalizedString(@"Note", @"Note");
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _textView.font = [UIFont systemFontOfSize:18.0f];
    }
    return self;
}

- (void)loadView
{
    self.view = _textView;
}

- (void)viewWillAppear:(BOOL)animated
{
    _viewOnScreen = YES;
    [_textView becomeFirstResponder];
    [super viewWillAppear:animated];

    //if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    //    [self performSelector:@selector(setEdgesForExtendedLayout:) withObject:UIRectEdgeNone];
}

- (void)viewWillDisappear:(BOOL)animated {
    _viewOnScreen = NO;
    if (_willDisappearCallback !=nil){
        _willDisappearCallback();
    }
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void) resizeForKeyboard:(NSNotification*)aNotification {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        return;

    if (!_viewOnScreen)
        return;

    BOOL up = aNotification.name == UIKeyboardWillShowNotification;

    if (_keyboardVisible == up)
        return;

    _keyboardVisible = up;
    NSDictionary* userInfo = [aNotification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationOptions animationCurve;
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];

    [UIView animateWithDuration:animationDuration delay:0 options:animationCurve
        animations:^{
            CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
            _textView.contentInset = UIEdgeInsetsMake(0.0, 0.0,  up ? keyboardFrame.size.height : 0, 0.0);
        }
        completion:NULL];
}

- (void)setResizeWhenKeyboardPresented:(BOOL)observesKeyboard {
  if (observesKeyboard != _resizeWhenKeyboardPresented) {
    _resizeWhenKeyboardPresented = observesKeyboard;

    if (_resizeWhenKeyboardPresented) {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeForKeyboard:) name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeForKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    } else {
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
  }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryDidBeginEditingElement:andCell:)]){
        [_entryElement.delegate QEntryDidBeginEditingElement:_entryElement andCell:self.entryCell];
    }

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _entryElement.textValue = textView.text;
    
    [_entryElement handleEditingChanged:self.entryCell];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryShouldChangeCharactersInRange:withString:forElement:andCell:)]){
        return [_entryElement.delegate QEntryShouldChangeCharactersInRange:range withString:text forElement:_entryElement andCell:self.entryCell];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    _entryElement.textValue = textView.text;

    if(_entryElement && _entryElement.delegate && [_entryElement.delegate respondsToSelector:@selector(QEntryEditingChangedForElement:andCell:)]){
        [_entryElement.delegate QEntryEditingChangedForElement:_entryElement andCell:self.entryCell];
    }
}


@end
