#import "UIView+WrapContent.h"

@implementation UIView (WrapContent)

- (void)wc_wrapContent {
    NSLayoutConstraint* widthConstraint = [self wc_widthConstraint];
    NSLayoutConstraint* heightConstraint = [self wc_heightConstraint];
    
    CGSize fittingSize = [self sizeThatFits:CGSizeZero];
    
    if (widthConstraint) {
        widthConstraint.constant = fittingSize.width;
    }
    if (heightConstraint) {
        heightConstraint.constant = fittingSize.height;
    }
}

+ (void)wc_wrapToMax:(NSArray *)referenceViews criteria:(WCWrapCriteria)criteria {
    [UIView wc_wrapToMax:referenceViews criteria:criteria padding:0];
}

+ (void)wc_wrapToMax:(NSArray *)referenceViews criteria:(WCWrapCriteria)criteria padding:(CGFloat)padding {
    if (referenceViews == nil || referenceViews.count == 0) {
        return;
    }
    
    CGSize maxSize = [[referenceViews firstObject] sizeThatFits:CGSizeZero];
    CGFloat maxDimension = criteria == WCWrapCriteriaMaxHeight ? maxSize.height : maxSize.width;
    maxDimension += padding;
    
    for (UIView* view in referenceViews) {
        CGSize viewSize = [view sizeThatFits:CGSizeZero];
        CGFloat candidateDimension = criteria == WCWrapCriteriaMaxHeight ? viewSize.height : viewSize.width;
        
        if (maxDimension < candidateDimension) {
            maxDimension = candidateDimension;
        }
    }
    
    for (UIView* view in referenceViews) {
        NSLayoutConstraint* heightConstraint = criteria == WCWrapCriteriaMaxHeight ? [view wc_heightConstraint] : [view wc_widthConstraint];
        heightConstraint.constant = maxDimension;
    }
}

- (NSLayoutConstraint*)wc_widthConstraint {
    for (NSLayoutConstraint* c in self.constraints) {
        if ([c.identifier isEqualToString:@"width"]) {
            return c;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)wc_heightConstraint {
    for (NSLayoutConstraint* c in self.constraints) {
        if ([c.identifier isEqualToString:@"height"]) {
            return c;
        }
    }
    return nil;
}

@end
