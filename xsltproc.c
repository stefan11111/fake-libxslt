#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
    for (char **p = argv; *p; p++) {
        if (!strncmp(*p, "-V", sizeof("-V") - 1) || !strncmp(*p, "--version", sizeof("--version") - 1)) {
            printf("Using libxml 21208, libxslt 10139 and libexslt 821\n"
                   "xsltproc was compiled against libxml 21208, libxslt 10139 and libexslt 821\n"
                   "libxslt 10139 was compiled against libxml 21208\n"
                   "libexslt 821 was compiled against libxml 21208\n");
            return 0;
        }
    }

    for (char **p = argv; *p; p++) {
        if (!strncmp(*p, "-o", sizeof("-o") - 1) || !strncmp(*p, "--output", sizeof("--output") - 1)) {
            fopen(*p, "w");
            return 0;
        }
    }
    return 0;
}
