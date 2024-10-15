//
//  ViewController.m
//  UoW Compass
//
//  Created by Lind Zariqi on 10/05/2022.
//

#import "ViewController.h"
#import "AppMapViewDelegate.h"
@import Wrld;
@import WrldWidgets;

@interface ViewController () <WRLDMapViewDelegate>

//@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) IBOutlet WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;
@property (nonatomic) AppMapViewDelegate *mapViewDelegate;
@property (nonatomic, copy) NSString *coverageTreeManifest;
@property (nonatomic, copy) NSString *environmentThemesManifest;

@end

@implementation ViewController
{
    NSTimer *myTimer;
    BOOL locationToggle;
    CLLocationCoordinate2D initialBlueSphereLocation;
    CLLocationCoordinate2D alteredBlueSphereLocation;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationToggle = false;
    initialBlueSphereLocation = CLLocationCoordinate2DMake(51.521003, -0.140087);
    
    NSString *themeManifest = @"https://cdn-resources.wrld3d.com/chunk/indoor_maps/api_requests/EIM-dc70b511-4c04-4e26-9597-390f0ff437be_2022_05_10_02_13_08/manifest.bin.gz"; // Custom map theme imported
    WRLDMapOptions *mapOptions = [[WRLDMapOptions alloc] init];
    mapOptions.environmentThemesManifest = themeManifest;
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds andMapOptions:mapOptions];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; // Default 3D map view embedded
    _mapView.delegate = self;

//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(51.521003, -0.140087)
//                    zoomLevel:15
//                     animated:NO];
    
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds]; // Indoor slider control
    [_indoorControlView setMapView:_mapView];

    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
    
    
}

- (void)toggleLocation:(NSTimer *)timer
{
    WRLDBlueSphere* bluesphere = timer.userInfo;
    bluesphere.coordinate = locationToggle ? initialBlueSphereLocation : alteredBlueSphereLocation;
    locationToggle = !locationToggle;
}

// Wait until map finishes loading before moving the camera
- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(51.521003, -0.140087)
                    zoomLevel:15
                     animated:NO];
}

@end
