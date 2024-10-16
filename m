Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CF38DC7
	for <util-linux@vger.kernel.org>; Wed, 16 Oct 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112432; cv=none; b=Z1r4ODs8Oaddu1d+wt3jFbiDeajQtPNXL/MZRKmFyOHUtFJt7gSnqmONakSiy69vtmrHhP7UG9h56yJElaUOQ+aDk7kROW7FveggoDAmRWD+EF/zQgDM3CgFhI5ZQmjjqYGjK7lCUVqLACxHfuu1urgKpvxZmPeJFW49fBn39eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112432; c=relaxed/simple;
	bh=UM6vyXuOz9cZh9hWYfWoDnje7jRkH6toslUBam/82O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9J/4oeeeG6c3DVGXksuGgsPWLgnjwJ6eShRIqND/+VcChpRYE+2u2yNhC/NmoaXzHptWcsrgMITwveK5RDpiBfN7qmEUDCHXaFZuVR0GNF85YCamXHHh0bYsxgHeP7MZ6cr8a3TYMHO+fPz31uKox3IG3Ry+lILLFAaPqn2Oqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=BzKZeSZ5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="BzKZeSZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1729112418; bh=UM6vyXuOz9cZh9hWYfWoDnje7jRkH6toslUBam/82O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzKZeSZ5X/Ty2ZzstqwS0KFJzOag/yYtjLnvJtvVwGJ7fzvDWNaNVqVFGLtoDlVTw
	 Kf0T2mn3oFPOuHfSe3EprRZCfsT7Q5snG08vPe7RLcEVQFpEP6gLcuPrLkpMJl1rrC
	 CbQtI4gwejMLLRbNv/JB2bWmR7kDqBT5oqCqSgMY=
Date: Wed, 16 Oct 2024 23:00:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Robin Jarry <robin@jarry.cc>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC PATCH util-linux] text-utils: add bits command
Message-ID: <0792f071-786b-4cb2-9733-2b10c98c20f2@t-8ch.de>
References: <20241016202621.2124554-2-robin@jarry.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016202621.2124554-2-robin@jarry.cc>

On 2024-10-16 22:26:22+0200, Robin Jarry wrote:
> Add a new test utility to convert between bit masks in various formats.

"test" or "text" utility?

> This can be handy to avoid parsing affinity masks in one's head and/or
> to interact with the kernel in a more human friendly way.
> 
> This is a rewrite in C of the bits command from my linux-tools python
> package so that it can be more widely available.
> 
> Here is an example:
> 
>  ~# cat /sys/kernel/debug/tracing/tracing_cpumask
>  fffffff,ffffffff,ffffffff,ffffffff
>  ~# bits -l ,$(cat /sys/kernel/debug/tracing/tracing_cpumask)
>  0-128
>  ~# bits -g 58,59,120,123
>  9000000,00000000,0c000000,00000000
>  ~# bits -g 58,59 > /sys/kernel/debug/tracing/tracing_cpumask
>  ~# echo 1 > /sys/kernel/debug/tracing/tracing_on
> 
> Add man page and basic tests.
> 
> Link: https://git.sr.ht/~rjarry/linux-tools#bits
> Signed-off-by: Robin Jarry <robin@jarry.cc>
> ---
>  bash-completion/bits                  |  21 ++
>  meson.build                           |  11 ++
>  tests/commands.sh                     |   1 +
>  tests/expected/misc/bits              |   0
>  tests/expected/misc/bits-and          |   1 +
>  tests/expected/misc/bits-binary       |   1 +
>  tests/expected/misc/bits-default      |   1 +
>  tests/expected/misc/bits-grouped-mask |   1 +
>  tests/expected/misc/bits-list         |   1 +
>  tests/expected/misc/bits-mask         |   1 +
>  tests/expected/misc/bits-not          |   1 +
>  tests/expected/misc/bits-or           |   1 +
>  tests/expected/misc/bits-overflow     |   1 +
>  tests/expected/misc/bits-parse-mask   |   1 +
>  tests/expected/misc/bits-parse-range  |   1 +
>  tests/expected/misc/bits-stdin        |   1 +
>  tests/expected/misc/bits-xor          |   1 +
>  tests/ts/misc/bits                    |  82 ++++++++
>  text-utils/Makemodule.am              |   6 +
>  text-utils/bits.1.adoc                | 147 ++++++++++++++
>  text-utils/bits.c                     | 265 ++++++++++++++++++++++++++
>  text-utils/meson.build                |   4 +
>  22 files changed, 550 insertions(+)
>  create mode 100644 bash-completion/bits
>  create mode 100644 tests/expected/misc/bits
>  create mode 100644 tests/expected/misc/bits-and
>  create mode 100644 tests/expected/misc/bits-binary
>  create mode 100644 tests/expected/misc/bits-default
>  create mode 100644 tests/expected/misc/bits-grouped-mask
>  create mode 100644 tests/expected/misc/bits-list
>  create mode 100644 tests/expected/misc/bits-mask
>  create mode 100644 tests/expected/misc/bits-not
>  create mode 100644 tests/expected/misc/bits-or
>  create mode 100644 tests/expected/misc/bits-overflow
>  create mode 100644 tests/expected/misc/bits-parse-mask
>  create mode 100644 tests/expected/misc/bits-parse-range
>  create mode 100644 tests/expected/misc/bits-stdin
>  create mode 100644 tests/expected/misc/bits-xor
>  create mode 100755 tests/ts/misc/bits
>  create mode 100644 text-utils/bits.1.adoc
>  create mode 100644 text-utils/bits.c

