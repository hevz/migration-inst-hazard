#define _GNU_SOURCE
#include <stdio.h>
#include <sched.h>
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/mman.h>
#include <sys/types.h>

extern char template_s;
extern char template_e;

static void *
thread_handler (void *data)
{
    pid_t pid;
    int cpu = 0;

    pid = getpid ();

    for (;;) {
        cpu_set_t set;

        CPU_ZERO (&set);
        CPU_SET (cpu % 4, &set);
        assert (sched_setaffinity (pid, sizeof (set), &set) == 0);
        cpu++;

        usleep (1000);
    }

    return NULL;
}

int
main (int argc, char *argv[])
{
    void *ptr;
    void (*test) (void);
    pthread_t thread;

    ptr = mmap (NULL, 16384, PROT_READ | PROT_WRITE | PROT_EXEC,
                MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    assert (ptr != MAP_FAILED);

    test = ptr;
    memcpy (ptr, &template_s, &template_e - &template_s);
    asm volatile("ibar 0" ::: "memory");

    assert (pthread_create (&thread, NULL, thread_handler, NULL) == 0);

    test ();

    return 0;
}
