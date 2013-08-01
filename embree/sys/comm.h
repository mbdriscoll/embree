#ifndef _EMBREE_SYS_COMM_H_
#define _EMBREE_SYS_COMM_H_

extern "C" {

void UPC_Init(int argc, char** argv);
int UPC_Exit();

int UPC_GetRank();
int UPC_GetSize();

void UPC_CombineFramebuffers(float* fb, int nBytes);

} // extern C

#endif // include _EMBREE_SYS_COMM_H_
