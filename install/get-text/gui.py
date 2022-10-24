from re import X
import sys
import pygame


def compute_region(initial_pos, end_pos):
    left = min(initial_pos[0], end_pos[0])
    top = min(initial_pos[1], end_pos[1])
    right = max(initial_pos[0], end_pos[0])
    bottom = max(initial_pos[1], end_pos[1])
    return left, top, right - left, bottom - top


def draw_rect_alpha(surface, color, rect):
    shape_surf = pygame.Surface(pygame.Rect(rect).size, pygame.SRCALPHA)
    shape_surf.set_alpha(50)
    pygame.draw.rect(shape_surf, color, shape_surf.get_rect())
    surface.blit(shape_surf, rect)

def show_window(image_path):
    pygame.init()
    black = 0, 0, 0

    screen = pygame.display.set_mode(flags=pygame.FULLSCREEN)
    pygame.display.set_caption('Select text')
    screenshot = pygame.image.load(image_path)
    screenshot_rect = screenshot.get_rect()

    selection_color = (180, 180, 180)

    selection_initial_pos = None
    selection_end_pos = None

    stop_counter = 0
    max_counter = 2
    while True:
        for event in pygame.event.get():
            if event.type == pygame.WINDOWFOCUSLOST:
                sys.exit()
            if event.type == pygame.MOUSEBUTTONUP:
                selection_end_pos = pygame.mouse.get_pos()

            if event.type == pygame.MOUSEBUTTONDOWN:
                if not selection_initial_pos:
                    selection_initial_pos = pygame.mouse.get_pos()

        screen.fill(black)
        screen.blit(screenshot, screenshot_rect)
        if selection_initial_pos and not selection_end_pos:
            draw_rect_alpha(screen, selection_color, compute_region(
                selection_initial_pos, pygame.mouse.get_pos()))
        if selection_end_pos:
            stop_counter += 1
        if stop_counter >= max_counter:
            break
        pygame.display.flip()

    return compute_region(selection_initial_pos, selection_end_pos)


def select_region(image_path):
    return show_window(image_path)
