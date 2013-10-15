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

#import <UIKit/UIKit.h>

@class  DOAutocompleteTextField;

@protocol DOAutocompleteTextFieldDelegate <UITextFieldDelegate>

@optional
- (NSString*)textField:(DOAutocompleteTextField*)textField completionForPrefix:(NSString*)prefix;

@end

@interface DOAutocompleteTextField : UITextField
{
    UILabel *_autocompleteLabel;
    NSString *_autoCompleteString;
    NSArray *_autoCompletes;
}

- (CGRect)autocompleteRectForBounds:(CGRect)bounds;
- (void)setAutocompleteTextColor:(UIColor*)color;
- (UIColor*)autocompleteTextColor;
- (NSString*)getAutoCompleteText;
- (void)setAutoCompletes:(NSArray*)autoCompletes;
- (NSArray*)getAutoCompletes;

@end
