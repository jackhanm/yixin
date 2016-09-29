//
//  Nearhopital.m
//  医信网
//
//  Created by yuhao on 16/9/25.
//  Copyright © 2016年 sjq. All rights reserved.
//

#import "Nearhopital.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "POIAnnotation.h"
#import "PoiDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "UMMobClick/MobClick.h"
#define WIDGHT [[UIScreen mainScreen] bounds].size.width
#define WIDTHSIXP 375.000000
#define HEIGHTSIXP 667.000000
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
//#import "CommonUtility.h"

@interface Nearhopital ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,CLLocationManagerDelegate>
@property (nonatomic, retain)AMapLocationManager *locationManager;
@property (nonatomic, retain) AMapSearchAPI *search;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, assign)BOOL TYPE;
@property (nonatomic, assign)double jindu;
@property (nonatomic, assign)double weidu;
@property (nonatomic, strong) MAPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
@property (nonatomic, retain)CLLocationManager *Locationmanager;
//地理编码/逆地理编码
@property (nonatomic, retain) CLGeocoder *geocoder;
@property (nonatomic , copy)NSString *lat;
@property (nonatomic , copy)NSString *lat1;

@end

@implementation Nearhopital

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.TYPE = YES;
    [MobClick beginLogPageView:@"Pagetwo"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.userTrackingMode = MAUserTrackingModeNone;
    [MobClick endLogPageView:@"Pagetwo"];
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
//    
//  
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.TYPE = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"附近医院";
// 先定位
//    地理编码
    self.geocoder = [[CLGeocoder alloc] init];
    // 定位管理器
    self.Locationmanager = [[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开, 请设置打开");
        return;
    }
    // 如果没有授权就请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.Locationmanager requestWhenInUseAuthorization];
        NSLog(@"1");
        
    }
    
    [self createview];
    
   
    
    
}



#pragma mark - Action Handle

#pragma mark - MAMapViewDelegate

- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
      POIAnnotation *annotation = view.annotation;
    

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您可以选择" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *right = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            id<MAAnnotation> annotation = view.annotation;
            
            if ([annotation isKindOfClass:[POIAnnotation class]])
            {
                POIAnnotation *poiAnnotation = (POIAnnotation*)annotation;
                
                PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
                detail.poi = poiAnnotation.poi;
                
                /* 进入POI详情页面. */
                [self.navigationController pushViewController:detail animated:YES];
            }

            
        }];
        UIAlertAction *left= [UIAlertAction actionWithTitle:@"立即导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self daohangchufadi:self.lat mmudi:annotation.title];
            
            
        }];
        [alert addAction:right];
        [alert addAction:left];
    
        [self presentViewController:alert animated:YES completion:^{
            
            
        }];

    
  }
- (void)daohangchufadi:(NSString *)chufa mmudi:(NSString *)mudi
{
    //根据“北京市”进行地理编码
    [_geocoder geocodeAddressString:chufa completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *clPlacemark1=[placemarks firstObject];//获取第一个地标
        MKPlacemark *mkPlacemark1=[[MKPlacemark alloc]initWithPlacemark:clPlacemark1];
        //地理编码一次只能定位到一个位置，不能同时定位，所在放到第一个位置定位完成回调函数中再次定位
        [_geocoder geocodeAddressString:mudi completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *clPlacemark2=[placemarks firstObject];//获取第一个地标
            MKPlacemark *mkPlacemark2=[[MKPlacemark alloc]initWithPlacemark:clPlacemark2];
            NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
            //MKMapItem *mapItem1=[MKMapItem mapItemForCurrentLocation];//当前位置
            MKMapItem *mapItem1=[[MKMapItem alloc]initWithPlacemark:mkPlacemark1];
            MKMapItem *mapItem2=[[MKMapItem alloc]initWithPlacemark:mkPlacemark2];
            [MKMapItem openMapsWithItems:@[mapItem1,mapItem2] launchOptions:options];
            
        }];
        
    }];
    
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    return nil;
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    if (self.TYPE == YES) {
        self.jindu = userLocation.coordinate.latitude;
        self.weidu = userLocation.coordinate.longitude;
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        //    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        //
        //    request.keywords            = @"医院";
        //    request.city                = self.lat;
        //    request.types               = @"高等院校";
        //    request.requireExtension    = YES;
        //
        //    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
        //    request.cityLimit           = YES;
        //    request.requireSubPOIs      = YES;
        //
        //    [self.search AMapPOIKeywordsSearch:request];
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location            = [AMapGeoPoint locationWithLatitude:self.jindu longitude:self.weidu];
        request.keywords            = @"医院";
        //     按照距离排序.
        request.offset = 20;
        request.sortrule            = 0;
        request.requireExtension    = YES;    // Do any additional setup after loading the view.
        [self.search AMapPOIAroundSearch:request];
        
        NSLog(@"%f %f", userLocation.coordinate.latitude , userLocation.coordinate.longitude);
        
        [self getAddressByLatitude:self.jindu longitude:self.weidu];
        [self setCenterCoordinate:userLocation.coordinate animated:YES];
        self.TYPE = NO;
    }
    
   
}
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate animated:(BOOL)animated
{
  
}
#pragma 根据坐标获得具体地理位置
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
//        NSLog(@"%@", placemark.name);//位置名
        self.lat = placemark.name;
        //字典形式输出
//        NSLog(@"thoroughfare,%@",placemark.thoroughfare);       // 街道
//        NSLog(@"subThoroughfare,%@",placemark.subThoroughfare); // 子街道
        NSLog(@"locality,%@",placemark.locality);               // 市
        self.lat1 = placemark.locality;
//        NSLog(@"subLocality,%@",placemark.subLocality);         // 区
//        NSLog(@"country,%@",placemark.country);
//        NSLog(@"详细信息:%@",placemark.addressDictionary);
        
        
       
    }];
    
}

- (void)createview
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.showsCompass = YES;
    self.mapView.compassOrigin = CGPointMake(0, 100/HEIGHTSIXP *HEIGHT);
    
    //设置地图类型
    self.mapView.mapType = MAMapTypeStandard;
      [self.mapView setZoomLevel:16.1 animated:YES];

    [self.view addSubview:self.mapView];

}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    self.mapView.scrollEnabled = YES;
    if (response.pois.count == 0)
    {
        return;
    }
    
    NSMutableArray *poiAnnotations = [NSMutableArray arrayWithCapacity:response.pois.count];
    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {
        
        [poiAnnotations addObject:[[POIAnnotation alloc] initWithPOI:obj]];
        
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:poiAnnotations];
    
    
    /* 如果只有一个结果，设置其为中心点. */
    if (poiAnnotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[poiAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
}
#pragma mark - MAMapView Delegate


- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor clearColor];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"userPosition"];
        pre.lineWidth = 0;
        //        pre.lineDashPattern = @[@6, @3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = YES;
        self.userLocationAnnotationView = view;
        
    }  
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
