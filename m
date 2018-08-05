Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51534 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHEMq3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Aug 2018 08:46:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so10838092wma.1
        for <util-linux@vger.kernel.org>; Sun, 05 Aug 2018 03:42:20 -0700 (PDT)
Date: Sun, 5 Aug 2018 11:42:09 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
cc: "Dmitry V. Levin" <ldv@altlinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: use kernel crypto api
In-Reply-To: <20180804194655.GD4461@thunk.org>
Message-ID: <alpine.LNX.2.21.99.1808051124370.868@imuri>
References: <20180804191706.10641-1-kerolasa@iki.fi> <20180804194655.GD4461@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, 4 Aug 2018, Theodore Y. Ts'o wrote:

> On Sat, Aug 04, 2018 at 08:17:06PM +0100, Sami Kerola wrote:
> > Try to speed up md5 checksums by using hardware accelerators when they are
> > present with use of kernel crypto api.
> > 
> > Reference: http://www.chronox.de/libkcapi/html/ch01s02.html
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> 
> I'm not sure I see the point of this change.  Is there a use case you
> have in mind where people would be using crypto hash based UUID's
> where performance is a concern?  In in that case where someone was
> trying to create a huge number of crypto hash based UUID's, how much
> overhead is there in going through the kernel API if there is *not* a
> hardware accelerator present?
> 
> 						- Ted

Hi Dmitry & Ted,

I should have told in that commit message part of the motivation was to 
deprecate util-linux local md5 implementation. But since both of you 
raised concern about performance I decided to test kernel api and 
util-linux implementations as close the same way as they are used in 
libuuid.

Executive summary: kernel api is surprisingly slow.

The following test is using short input messages (1 to 64 bytes) to md5 
functions. I assume most uuid use is in this range. As you can see in perf 
print out the kernel api is about 10x slower. When inputs are up to 1024 
bytes slowdown is about x4. With 10 kilobyte chucks these are about as 
quick. Maybe I am wrong when thinking most uuid's tend to be based on 
small inputs, so the slow down is relevant.

Thank you both for pointing out the change smelled rats. I did not realize 
kernel api could be so expensive to use. That said I am no longer in 
favour of merging this change.

/*
$ dd if=/dev/urandom of=./test.in count=1 bs=10M
$ cat ./test.in >/dev/null # ensure page cache is warm

$ perf stat md5-test --kernel-api ./test.in

 Performance counter stats for 'md5-test --kernel-api ./test.in':

       2462.555389      task-clock:u (msec)       #    0.963 CPUs utilized
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
                56      page-faults:u             #    0.023 K/sec
       213,119,356      cycles:u                  #    0.087 GHz
        65,763,609      instructions:u            #    0.31  insn per cycle
        19,412,627      branches:u                #    7.883 M/sec
           131,530      branch-misses:u           #    0.68% of all branches

       2.557148339 seconds time elapsed

$ perf stat md5-test --util-linux ./test.in

 Performance counter stats for 'md5-test --util-linux ./test.in':

        225.212947      task-clock:u (msec)       #    0.998 CPUs utilized
                 0      context-switches:u        #    0.000 K/sec
                 0      cpu-migrations:u          #    0.000 K/sec
                57      page-faults:u             #    0.253 K/sec
       225,921,565      cycles:u                  #    1.003 GHz
       375,010,554      instructions:u            #    1.66  insn per cycle
        21,918,050      branches:u                #   97.321 M/sec
            48,356      branch-misses:u           #    0.22% of all branches

       0.225656336 seconds time elapsed
*/

#include <getopt.h>
#include <linux/if_alg.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

#include "c.h"
#include "closestream.h"
#include "nls.h"
#include "strutils.h"
#include "uuid.h"
#include "xalloc.h"
#include "md5.h"

struct run_state {
	unsigned int api;
	unsigned int seed;
	size_t max_read;
	int fd;
};

