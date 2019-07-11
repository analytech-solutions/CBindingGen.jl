#ifndef TEST_H


typedef void T1;
typedef T1 T2;

typedef char T3;
typedef short T4;
typedef int T5;
typedef long T6;
typedef long long T7;

typedef signed char T8;
typedef signed short T9;
typedef signed int T10;
typedef signed long T11;
typedef signed long long T12;

typedef unsigned char T13;
typedef unsigned short T14;
typedef unsigned int T15;
typedef unsigned long T16;
typedef unsigned long long T17;

typedef float T18;
typedef double T19;
typedef long double T20;

typedef float _Complex T21;
typedef double _Complex T22;
typedef long double _Complex T23;


enum E1 {
	E1_1,
	E1_2,
	E1_3
};

enum E2 {
	E2_1 = 1,
	E2_2 = E2_1,
	E2_3 = E2_1+10,
	E2_4 = 0x0u,
	E2_5 = 0xffffffffull,
	E2_6 = 0xffffffffffffull
};


struct S1 {
};

struct S2 {
	int i;
};

struct S3 {
	struct S1 s;
};

struct S4 {
	struct {
		int i;
		struct S3 s;
	};
};

struct S5 {
	struct {
		int i;
		struct S3 s;
	} s;
};

struct S6 {
	struct S7 {
		int i;
		struct S3 s;
	} s, s1;
	int i;
	struct S7 s2;
};

struct S8 {
	struct S7 s;
};

struct S9 {
	struct {
		int i;
	} s1, s2;
};

struct S10 {
	struct S11 {
		int i;
	};
};

struct S12 {
	struct {
		int i;
	} s1, *s2, **s3, ***s4;
};

struct S13 {
	struct {
		int i;
	} *s;
};

struct S14 {
	struct {
		int i;
	} s1, *s2, s3[2], s4[5][2], *s5[5][2], *s6[][2];
};

struct S15 {
	struct {
		int i;
	} s[2];
};

struct S16 {
	int i:3;
	unsigned int u:10;
};

struct S17 {
	char c;
	int i;
};

struct S18 {
	char c;
	int i;
} __attribute__((__packed__));

struct S19 {
	struct {
		char c;
	} __attribute__((__packed__));
	struct {
		int i;
	} __attribute__((__packed__));
};

struct S20 {
	struct {
		char c;
	};
	struct {
		int i;
	};
} __attribute__((__packed__));

struct S21 {
	void (*f)(void);
};

struct S22 {
	int (*(*f)(struct S21 *x, int i))(int, float);
};

struct S23 {
	int (*f)(char const *, ...);
};

struct S24;
struct _S24;

struct S25 {
	struct S24 *s1;
	struct _S24 *s2;
	struct S25 *s3;
};

struct S24 {
	struct S24 *s1;
	struct _S24 *s2;
	struct S25 s3;
};

struct S26 {
	enum E3 {
		E3_1
	} e1, *e2;
	enum E3 e3;
	enum E1 e4, *e5;
};

typedef struct S27_ {
	int i;
} S27;

typedef struct {
	int i;
} S28;

typedef enum E4_ {
	E4_1,
} E4;

typedef enum {
	E5_1,
} E5;

typedef int T24[2];
typedef int T25[5][2];
typedef struct {
	int i;
} T26[3];


struct S29;
typedef struct S29 S29_;
typedef struct S29 * S29_ptr;
struct S29 {
	S29_ *s1;
	S29_ptr s2;
};

struct S30;
typedef void (*F1)(struct S30 s);
struct S30 {
	F1 f;
};

struct _S31;
typedef struct _S31 S31;
struct S32 {
	S31 *s;
};


extern int const g1;
extern struct S24 const g2;
extern struct S24 * const g3;

extern int g4;
extern struct S24 g5;
extern struct S24 *g6;

static int const g7 = 0;


void f1(void);
extern void f2(void);
int f3(void);
void f4(int i);
int f5(int i, ...);
void f6(char const *p);
void f7(int i1, int i2, int, int, int i5);
void f8(int i1, int, int _2);
void f9(int (*arg)(int, int));
int (*f10(void))(int, int);


#endif
