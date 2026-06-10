#include <raylib.h>

int main() {
  const int screen_width = 64;
  const int screen_height = 32;

  const int scale = 10;
  const int screen_scale_width = screen_width * scale;
  const int screen_scale_height = screen_height * scale;

  InitWindow(screen_scale_width, screen_scale_height, "CHIP-8 Emulator");
  SetTargetFPS(120);

  int sprite_x = 32;
  int sprite_y = 16;
  int sprite_width = 1;
  int sprite_height = 1;

  while (!WindowShouldClose()) {
    BeginDrawing();
    ClearBackground(BLACK);
    DrawText("CHIP-8 Window", 220, 200, 20, RAYWHITE);

    DrawRectangle(sprite_x * scale, sprite_y * scale, sprite_width * scale,
                  sprite_height * scale, WHITE);

    EndDrawing();
  }

  CloseWindow();
  return 0;
}
