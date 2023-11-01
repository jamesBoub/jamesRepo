#include <SDL2/SDL.h>
#include <stdio.h>

const int SCREEN_WIDTH = 800;
const int SCREEN_HEIGHT = 600;

// Window being rendered to
SDL_Window* gWindow = NULL;

// Surface contained by the window
SDL_Surface* gScreenSurface = NULL;

// Image to be loaded onto the screen
SDL_Surface* gHelloWorld = NULL;

// loads SDL
bool init()
{
    bool success = true;

    if (SDL_Init(SDL_INIT_VIDEO) < 0)
    {
        printf("SDL could not initialize! SDL_Error: %s\n", SDL_GetError());
        success = false;
    }
    else
    {
        gWindow = SDL_CreateWindow("SDL Tutorial", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
        if(gWindow == NULL)
        {
            printf("Window could not be created! SDL_Error: %s\n", SDL_GetError());
            success = false;
        }
        else
        {
            gScreenSurface = SDL_GetWindowSurface(gWindow);
        }
    }
    return success;
}
// loads stuff
bool loadMedia()
{
    bool success = true;

    gHelloWorld = SDL_LoadBMP("images/image.bmp");
    if (gHelloWorld == NULL)
    {
        printf("Unable to load image %s! SDL Error %s\n", "images/image.bmp", SDL_GetError());
        success = false;
    }
    return success;
}

// shuts down SDL
void close()
{
SDL_FreeSurface(gHelloWorld);
gHelloWorld = NULL;

SDL_DestroyWindow(gWindow);
gWindow = NULL;

SDL_Quit();
}

int main(int argc, char* args[])
{
    if(!init())
    {
        printf("Failed to initialize!\n");
    }
    else
    {
        if(!loadMedia())
        {
            printf("Failed to load media!\n");
        }
        else
        {
            SDL_BlitSurface(gHelloWorld, NULL, gScreenSurface, NULL);
            SDL_UpdateWindowSurface(gWindow);
            SDL_Event e; bool quit = false; while( quit == false ){ while( SDL_PollEvent( &e ) ){ if( e.type == SDL_QUIT ) quit = true; } }
        }
    }
    close();
    return 0;
}
