#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <map>
#include <stack>
#include <regex>
#include <cmath>
#include <functional>
#include <algorithm>

using namespace std;

/*
========================================================
  LUA VALUE (for numbers, strings, booleans, tables, functions)
========================================================
*/
struct LuaValue {
    enum Type { NIL, NUMBER, STRING, BOOLEAN, TABLE, FUNCTION } type;

    double numberValue;
    string stringValue;
    bool boolValue;
    map<LuaValue, LuaValue> tableValue;
    LuaValue(*func)(vector<LuaValue>) = nullptr;

    LuaValue() : type(NIL) {}
    LuaValue(double v) : type(NUMBER), numberValue(v) {}
    LuaValue(const string& v) : type(STRING), stringValue(v) {}
    LuaValue(bool v) : type(BOOLEAN), boolValue(v) {}
    LuaValue(LuaValue(*f)(vector<LuaValue>)) : type(FUNCTION), func(f) {}

    string toString() const {
        switch(type){
            case NIL: return "nil";
            case NUMBER: return to_string(numberValue);
            case STRING: return "\""+stringValue+"\"";
            case BOOLEAN: return boolValue?"true":"false";
            case TABLE: return "[table]";
            case FUNCTION: return "[function]";
        }
        return "nil";
    }

    bool operator<(const LuaValue& rhs) const {
        if(type==NUMBER && rhs.type==NUMBER) return numberValue<rhs.numberValue;
        return stringValue<rhs.stringValue;
    }
};

/*
========================================================
  STRING UTILITIES
========================================================
*/
string trim(const string& s){
    size_t start=s.find_first_not_of(" \t\n\r");
    size_t end=s.find_last_not_of(" \t\n\r");
    if(start==string::npos) return "";
    return s.substr(start,end-start+1);
}

bool startsWith(const string& s,const string& prefix){
    return s.rfind(prefix,0)==0;
}

string replaceAll(string str,const string& from,const string& to){
    size_t pos=0;
    while((pos=str.find(from,pos))!=string::npos){
        str.replace(pos,from.length(),to);
        pos+=to.length();
    }
    return str;
}

/*
========================================================
  LUA BUILTIN FUNCTION MAPPING
========================================================
*/
map<string,string> luaBuiltins={
    {"math.sin","sin"}, {"math.cos","cos"}, {"math.tan","tan"}, {"math.sqrt","sqrt"}, {"math.abs","abs"},
    {"math.log","log"}, {"math.exp","exp"}, {"math.floor","floor"}, {"math.ceil","ceil"},
    {"string.upper","[](const string &s){string r=s;transform(r.begin(),r.end(),r.begin(),::toupper);return r;}"},
    {"string.lower","[](const string &s){string r=s;transform(r.begin(),r.end(),r.begin(),::tolower);return r;}"},
    {"table.insert","[](map<LuaValue,LuaValue> &t,const LuaValue &k,const LuaValue &v){t[k]=v;}"},
    {"table.remove","[](map<LuaValue,LuaValue> &t,const LuaValue &k){t.erase(k);}"},
    {"io.write","[](const string &s){cout<<s;}"},
    {"io.read","[](string &s){cin>>s;}"}
    // Add remaining Lua standard library functions here
};

/*
========================================================
  LUA → C++ TRANSPILER
========================================================
*/
class LuaToCppTranspiler {
private:
    vector<string> output;
    int indent=0;
    stack<string> blockStack;
    map<string,string> labels;

    void emit(const string &line){
        output.push_back(string(indent*4,' ')+line);
    }

    void increaseIndent(){ indent++; }
    void decreaseIndent(){ if(indent>0) indent--; }

