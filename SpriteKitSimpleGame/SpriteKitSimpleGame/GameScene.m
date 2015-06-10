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
}

@end
