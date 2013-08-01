
extern "C" {
  #include <string.h>
  #include <bupc_extern.h>
}

namespace UPC {

void Init(int argc, char** argv) {
    bupc_init(&argc, &argv);
}

int Exit() {
    int exitcode = 0;
    bupc_exit(exitcode);
    return exitcode;
}

int GetRank() {
    return bupc_extern_mythread();
}

int GetSize() {
    return bupc_extern_threads();
}

}
