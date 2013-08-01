#ifndef _EMBREE_SYS_UPC_H
#define _EMBREE_SYS_UPC_H_

namespace UPC {

void Init(int argc, char** argv);
int Exit();

int GetRank();
int GetSize();

} // namespace UPC

#endif // include _EMBREE_SYS_UPC_H_
