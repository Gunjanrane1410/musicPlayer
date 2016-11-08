//
//  ViewController.m
//  GRMusicPlayer
//
//  Created by Student P_05 on 03/11/16.
//  Copyright © 2016 Gunjan Rane. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    isplaying = false;
    self.slider.userInteractionEnabled = YES;

    self.slider.minimumValue = 0;
    self.slider.value = 0;
    [self.slider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initializationOfTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDurationOfSlider) userInfo:nil repeats:YES];
    
}

-(void)updateDurationOfSlider {
    
    if (self.slider.value == myAudioplayer.duration) {
        timer = nil;
    }
    self.slider.value = myAudioplayer.currentTime;
}
-(void)updateSlider{
    
    if (self.slider.value == myAudioplayer.duration) {
        timer = nil;
    }
    self.slider.value = myAudioplayer.currentTime;

}
-(BOOL)initialzeAudioPlayer{
    
    BOOL status = false;
    //NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    NSURL *musicURL = [[NSBundle mainBundle]URLForResource:@"myMusic" withExtension:@"mp3"];
    if (musicURL != nil) {
        NSError *error;
        myAudioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
            self.slider.maximumValue = myAudioplayer.duration;

            status = true;
        }
    }
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:musicURL options:nil];
    
    NSArray *titles = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyTitle keySpace:AVMetadataKeySpaceCommon];
    NSArray *artists = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyArtist keySpace:AVMetadataKeySpaceCommon];
    NSArray *albumNames = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata withKey:AVMetadataCommonKeyAlbumName keySpace:AVMetadataKeySpaceCommon];
    
    AVMetadataItem *title = [titles objectAtIndex:0];
    AVMetadataItem *artist = [artists objectAtIndex:0];
    AVMetadataItem *albumName = [albumNames objectAtIndex:0];
    
    NSArray *metadata = [asset commonMetadata];
    
    
    for (AVMetadataItem *item in metadata) {
        if ([[item commonKey] isEqualToString:@"title"]) {
            titleOfSong = (NSString *)[item value];
        }
        
        if ([[item commonKey] isEqualToString:@"artist"]) {
            artistsOfSong = (NSString *)[item value];
        }
        
        if ([[item commonKey] isEqualToString:@"albumName"]) {
            albumNamesOfSong = (NSString *)[item value];
        }
        
        self.titleLabel.text =titleOfSong;
        self.ArtistLabel.text =artistsOfSong;
        self.AlbumLabel.text =albumNamesOfSong;
        
    }
    
    NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
        NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
                                                           withKey:AVMetadataCommonKeyArtwork
                                                          keySpace:AVMetadataKeySpaceCommon];
        
        for (AVMetadataItem *item in artworks) {
            if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
//                NSDictionary *d = [item.value copyWithZone:nil];
                
                NSData *data = [item.value copyWithZone:nil];
                UIImage *image = [UIImage imageWithData:data];
                
                self.imageViewArtWork.image = image;
            } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
                self.imageViewArtWork.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
            }
        }
    }];


    
    return status;
}





- (IBAction)playPauseAction:(id)sender {
    
    
        UIButton *button = sender;
    if([button.currentImage isEqual:[UIImage imageNamed:@"play.png"]]){
   if (isplaying) {
                [myAudioplayer play];
       [self initializationOfTimer];

            }
            else
            {
                if([self initialzeAudioPlayer]){
    
                    [myAudioplayer play];
                    [self initializationOfTimer];

                    isplaying = true;
                }
                else{
                    NSLog(@"something wents to wrong while initialzing audio player");
                }
            }
        [button setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        }
    else if([button.currentImage isEqual:[UIImage imageNamed:@"pause.png"]]){


            [myAudioplayer pause];
        [timer invalidate];

            [button setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        }
    

    
}



- (IBAction)stopAction:(id)sender {
    
    [myAudioplayer stop];
    isplaying = false;
    self.slider.value = 0;
    [timer invalidate];
    timer = nil;
    [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
}
@end