static void __attribute__((__noreturn__)) usage(void)
{
	fputs(USAGE_HEADER, stdout);
	printf(" %s [options] file\n", program_invocation_short_name);

	fputs(USAGE_SEPARATOR, stdout);
	puts("Compare util-linux md5 with kernel crypto api.");

	fputs(USAGE_OPTIONS, stdout);
	puts(" -u, --util-linux       use util-linux md5 implementation (default)");
	puts(" -k, --kernel-api       use kernel api");
	puts(" -s, --seed <number>    srand(seed) value (default: 42)");
	puts(" -m, --max <number>     maximum read chunk from file (default: 64)");
	fputs(USAGE_SEPARATOR, stdout);
	printf(USAGE_HELP_OPTIONS(24));
	printf(USAGE_MAN_TAIL("md5-test(1)"));
	exit(EXIT_SUCCESS);
}

static void kernel_api(uuid_t out, const uuid_t ns, char *buf, size_t sz)
{
	int tfmfd;
	struct sockaddr_alg sa = {
		.salg_family = AF_ALG,
		.salg_type = "hash",
		.salg_name = "md5"
	};
	int opfd = -1, fail = 0;
	struct iovec const iov[2] = {
		{.iov_base = (void *)ns, .iov_len = sizeof(uuid_t)},
		{.iov_base = (void *)buf, .iov_len = sz}
	};

	tfmfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
	if (bind(tfmfd, (struct sockaddr *)&sa, sizeof(sa)) < 0)
		fail = 1;
	if (!fail && (opfd = accept(tfmfd, NULL, 0)) < 0)
		fail = 1;
	if (!fail && writev(opfd, iov, 2) < 0)
		fail = 1;
	if (!fail && read(opfd, out, sizeof(uuid_t)) == -1)
		fail = 1;
	if (opfd != -1)
		close(opfd);
	close(tfmfd);
}

static void util_linux_md5(uuid_t out, const uuid_t ns, char *buf, size_t sz)
{
	UL_MD5_CTX ctx;
	char hash[UL_MD5LENGTH];

	ul_MD5Init(&ctx);
	/* hash concatenation of well-known UUID with name */
	ul_MD5Update(&ctx, ns, sizeof(uuid_t));
	ul_MD5Update(&ctx, (const unsigned char *)buf, sz);

	ul_MD5Final((unsigned char *)hash, &ctx);

	memcpy(out, hash, sizeof(uuid_t));
}

int main(int argc, char **argv)
{
	struct run_state rst = {
		.api = 0,
		.seed = 42,
		.max_read = 64,
		.fd = -1
	};
	static const struct option longopts[] = {
		{ "util-linux", no_argument,       NULL, 'u' },
		{ "kernel-api", no_argument,       NULL, 'k' },
		{ "seed",       required_argument, NULL, 's' },
		{ "max",        required_argument, NULL, 'm' },
		{ "version",    no_argument,       NULL, 'V' },
		{ "help",       no_argument,       NULL, 'h' },
		{ NULL, 0, NULL, 0 }
	};
	int c;
	char *buf;
	uuid_t out;
	uuid_t ns;

	atexit(close_stdout);

	while ((c = getopt_long(argc, argv, "uks:m:Vh", longopts, NULL)) != -1)
		switch (c) {
		case 'u':
			rst.api = 0;
			break;
		case 'k':
			rst.api = 1;
			break;
		case 's':
			rst.seed = strtou32_or_err(optarg, "failed to parse seed");
			break;
		case 'm':
			rst.max_read = strtou32_or_err(optarg, "failed to parse max chunk");
			if (rst.max_read == 0)
				err(EXIT_FAILURE, "max cannot be zero");
			break;
		case 'V':
			printf(UTIL_LINUX_VERSION);
			return EXIT_SUCCESS;
		case 'h':
			usage();
		default:
			errtryhelp(EXIT_FAILURE);
		}

	argc -= optind;
	argv += optind;
	if (0 < argc) {
		rst.fd = open(argv[0], O_RDONLY);
		if (rst.fd < 0)
			err(EXIT_FAILURE, "could not open: %s", argv[0]);
	} else
		errx(EXIT_FAILURE, "mandatory file argument missing");

	buf = xmalloc(rst.max_read);
	srand(rst.seed);

	while(1) {
		ssize_t sz;

		sz = (rand() % rst.max_read) + 1;
		if (read(rst.fd, buf, sz) != sz)
			break;
		if (rst.api)
			kernel_api(out, ns, buf, sz);
		else
			util_linux_md5(out, ns, buf, sz);
	}
	free(buf);
	close(rst.fd);
	return EXIT_SUCCESS;
}
