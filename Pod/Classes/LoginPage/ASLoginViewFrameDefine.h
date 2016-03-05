

#ifndef ASLoginViewFrameDefine_h
#define ASLoginViewFrameDefine_h

// 忘记密码页（RkyForgetPasswordViewController）页面所有的布局
#pragma mark - RkyForgetPasswordViewController frames

#define FORGETPASSWORD_EMAILIMAGEVIEW_LEFT 62
#define FORGETPASSWORD_EMAILIMAGEVIEW_TOP 7
#define FORGETPASSWORD_EMALEIMAGEVIEW_WIDTH 251
#define FORGETPASSWORD_EMALEIMAGEVIEW_HEIGHT 23.5

#define FORGETPASSWORD_PASSWORDIMAGEVIEW_LEFT FORGETPASSWORD_EMAILIMAGEVIEW_LEFT
#define FORGETPASSWORD_PASSWORDIMAGEVIEW_TOP 61.5
#define FORGETPASSWORD_PASSWORDIMAGEVIEW_WIDTH FORGETPASSWORD_EMALEIMAGEVIEW_WIDTH
#define FORGETPASSWORD_PASSWORDIMAGEVIEW_HEIGHT FORGETPASSWORD_EMALEIMAGEVIEW_HEIGHT

#define FORGETPASSWORD_MAILTEXTFILED_LEFT 21.5
#define FORGETPASSWORD_MAILTEXTFILED_TOP 0
#define FORGETPASSWORD_MAILTEXTFILED_WIDTH 230
#define FORGETPASSWORD_MAILTEXTFILED_HEIGHT 23.5

#define FORGETPASSWORD_PASSWORDTEXTFILED_LEFT FORGETPASSWORD_MAILTEXTFILED_LEFT
#define FORGETPASSWORD_PASSWORDTEXTFILED_TOP FORGETPASSWORD_MAILTEXTFILED_TOP
#define FORGETPASSWORD_PASSWORDTEXTFILED_WIDTH 104.5
#define FORGETPASSWORD_PASSWORDTEXTFILED_HEIGHT FORGETPASSWORD_MAILTEXTFILED_HEIGHT

#define FORGETPASSWORD_VERIFITIONCODEBTN_LEFT 131
#define FORGETPASSWORD_VERIFITIONCODEBTN_TOP 0
#define FORGETPASSWORD_VERIFITIONCODEBTN_WIDTH 120
#define FORGETPASSWORD_VERIFITIONCODEBTN_HEIGHT 23

#define FORGETPASSWORD_VERIFIEDBTN_LEFT 35
#define FORGETPASSWORD_VERIFIEDBTN_TOP (IS_IPHONE_4_OR_LESS?110:195)
#define FORGETPASSWORD_VERIFIEDBTN_WIDTH 250
#define FORGETPASSWORD_VERIFIEDBTN_HEIGHT 35

#define FORGETPASSWORD_BACKBTN_LEFT 15
#define FORGETPASSWORD_BACKBTN_TOP 36
#define FORGETPASSWORD_BACKBTN_WIDTH 28
#define FORGETPASSWORD_BACKBTN_HEIGHT FORGETPASSWORD_BACKBTN_WIDTH

#define FORGETPASSWORD_CONTAINERVIEW_LEFT 0
#define FORGETPASSWORD_CONTAINERVIEW_TOP 256
#define FORGETPASSWORD_CONTAINERVIEW_WIDTH (self.view.frame.size.width)
#define FORGETPASSWORD_CONTAINERVIEW_HEIGHT 230

// 重置密码页（RkyResetPasswordViewController）页面所有的布局
#pragma mark - RkyResetPasswordViewController frames

#define RESETPASSWORD_PASSWORDIMAGEVIEW_LEFT FORGETPASSWORD_EMAILIMAGEVIEW_LEFT
#define RESETPASSWORD_PASSWORDIMAGEVIEW_TOP FORGETPASSWORD_EMAILIMAGEVIEW_TOP
#define RESETPASSWORD_PASSWORDIMAGEVIEW_WIDTH FORGETPASSWORD_EMALEIMAGEVIEW_WIDTH
#define RESETPASSWORD_PASSWORDIMAGEVIEW_HEIGHT FORGETPASSWORD_EMALEIMAGEVIEW_HEIGHT

#define RESETPASSWORD_PASSWORDTEXTFIELD_LEFT FORGETPASSWORD_MAILTEXTFILED_LEFT
#define RESETPASSWORD_PASSWORDTEXTFIELD_TOP FORGETPASSWORD_MAILTEXTFILED_TOP
#define RESETPASSWORD_PASSWORDTEXTFIELD_WIDTH 200
#define RESETPASSWORD_PASSWORDTEXTFIELD_HEIGHT FORGETPASSWORD_MAILTEXTFILED_HEIGHT

#define RESETPASSWORD_VERIFIEDBTN_LEFT 0
#define RESETPASSWORD_VERIFIEDBTN_TOP FORGETPASSWORD_VERIFIEDBTN_TOP
#define RESETPASSWORD_VERIFIEDBTN_WIDTH 250
#define RESETPASSWORD_VERIFIEDBTN_HEIGHT 35

#define RESETPASSWORD_BACKBTN_LEFT FORGETPASSWORD_BACKBTN_LEFT
#define RESETPASSWORD_BACKBTN_TOP FORGETPASSWORD_BACKBTN_TOP
#define RESETPASSWORD_BACKBTN_WIDTH FORGETPASSWORD_BACKBTN_WIDTH
#define RESETPASSWORD_BACKBTN_HEIGHT FORGETPASSWORD_BACKBTN_HEIGHT

#define RESETPASSWORD_SHOWPASSWORDBTN_LEFT 235
#define RESETPASSWORD_SHOWPASSWORDBTN_TOP 0
#define RESETPASSWORD_SHOWPASSWORDBTN_WIDTH 15
#define RESETPASSWORD_SHOWPASSWORDBTN_HEIGHT 22

#define RESETPASSWORD_CONTAINERVIEW_LEFT FORGETPASSWORD_CONTAINERVIEW_LEFT
#define RESETPASSWORD_CONTAINERVIEW_TOP FORGETPASSWORD_CONTAINERVIEW_TOP
#define RESETPASSWORD_CONTAINERVIEW_WIDTH FORGETPASSWORD_CONTAINERVIEW_WIDTH
#define RESETPASSWORD_CONTAINERVIEW_HEIGHT FORGETPASSWORD_CONTAINERVIEW_HEIGHT

#endif /* ASLoginViewFrameDefine_h */
