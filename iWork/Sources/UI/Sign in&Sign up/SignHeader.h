//
//  SignHeader.h
//  iWork
//
//  Created by Adele on 11/30/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#ifndef SignHeader_h
#define SignHeader_h

#define kMIN_PASSWORD_LEGTH  6
#define kMAX_PASSWORD_LEGTH  16

#define kUSERDEFAULTPHONE       @"userDefaultPhone"

#define kUSERTOKEN_KEY          @"userToken"
#define kUSERROLR_KEY           @"userRole"
#define kDEVICETOKEN_KEY        @"deviceToken"

typedef enum
{
    kkUserRole_headhunters = 100,
    kkUserRole_HR,
    kkUserRole_candidate,
}kUserRole;

#endif /* SignHeader_h */
