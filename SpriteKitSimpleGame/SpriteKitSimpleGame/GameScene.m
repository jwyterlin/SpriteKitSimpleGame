//
//  GameScene.m
//  SpriteKitSimpleGame
//
//  Created by Jhonathan Wyterlin on 09/06/15.
//  Copyright (c) 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()

@property(nonatomic,strong) SKSpriteNode *player;
@property(nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property(nonatomic) NSTimeInterval lastUpdateTimeInterval;

@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    
    if ( self = [super initWithSize:size] ) {
        
        NSLog( @"Size: %@", NSStringFromCGSize( size ) );
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        self.player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        self.player.position = CGPointMake(self.player.size.width/2, self.frame.size.height/2);
        [self addChild:self.player];
        
    }
    
    return self;
    
}

-(void)didMoveToView:(SKView *)view {
    
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake( CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) );
    
    [self addChild:myLabel];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
        
    }
    
}

-(void)update:(CFTimeInterval)currentTime {

    /* Called before each frame is rendered */

    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;

    self.lastUpdateTimeInterval = currentTime;

    if ( timeSinceLast > 1 ) { // more than a second since last update

        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;

    }

    [self updateWithTimeSinceLastUpdate:timeSinceLast];

}

-(void)addMonster {
    
    // Create sprite
    SKSpriteNode * monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    
    // Determine where to spawn the monster along the Y axis
    int minY = monster.size.height / 2;
    int maxY = self.frame.size.height - monster.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPointMake(self.frame.size.width + monster.size.width/2, actualY);
    [self addChild:monster];
    
    // Determine speed of the monster
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(-monster.size.width/2, actualY) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [monster runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
}

-(void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
 
    if ( self.lastSpawnTimeInterval > 1 ) {
        
        self.lastSpawnTimeInterval = 0;
        
        [self addMonster];
        
    }
    
}

@end
