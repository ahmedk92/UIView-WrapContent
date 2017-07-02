#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WCWrapCriteria) {
    WCWrapCriteriaMaxWidth,
    WCWrapCriteriaMaxHeight
};

@interface UIView (WrapContent)

- (void)wc_wrapContent;
+ (void)wc_wrapToMax:(NSArray*)referenceViews criteria:(WCWrapCriteria)criteria;
+ (void)wc_wrapToMax:(NSArray*)referenceViews criteria:(WCWrapCriteria)criteria padding:(CGFloat)padding;

@end