...

> +++ b/tests/ts/misc/bits
> @@ -0,0 +1,82 @@
> +#!/bin/bash
> +
> +#
> +# Copyright (c) 2024 Robin Jarry
> +#
> +# This file is part of util-linux.
> +#
> +# This file is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This file is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.

New files should use SPDX tags.

> diff --git a/text-utils/bits.c b/text-utils/bits.c
> new file mode 100644
> index 000000000000..6dd0db81a5de
> --- /dev/null
> +++ b/text-utils/bits.c
> @@ -0,0 +1,265 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Copyright (c) 2024 Robin Jarry
> + *
> + * bits - convert bit masks from/to various formats
> + */
> +
> +#include <errno.h>
> +#include <getopt.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include "c.h"
> +#include "closestream.h"
> +#include "cpuset.h"
> +#include "nls.h"
> +#include "strutils.h"
> +#include "strv.h"
> +
> +typedef enum {
> +	OP_OR,
> +	OP_AND,
> +	OP_NOT,
> +	OP_XOR,
> +} bitvise_op_t;

"bitwise"?
Also avoid using the _t suffix as it's reserved.
"enum bitwise_op" seems clear enough.

> +
> +static int parse_mask_or_list(const char *cmdline_arg, cpu_set_t *all_bits)
> +{
> +	bitvise_op_t op = OP_OR;
> +	cpu_set_t bits, copy;

This seems very geared towards cpu masks.
What happens if a user wants to use it with very large non-CPU bitmasks,
as the tool is advertised as a generic utility?

Call the utility "cpumask"?

> +	char buf[BUFSIZ];

Only use BUFSIZ in cases where the actual value does not matter,
for example loops.
On musl BUFSIZ == 1024 and this could not be enough fairly soon.

> +	char *arg = buf;
> +
> +	/* copy to allow modifying the argument contents */
> +	strlcpy(buf, cmdline_arg, sizeof(buf));
> +	buf[sizeof(buf) - 1] = '\0';

You can just use xstrdup().

> +
> +	/* strip optional operator first */
> +	if (startswith(arg, "&")) {
> +		op = OP_AND;
> +		arg++;
> +	} else if (startswith(arg, "^")) {
> +		op = OP_XOR;
> +		arg++;
> +	} else if (startswith(arg, "~")) {
> +		op = OP_NOT;
> +		arg++;
> +	} else if (startswith(arg, "|")) {
> +		op = OP_OR;
> +		arg++;
> +	}

The whole op enum could also be replaced by the actual character,
this is all in a single function.

op = '&';

...

switch (op) {
case '&':
}

> +
> +	if (startswith(arg, ",") || startswith(arg, "0x")) {
> +		if (cpumask_parse(arg, &bits, sizeof(bits)) < 0)
> +			return -EINVAL;

As this is a commandline tool you can call errx() here to kill the
process and provide better error information.
It would also make the call sequence slightly more simple.

> +	} else {
> +		if (cpulist_parse(arg, &bits, sizeof(bits), 1) < 0)
> +			return -EINVAL;
> +	}
> +
> +	switch (op) {
> +	case OP_AND:
> +		copy = *all_bits;
> +		CPU_AND(all_bits, &copy, &bits);
> +		break;
> +	case OP_OR:
> +		copy = *all_bits;
> +		CPU_OR(all_bits, &copy, &bits);
> +		break;
> +	case OP_XOR:
> +		copy = *all_bits;
> +		CPU_XOR(all_bits, &copy, &bits);
> +		break;
> +	case OP_NOT:
> +		for (int i = 0; i < CPU_SETSIZE; i++) {
> +			if (CPU_ISSET(i, &bits))
> +				CPU_CLR(i, all_bits);
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +typedef enum {
> +	MODE_BINARY,
> +	MODE_GROUPED_MASK,
> +	MODE_LIST,
> +	MODE_MASK,
> +} output_mode_t;
> +
> +static void print_bits(cpu_set_t *bits, output_mode_t mode)
> +{
> +	bool started = false;
> +	char buf[BUFSIZ];
> +	ssize_t n = 0;
> +
> +	buf[0] = '\0';

Is this necessary?

> +
> +	switch (mode) {
> +	case MODE_MASK:
> +		cpumask_create(buf, sizeof(buf), bits, sizeof(*bits));
> +
> +		/* strip leading zeroes */
> +		while (buf[n] == '0')
> +			n++;
> +		if (buf[n] == '\0')
> +			printf("0x0\n");
> +		else
> +			printf("0x%s\n", buf + n);
> +		break;
> +
> +	case MODE_GROUPED_MASK:
> +		cpumask_create(buf, sizeof(buf), bits, sizeof(*bits));
> +
> +		/* strip leading zeroes */
> +		while (buf[n] == '0')
> +			n++;
> +
> +		while (buf[n] != '\0') {
> +			if (started && (n % 8) == 0)
> +				printf(",");
> +			if (buf[n] != '0')
> +				started = true;
> +			printf("%c", buf[n]);
> +			n++;
> +		}
> +		printf("\n");
> +		break;
> +
> +	case MODE_BINARY:
> +		printf("0b");
> +		for (n = CPU_SETSIZE; n >= 0; n--) {
> +			if (started && ((n + 1) % 4) == 0)
> +				printf("_");
> +			if (CPU_ISSET(n, bits)) {
> +				started = true;
> +				printf("1");
> +			} else if (started) {
> +				printf("0");
> +			}
> +		}
> +		printf("\n");
> +		break;
> +
> +	case MODE_LIST:
> +		cpulist_create(buf, sizeof(buf), bits, sizeof(*bits));

This could use the return values of cpulist_create() and
cpumask_create().

> +		printf("%s\n", buf);
> +		break;
> +	}
> +
> +}
> +
> +static void __attribute__((__noreturn__)) usage(void)
> +{
> +	fputs(USAGE_HEADER, stdout);
> +	fprintf(stdout, _(" %s [options] [<mask_or_list>...]\n"), program_invocation_short_name);
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	fputsln(_("Convert bit masks from/to various formats."), stdout);
> +
> +	fputs(USAGE_ARGUMENTS, stdout);
> +	fputsln(_(" <mask_or_list>      A set of bits specified as a hex mask value (e.g. 0xeec2)\n"
> +		"                     or as a comma-separated list of bit IDs.\n"
> +		"                     If not specified, arguments will be read from stdin."), stdout);
> +
> +	fputs(USAGE_OPTIONS, stdout);
> +	fprintf(stdout, USAGE_HELP_OPTIONS(21));
> +
> +	fputs(_("\nMode:\n"), stdout);
> +	fputsln(_(" -m, --mask          Print the combined args as a hex mask value (default).\n"), stdout);
> +	fputsln(_(" -g, --grouped-mask  Print the combined args as a hex mask value in 32bit\n"
> +			"                     comma separated groups."), stdout);
> +	fputsln(_(" -b, --binary        Print the combined args as a binary mask value."), stdout);
> +	fputsln(_(" -l, --list          Print the combined args as a compressed list of bit IDs."), stdout);
> +
> +	fputs(USAGE_SEPARATOR, stdout);
> +	fprintf(stdout, USAGE_MAN_TAIL("bits(1)"));
> +	exit(EXIT_SUCCESS);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	output_mode_t mode = MODE_MASK;
> +	char **stdin_lines = NULL;
> +	cpu_set_t bits;
> +	int c;
> +
> +	static const struct option longopts[] = {
> +		{ "version",      no_argument, NULL, 'V'},
> +		{ "help",         no_argument, NULL, 'h'},
> +		{ "mask",         no_argument, NULL, 'm'},
> +		{ "grouped-mask", no_argument, NULL, 'g'},
> +		{ "binary",       no_argument, NULL, 'b'},
> +		{ "list",         no_argument, NULL, 'l'},
> +		{ NULL, 0, NULL, 0 }
> +	};
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +	close_stdout_atexit();
> +
> +	while ((c = getopt_long(argc, argv, "Vhmgbl", longopts, NULL)) != -1)
> +		switch (c) {
> +		case 'm':
> +			mode = MODE_MASK;
> +			break;
> +		case 'g':
> +			mode = MODE_GROUPED_MASK;
> +			break;
> +		case 'b':
> +			mode = MODE_BINARY;
> +			break;
> +		case 'l':
> +			mode = MODE_LIST;
> +			break;
> +		case 'V':
> +			print_version(EXIT_SUCCESS);
> +		case 'h':
> +			usage();
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +
> +	argc -= optind;
> +	argv += optind;
> +	if (argc == 0) {
> +		/* no arguments provided, read lines from stdin */
> +		char buf[BUFSIZ];
> +
> +		while (fgets(buf, sizeof(buf), stdin)) {
> +			/* strip LF, CR, CRLF, LFCR */
> +			buf[strcspn(buf, "\r\n")] = '\0';

rtrim_whitespace()?

> +			strv_push(&stdin_lines, strdup(buf));
> +		}
> +
> +		argc = strv_length(stdin_lines);
> +		argv = stdin_lines;
> +	}
> +
> +	CPU_ZERO(&bits);
> +
> +	for (; argc > 0; argc--, argv++)
> +		if (parse_mask_or_list(*argv, &bits) < 0) {
> +			fprintf(stderr, _("error: invalid argument: %s\n"), *argv);
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +
> +	strv_free(stdin_lines);

No need to free this here. The process will exit anyways.

> +
> +	print_bits(&bits, mode);
> +
> +	return EXIT_SUCCESS;
> +}
