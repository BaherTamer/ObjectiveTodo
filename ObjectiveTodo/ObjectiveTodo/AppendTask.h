//
//  AppendTask.h
//  ObjectiveTodo
//
//  Created by Baher Tamer on 26/06/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AppendTask

- (void)appendTask:(NSString *)name andPriority:(NSString *)priority;	

@end

NS_ASSUME_NONNULL_END
