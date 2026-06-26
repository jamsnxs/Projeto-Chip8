#include <raylib.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))
int main() {
  InitWindow(640, 320, "CHIP-8 Emulator");
  SetWindowState(FLAG_WINDOW_RESIZABLE);

  int scale = MIN(GetScreenWidth() / 64, GetScreenHeight() / 32);
  int offsetX = (GetScreenWidth() - (64 * scale)) / 2;
  int offsetY = (GetScreenHeight() - (32 * scale)) / 2;
  SetTargetFPS(60);

  bool tela[32][64] = {0};
  int x = 32, y = 16;

  while (!WindowShouldClose()) {
    if (IsWindowResized()) {
      scale = MIN(GetScreenWidth() / 64, GetScreenHeight() / 32);
      offsetX = (GetScreenWidth() - (64 * scale)) / 2;
      offsetY = (GetScreenHeight() - (32 * scale)) / 2;
    }

    BeginDrawing();
    ClearBackground(BLACK);
    if (IsKeyDown(KEY_S) && y < 31) {
      tela[y][x] = 0;
      y += 1;
    }

    tela[y][x] = 1;

    for (int y = 0; y < 32; y++) {
      for (int x = 0; x < 64; x++) {
        if (tela[y][x]) {
          DrawRectangle(offsetX + (x * scale), offsetY + (y * scale), scale,
                        scale, RAYWHITE);
        }
      }
    }

    EndDrawing();
  }

  CloseWindow();
  return 0;
}
