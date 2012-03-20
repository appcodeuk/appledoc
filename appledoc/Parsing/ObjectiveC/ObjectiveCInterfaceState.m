//
//  ObjectiveCInterfaceState.m
//  appledoc
//
//  Created by Tomaž Kragelj on 3/20/12.
//  Copyright (c) 2012 Tomaz Kragelj. All rights reserved.
//

#import "ObjectiveCInterfaceState.h"

@implementation ObjectiveCInterfaceState

- (NSUInteger)parseStream:(TokensStream *)stream forParser:(ObjectiveCParser *)parser store:(Store *)store {
	if ([stream matches:@"-", nil] || [stream matches:@"+", nil]) {
		// Match method declaration or implementation. Must not consume otherwise we can't distinguish between instance and class method!
		//[parser pushState:parser.methodState];
		[stream consume:1]; // DEBUG ONLY!
	} else if ([stream matches:@"@", @"property", nil]) {
		// Match property declaration. Although we could consume, we don't to keep compatible with methods above...
		//[parser pushState:parser.propertyState];
		[stream consume:1]; // DEBUG ONLY!
	} else if ([stream matches:@"@", @"end", nil]) {
		// Match end of interface or implementation.
		LogParVerbose(@"@end");
		[stream consume:2];
		[parser popState];
	} else if ([stream matches:@"#", @"pragma", @"mark", nil]) {
		// Match #pragma mark. Must not consume here otherwise it makes it very hard to determine whether - is part of #pragma or start of instance method!
		//[parser pushState:parser.pragmaMarkState];
		[stream consume:1]; // DEBUG ONLY!
	} else {
		[stream consume:1];
	}
	return 0;
}

@end
