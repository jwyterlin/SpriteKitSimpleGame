//
//  GameViewController.m
//  SpriteKitSimpleGame
//
//  Created by Jhonathan Wyterlin on 09/06/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@import AVFoundation;

@interface GameViewController()

@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;

@end

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"background-music-aac" withExtension:@"caf"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    if ( ! skView.scene ) {
    
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = YES;
        
        // Create and configure the scene.
        SKScene *scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
        
    }

}

-(BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }

}

-(void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
