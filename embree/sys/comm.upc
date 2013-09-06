#include <upc.h>

#include <string.h>
#include <bupc_extern.h>

void UPC_Init(int argc, char** argv) {
    bupc_init(&argc, &argv);
}

int UPC_Exit() {
    int exitcode = 0;
    bupc_exit(exitcode);
    return exitcode;
}

int UPC_GetRank() {
    return MYTHREAD;
}

int UPC_GetSize() {
    return THREADS;
}

void UPC_CombineFramebuffers(float* data, int nBytes) {
    shared [0] float * remote_fb = upc_all_alloc(1, nBytes);

    for (int t = 1; t < THREADS; t++) {
        if (MYTHREAD == t)
            upc_memput( remote_fb, data, nBytes );

        upc_barrier; // ===================================

        if (MYTHREAD == 0)
            for (int i = 0; i < nBytes/sizeof(float); i++)
                data[i] += remote_fb[i];

        upc_barrier; // ===================================
    }
}