//
//  ViewController.h
//  GRMusicPlayer
//
//  Created by Student P_05 on 03/11/16.
//  Copyright © 2016 Gunjan Rane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface ViewController : UIViewController

{
    AVAudioPlayer *myAudioplayer;
    BOOL isplaying;
    MPMediaLibrary *nowPlaying;
    NSString *titleOfSong;
    NSString *artistsOfSong;
    NSString *albumNamesOfSong;
    NSTimer *timer;

}
@property (strong, nonatomic) IBOutlet UISlider *slider;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ArtistLabel;
@property (strong, nonatomic) IBOutlet UILabel *AlbumLabel;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewArtWork;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playPauseAction:(id)sender;

- (IBAction)stopAction:(id)sender;
@end

