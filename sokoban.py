import pygame
import sys

# Initialize Pygame
pygame.init()

# Game constants
TILE_SIZE = 50
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLUE = (0, 0, 255)
BROWN = (139, 69, 19)

# Create game window
screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
pygame.display.set_caption('Sokoban')

# Game map
# 0: Empty
# 1: Wall
# 2: Box
# 3: Target
# 4: Player
level = [
    [1, 1, 1, 1, 1, 1, 1],
    [1, 0, 0, 0, 0, 0, 1],
    [1, 0, 2, 0, 2, 0, 1],
    [1, 0, 0, 4, 0, 0, 1],
    [1, 0, 2, 0, 3, 0, 1],
    [1, 0, 3, 0, 3, 0, 1],
    [1, 1, 1, 1, 1, 1, 1]
]

def get_player_pos():
    for y in range(len(level)):
        for x in range(len(level[y])):
            if level[y][x] == 4:
                return [x, y]
    return None

def draw_game():
    screen.fill(WHITE)
    for y in range(len(level)):
        for x in range(len(level[y])):
            rect = pygame.Rect(x * TILE_SIZE + 200, y * TILE_SIZE + 100, TILE_SIZE, TILE_SIZE)
            if level[y][x] == 1:  # Wall
                pygame.draw.rect(screen, BLACK, rect)
            elif level[y][x] == 2:  # Box
                pygame.draw.rect(screen, BROWN, rect)
            elif level[y][x] == 3:  # Target
                pygame.draw.rect(screen, RED, rect, 2)
            elif level[y][x] == 4:  # Player
                pygame.draw.rect(screen, BLUE, rect)
            
            pygame.draw.rect(screen, (200, 200, 200), rect, 1)

def check_win():
    boxes_on_target = 0
    target_count = 0
    for row in level:
        for cell in row:
            if cell == 3:
                target_count += 1
    
    for y in range(len(level)):
        for x in range(len(level[y])):
            if level[y][x] == 2:
                for target_y in range(len(level)):
                    for target_x in range(len(level[target_y])):
                        if level[target_y][target_x] == 3 and (x == target_x and y == target_y):
                            boxes_on_target += 1
    
    return boxes_on_target == target_count

def main():
    player_pos = get_player_pos()
    clock = pygame.time.Clock()
    font = pygame.font.Font(None, 36)

    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            
            if event.type == pygame.KEYDOWN:
                x, y = player_pos
                new_x, new_y = x, y
                
                if event.key == pygame.K_LEFT:
                    new_x = x - 1
                elif event.key == pygame.K_RIGHT:
                    new_x = x + 1
                elif event.key == pygame.K_UP:
                    new_y = y - 1
                elif event.key == pygame.K_DOWN:
                    new_y = y + 1
                elif event.key == pygame.K_r:  # Reset
                    main()
                    return
                
                if level[new_y][new_x] != 1:  # Not wall
                    if level[new_y][new_x] == 2:  # Box
                        box_x = new_x + (new_x - x)
                        box_y = new_y + (new_y - y)
                        
                        if level[box_y][box_x] != 1 and level[box_y][box_x] != 2:
                            level[box_y][box_x] = 2
                            level[new_y][new_x] = 4
                            level[y][x] = 0
                            player_pos = [new_x, new_y]
                    else:  # Empty or target
                        level[new_y][new_x] = 4
                        level[y][x] = 0
                        player_pos = [new_x, new_y]

        draw_game()
        
        text = font.render("Use arrow keys to move, Press R to reset", True, BLACK)
        screen.blit(text, (200, 50))
        
        if check_win():
            win_text = font.render("Congratulations! Press R to restart", True, GREEN)
            screen.blit(win_text, (250, 500))
        
        pygame.display.flip()
        clock.tick(60)

if __name__ == "__main__":
    main() 