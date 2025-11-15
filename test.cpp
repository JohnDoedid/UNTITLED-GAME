#include <iostream>
#include <filesystem>
#include <fstream>
#include <regex>

namespace fs = std::filesystem;

void parseFile(const fs::path& filePath) {
    std::ifstream file(filePath);
    if (!file.is_open()) return;

    std::string line;
    std::regex classRegex(R"(\bclass\s+(\w+))");
    std::regex structRegex(R"(\bstruct\s+(\w+))");
    std::regex funcRegex(R"((?:[\w:<>\*&]+)\s+(\w+)\s*\([^\)]*\)\s*(?:const)?\s*;)");

    std::cout << "File: " << filePath << "\n";

    while (std::getline(file, line)) {
        std::smatch match;
        if (std::regex_search(line, match, classRegex)) {
            std::cout << "  Class: " << match[1] << "\n";
        } else if (std::regex_search(line, match, structRegex)) {
            std::cout << "  Struct: " << match[1] << "\n";
        } else if (std::regex_search(line, match, funcRegex)) {
            std::cout << "    Function: " << match[1] << "\n";
        }
    }
}

void walkSFML(const fs::path& path) {
    if (!fs::exists(path)) {
        std::cerr << "Path does not exist: " << path << "\n";
        return;
    }

    for (auto& p : fs::recursive_directory_iterator(path)) {
        if (p.is_regular_file() && 
            (p.path().extension() == ".hpp" || p.path().extension() == ".h")) {
            parseFile(p.path());
        }
    }
}

int main() {
    std::string sfmlPath = "/usr/include/CSFML"; // CHANGE THIS
    walkSFML(sfmlPath);
    return 0;
}
