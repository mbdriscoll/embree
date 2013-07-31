#ifdef _EMBREE_SYS_DIST_H_
#define _EMBREE_SYS_DIST_H_

void Init(int argc, char** argv);
int Exit();

int GetRank();
int GetSize();

#endif // _EMBREE_SYS_DIST_H_
