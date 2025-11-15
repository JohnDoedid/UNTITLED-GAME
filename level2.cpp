#include <SFML/Graphics.hpp>
#include <SFML/Window.hpp>
#include <SFML/System.hpp>

extern "C" {
#include <luajit-2.1/lua.h>
#include <luajit-2.1/lauxlib.h>
#include <luajit-2.1/lualib.h>
}

#include <string>
#include <iostream>

int main() {
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);

    // Load level2.lua
    if (luaL_dofile(L, "level2.lua")) {
        std::cerr << "Error loading Lua: " << lua_tostring(L, -1) << "\n";
        return 1;
    }

    sf::RenderWindow window(sf::VideoMode({640, 480}), "Level2: Craft Armor");

    sf::Font font;
    if (!font.loadFromFile("VCR_MONO.ttf")) {
        printf("Failed to load font!\n");
        return 1;
    }

    sf::Text topBar("Level 2: Craft full Netherite Armor", font, 18);
    topBar.setPosition({5.f, 5.f});

    sf::Text bottomBar("", font, 16);
    bottomBar.setPosition({5.f, 460.f});

    sf::CircleShape playerShape(10.f);
    playerShape.setFillColor(sf::Color::Cyan);
    playerShape.setOrigin({10.f, 10.f});
    sf::Vector2f playerPos{320.f, 240.f};
    float speed = 4.f;

    bool won = false;

    while (window.isOpen() && !won) {
        sf::Event e;
        while (window.pollEvent(e)) {
            if (e.type == sf::Event::Closed) window.close();
        }

        // Movement
        sf::Vector2f move{0.f, 0.f};
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::W)) move.y -= speed;
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::S)) move.y += speed;
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::A)) move.x -= speed;
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::D)) move.x += speed;
        playerPos += move;
        playerShape.setPosition(playerPos);

        // Player actions
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::C)) lua_getglobal(L, "chopTree"), lua_pcall(L,0,0,0);
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::M)) lua_getglobal(L, "mineNetherite"), lua_pushinteger(L, 3), lua_pcall(L,1,0,0);
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::F)) {
            lua_getglobal(L, "craft");
            lua_pushstring(L, "helmet");  // Example: always crafts helmet
            lua_pcall(L,1,0,0);
        }

        // Update Lua per frame
        lua_getglobal(L, "update");
        if (lua_isfunction(L, -1)) lua_pcall(L, 0, 0, 0);

        // Get GUI message from Lua
        lua_getglobal(L, "gui");
        if (lua_istable(L, -1)) {
            lua_getfield(L, -1, "message");
            if (lua_isstring(L, -1)) bottomBar.setString(lua_tostring(L, -1));
            lua_pop(L, 1);
        }
        lua_pop(L, 1); // pop gui table

        // Check win
        lua_getglobal(L, "won");
        if (lua_isboolean(L, -1)) won = lua_toboolean(L, -1);
        lua_pop(L, 1);

        window.clear(sf::Color::Black);
        window.draw(topBar);
        window.draw(playerShape);
        window.draw(bottomBar);
        window.display();
    }

    window.close();
    lua_close(L);
    return 0;
}
    lua_pushboolean(L, won);
    lua_setglobal(L, "won");
    lua_close(L);
    return 0;
}
