
#import "RkyAgreementView.h"
#import "ReactiveCocoa.h"
#import "LoginHeader.h"

@interface RkyAgreementView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation RkyAgreementView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.scrollView];
        [self.scrollView addSubview:self.contentLabel];
    }
    return self;
}

- (void)dealloc {

}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = rgb(51, 51, 51); //kCustomColor(51, 51, 51);
        _titleLabel.text = @"用户协议";
        _titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
        [_titleLabel sizeToFit];
        _titleLabel.centerX = self.contentView.width / 2;
        _titleLabel.top = kPointValue(40);
    }
    return _titleLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.width = self.contentView.width - 40;
        _scrollView.height = self.contentView.height - 58 - 23;
        _scrollView.left = 20;
        _scrollView.top = 58;
    }
    return _scrollView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = rgb(136, 136, 136); //kCustomColor(136, 136, 136);
        _contentLabel.text = @"";
        _contentLabel.width = self.scrollView.width;
        _contentLabel.height = 0;
        _contentLabel.left = 0;
        _contentLabel.top = 0;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        _contentLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [_contentLabel addGestureRecognizer:tap];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self)
            [self removeFromSuperview];
        }];
    }
    return _contentLabel;
}

- (UIView *)contentView {
    if (!_contentView) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.width = size.width - 40;
        _contentView.height = 408;
        _contentView.left = 20;
        _contentView.top = size.height - 85 - _contentView.height;
        _contentView.centerY = self.centerY;
        _contentView.layer.cornerRadius = 10;
    }
    return _contentView;
}

- (void)setContent:(NSString *)content {
//    CGSize contentSize = [content boundingRectWithSize:CGSizeMake(self.contentLabel.size.width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil].size;
//    self.contentLabel.size = contentSize;
//    self.contentLabel.text = content;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, content.length)];
    [attributedString addAttribute:NSFontAttributeName
                             value:self.contentLabel.font
                             range:NSMakeRange(0, content.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:self.contentLabel.textColor
                             range:NSMakeRange(0, content.length)];
    self.contentLabel.attributedText = attributedString;
    self.contentLabel.size = [self.contentLabel sizeThatFits:CGSizeMake(self.contentLabel.width, 50000)];
    self.scrollView.contentSize = CGSizeMake(0, self.contentLabel.bottom);
}

@end
