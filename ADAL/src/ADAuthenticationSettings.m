// Copyright (c) Microsoft Corporation.
// All rights reserved.
//
// This code is licensed under the MIT License.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files(the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions :
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ADAuthenticationSettings.h"

@implementation ADAuthenticationSettings

@synthesize requestTimeOut = _requestTimeOut;
@synthesize expirationBuffer = _expirationBuffer;

#if !TARGET_OS_IPHONE
@synthesize defaultStorageDelegate = _defaultStorageDelegate;
#endif // !TARGET_OS_IPHONE

/*!
 An internal initializer used from the static creation function.
 */
-(id) initInternal
{
    self = [super init];
    if (self)
    {
        //Initialize the defaults here:
        self.requestTimeOut = 300;//in seconds.
        self.expirationBuffer = 300;//in seconds, ensures catching of clock differences between the server and the device
#if TARGET_OS_IPHONE
        self.enableFullScreen = YES;
        self.defaultKeychainGroup = @"com.microsoft.adalcache";
#endif
    }
    return self;
}

+(ADAuthenticationSettings*)sharedInstance
{
    /* Below is a standard objective C singleton pattern*/
    static ADAuthenticationSettings* instance;
    static dispatch_once_t onceToken;
    @synchronized(self)
    {
        dispatch_once(&onceToken, ^{
            instance = [[ADAuthenticationSettings alloc] initInternal];
        });
    }
    return instance;
}

@end