    string mapBuiltins(const string &expr){
        string result=expr;
        for(auto &kv: luaBuiltins) result=replaceAll(result,kv.first,kv.second);
        return result;
    }

public:
    void translateLine(string line){
        line=trim(line);
        if(line.empty()) return;

        // comments
        if(startsWith(line,"--")){ emit("// "+line.substr(2)); return; }

        // labels ::label::
        if(line.size()>4 && line[0]==':' && line[1]==':' && line[line.size()-2]==':' && line[line.size()-1]==':'){
            string label=line.substr(2,line.size()-4);
            labels[label]=label;
            emit(label+":;");
            return;
        }

        // goto
        if(startsWith(line,"goto ")){ emit("goto "+line.substr(5)+";"); return; }

        // print
        if(startsWith(line,"print(")){
            string inside=line.substr(6,line.size()-7);
            inside=mapBuiltins(inside);
            emit("std::cout << "+inside+" << std::endl;");
            return;
        }

        // local variable
        if(startsWith(line,"local ")){ emit("LuaValue "+line.substr(6)+";"); return; }

        // if / elseif / else / end
        if(startsWith(line,"if ")){
            string cond=replaceAll(line.substr(3),"then","");
            cond=mapBuiltins(cond);
            emit("if("+cond+"){");
            blockStack.push("if");
            increaseIndent();
            return;
        }
        if(startsWith(line,"elseif ")){
            decreaseIndent();
            string cond=replaceAll(line.substr(7),"then","");
            cond=mapBuiltins(cond);
            emit("} else if("+cond+"){");
            increaseIndent();
            return;
        }
        if(line=="else"){ decreaseIndent(); emit("} else {"); increaseIndent(); return; }
        if(line=="end"){ if(!blockStack.empty()) blockStack.pop(); decreaseIndent(); emit("}"); return; }

        // loops
        if(startsWith(line,"while ")){ string cond=replaceAll(line.substr(6),"do",""); cond=mapBuiltins(cond); emit("while("+cond+"){"); blockStack.push("while"); increaseIndent(); return; }
        if(startsWith(line,"repeat")){ emit("do{"); blockStack.push("repeat"); increaseIndent(); return; }
        if(startsWith(line,"until ")){ decreaseIndent(); string cond=line.substr(6); cond=mapBuiltins(cond); emit("} while(!("+cond+"));"); if(!blockStack.empty()) blockStack.pop(); return; }

        // numeric for
        if(startsWith(line,"for ")){
            regex r("for (\\w+) = ([^,]+), ([^,]+)(?:, ([^\\s]+))?");
            smatch m;
            if(regex_search(line,m,r)){
                string start=m[2].str(), end=m[3].str();
                string step=m[4].matched?m[4].str():"1";
                emit("for(int "+m[1].str()+"="+start+"; "+m[1].str()+"<="+end+"; "+m[1].str()+"+="+step+"){");
                blockStack.push("for"); increaseIndent(); return;
            }
        }

        // function
        if(startsWith(line,"function ")){
            string name=line.substr(9);
            name=mapBuiltins(name);
            emit("LuaValue "+name+"{"); blockStack.push("function"); increaseIndent(); return;
        }

        // return / break
        if(startsWith(line,"return ")){ string ret=mapBuiltins(line.substr(7)); emit("return "+ret+";"); return; }
        if(line=="break"){ emit("break;"); return; }

        // logical operators
        line=replaceAll(line," and "," && ");
        line=replaceAll(line," or "," || ");
        line=replaceAll(line," not "," !");

        // fallback
        line=mapBuiltins(line);
        emit(line+";");
    }

    string transpile(const string &luaCode){
        emit("#include <iostream>");
        emit("#include <map>");
        emit("#include <string>");
        emit("#include <vector>");
        emit("#include <cmath>");
        emit("#include <functional>");
        emit("");
        emit("int main(){");
        increaseIndent();
        stringstream ss(luaCode);
        string line;
        while(getline(ss,line)) translateLine(line);
        emit("return 0;");
        decreaseIndent();
        emit("}");
        string result;
        for(auto &l:output) result+=l+"\n";
        return result;
    }
};

/*
========================================================
  ENTRY POINT
========================================================
*/
int main(int argc,char* argv[]){
    if(argc<2){ cout<<"Usage: transgender <input.lua>\n"; return 1; }
    ifstream file(argv[1]);
    std::string luafilenameqq = argv[1];  // argv[1] is a C-style string (char*)
    if(!file.is_open()){ cout<<"Failed to open Lua file\n"; return 1; }
    stringstream buffer; buffer<<file.rdbuf();
    string luaCode=buffer.str();

    LuaToCppTranspiler transpiler;
    string cppCode=transpiler.transpile(luaCode);

    ofstream out(luafilenameqq + ".cpp"); out<<cppCode; out.close();
    cout<<"Lua successfully transpiled to output.cpp\n";
    return 0;
}
