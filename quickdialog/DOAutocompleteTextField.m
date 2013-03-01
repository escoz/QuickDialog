/* 
 * Copyright 2011 DoAT. All rights reserved.
 *
 * Updated by Iain Stubbs 2012 for use in QAutoEntryElement
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation and/or
 *    other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY DoAT “AS IS” WITHOUT ANY WARRANTIES WHATSOEVER. 
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF NON INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A 
 * PARTICULAR PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL DoAT OR CONTRIBUTORS 
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * The views and conclusions contained in the software and documentation are those of 
 * the authors and should not be interpreted as representing official policies, 
 * either expressed or implied, of DoAT.
 */

#import "DOAutocompleteTextField.h"
#import "NSMutableArray+IMSExtensions.h"

@interface DOAutocompleteTextField (Private) 

- (void)setupSubviews;
- (void)_textDidChange:(NSNotification*)notification;
- (void)_updateAutocompleteLabel;

@end

@implementation DOAutocompleteTextField

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setupSubviews];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setupSubviews];    
}

- (void)setupSubviews
{
    _autocompleteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _autocompleteLabel.font = self.font;
    _autocompleteLabel.backgroundColor = [UIColor clearColor];
    _autocompleteLabel.textColor = [UIColor lightGrayColor];
    _autocompleteLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:_autocompleteLabel];
    [self bringSubviewToFront:_autocompleteLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChange:) name:UITextFieldTextDidChangeNotification object:self];    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

- (BOOL)becomeFirstResponder
{
    if ([self clearsOnBeginEditing]) 
    {
        _autocompleteLabel.text = @"";
    }
    
    [self _tryToUpdateLabelWithNewCompletion];
    _autocompleteLabel.hidden = NO;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    _autocompleteLabel.hidden = YES;
    return [super resignFirstResponder];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [_autocompleteLabel setFont:font];
}

- (CGRect)autocompleteRectForBounds:(CGRect)bounds
{
    CGRect returnRect = CGRectZero;
    CGRect textRect = [self textRectForBounds:self.bounds];
    //    NSLog(@"textRect: %@", NSStringFromCGRect(textRect));
    
    CGSize prefixTextSize = [self.text sizeWithFont:self.font
                                  constrainedToSize:textRect.size
                                      lineBreakMode:NSLineBreakByCharWrapping];
    //    NSLog(@"prefixTextSize: %@",  NSStringFromCGSize(prefixTextSize));
    
    CGSize autocompleteTextSize = [_autoCompleteString sizeWithFont:self.font 
                                                  constrainedToSize:CGSizeMake(textRect.size.width-prefixTextSize.width, textRect.size.height)
                                                      lineBreakMode:NSLineBreakByCharWrapping];
    
    //    NSLog(@"autocompleteTextSize: %@",  NSStringFromCGSize(autocompleteTextSize)); 
    
    returnRect = CGRectMake(textRect.origin.x + prefixTextSize.width,
                            textRect.origin.y,//+.5,
                            autocompleteTextSize.width,
                            textRect.size.height);
    
    return returnRect;
}

- (void)setAutocompleteTextColor:(UIColor*)color
{
    _autocompleteLabel.textColor = color;
}

- (UIColor*)autocompleteTextColor
{
    return _autocompleteLabel.textColor;
}

- (void)_textDidChange:(NSNotification*)notification
{
    [self _tryToUpdateLabelWithNewCompletion];
}

- (void)_tryToUpdateLabelWithNewCompletion
{
    if ([((id<DOAutocompleteTextFieldDelegate>)self.delegate) respondsToSelector:@selector(textField:completionForPrefix:)] )
    {
        _autoCompleteString = [((id<DOAutocompleteTextFieldDelegate>)self.delegate) textField:self completionForPrefix:self.text];
        [self _updateAutocompleteLabel];
    }
}

- (void)_updateAutocompleteLabel
{
    [_autocompleteLabel setText:_autoCompleteString];
    [_autocompleteLabel sizeToFit];
    [_autocompleteLabel setFrame: [self autocompleteRectForBounds:self.bounds]];        
}

- (NSString*)getAutoCompleteText
{
    NSMutableArray *ac = [NSMutableArray arrayWithObjects:self.text,_autoCompleteString, nil];
    return [ac concatStrings];
}

- (void)setAutoCompletes:(NSArray*)autoCompletes
{
    _autoCompletes = autoCompletes;
}

- (NSArray*)getAutoCompletes
{
    return _autoCompletes;
}
@end

