//
//  Location.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/15/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location: Equatable {}

func ==(lhs: Location, rhs: Location) -> Bool {
    if lhs.coordinate?.latitude != rhs.coordinate?.latitude {
        return false
    }
    if lhs.coordinate?.longitude != rhs.coordinate?.longitude {
        return false
    }
    if lhs.name != rhs.name {
        return false
    }
    
    return true
}

////HUNGNV2
//
//if ([url.scheme isEqualToString:@"ygo"] && [url.host isEqualToString:@"reserve"]) {
//    
//    if ( ([self.navigationController topViewController] != nil)  && ([[self.navigationController topViewController] isKindOfClass: [RoundReserveViewController class]] )) {
//        return YES;
//    }
//    
//    RoundReserveViewController *vc = [[RoundReserveViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    UIImage *backgroundImage = [UIImage imageNamed:@"navigationbar_bg.png"];
//    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//    
//    return YES;
//}
////End