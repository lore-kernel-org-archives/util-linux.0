Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FE5478E
	for <util-linux@vger.kernel.org>; Wed, 16 Oct 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113087; cv=none; b=DWPozQCX6+jiWLsgmNgGEVjNsNNteSni013uQ6kZymoioN3EM3t14+On0RwVXdU7dQF88kpt5EtnMglUNlNEfGsyNAgF+2I7b8agunrK/n4/UaOiM6tVLoa90sow4M+WxPoH3egp3QpBKn252Fm/Ew9mZlzbGglLuWRAFZW9nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113087; c=relaxed/simple;
	bh=zvFHSzTd/Db49V1R49r0yNemDFURQ0uBb/fHRrlvyKM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=RYmBjCaHM06TlRDieZndGSTI5B/vP5u5GutHwQXGfzLOXKHrNyVC2LcTaJJZZtZ4+7oBFxMu7mCxHOjl6UQNoR5NtZEk/JfalFfs4MSP6vj3OqXgLPDo5Md0/An6u2rzxzUzEoou+tiCoZiA9BcVYEJOC+WkxopNvGta+B+Dl80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc; spf=pass smtp.mailfrom=jarry.cc; dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b=0V3bnorK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cXzQSCva; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jarry.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b="0V3bnorK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXzQSCva"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E9DD138010C;
	Wed, 16 Oct 2024 17:11:24 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Wed, 16 Oct 2024 17:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729113084;
	 x=1729199484; bh=6JtYTNnP6LrVLxYTAvmhCzWg/HEaqDx6a0uLuPuEpBo=; b=
	0V3bnorKpZq6RFpfg/9z/pLio1PETCSfkIx45LrqM1f3n3OphVKLHV2t0aOUJ7jo
	gcCxX+jL+tVUlrfLS+ddsOR7Zz5M9w9R+cB/SnMiZTSid8/Ga0mYyVZpD9OKgkwD
	KPhMDGUVm1NiT2cmP5oHnOgafFlZbMIw5KEqkRDOqnKQYHPJq++WsShOaf7zWpHl
	6+LVtdOrNnSvhrdaVd6uVQpTwBfgmDtSI6VxEZLs7bdCTDNrpB+8Yj5XTXf4AUmA
	6eNxN9G5dFKoURJWCm/UGp9H/SUzlbk1B359t+aysh5OZ+oNhfWz7Lo3o6y5yFTO
	RXIHmPUBZn3n30JdCMKEjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729113084; x=
	1729199484; bh=6JtYTNnP6LrVLxYTAvmhCzWg/HEaqDx6a0uLuPuEpBo=; b=c
	XzQSCva87aDB7FMFnU00YdTL8Um8j2LqAkLiYvs0Rppd6tqTmxQrMCS4jkpD86x5
	iaG7L1GtXI9+AuXCnnDcY29NIapreoDFjmq5ri70KXxGSjLIMGCbGyFp7jfbfhtO
	UK0suD+BtfT1B2rsChlD8lGPGLvo+YomNIeqJrhUcsoWWdN3b0lh3sBa5v7MmTmm
	t3sWhkTxQg0Xzx4HorfmSMBKUA2r8J2yVDz103MMFrc8DTEBXR5wvbKBOoEc3gQf
	PGUYC4Mh4/STzzL71rUKFQM3cCM7N4Zq1RxkX+T6hE/KlxmpT7bRv7tSKLS1f5rN
	xPk24oujDXhMiw4MgLxIQ==
X-ME-Sender: <xms:-ysQZ9eUUuBnIV-rcB2xLuOabKu1NHLfYgOEFiRODp7y1scFvIAuBg>
    <xme:-ysQZ7OlDKXWT48Vplk9eGecW5iiVTf005v3MxQOxxmcxaDCLdqivIs2sksY12snz
    1TjVhCnERSIGw9zjPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenfghrlhcuvffnffculdduhedmnecujfgurhepofgggfgtfffk
    ufevhffvfghfjgesthhqredtreerjeenucfhrhhomhepfdftohgsihhnucflrghrrhihfd
    cuoehrohgsihhnsehjrghrrhihrdgttgeqnecuggftrfgrthhtvghrnhepvefffeelgfei
    gffhgeekleekiefgudfgjedtteeijedvueegvdeffeehteeujefgnecuffhomhgrihhnpe
    hsrhdrhhhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprhhosghinhesjhgrrhhrhidrtggtpdhnsggprhgtphhtthhopedvpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehthhhomhgrshesthdqkegthhdruggvpdhrtghpthht
    ohepuhhtihhlqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-ysQZ2i3pZWz71EKQpiKvxm32SoK4AaIlSXRZW3ayE-vi8S_vvnhWA>
    <xmx:-ysQZ2_zGSOqqtMowkCzHVjiJ3uV1iTfA5Tt_CAwBqP1Z5ZuX-sDOw>
    <xmx:-ysQZ5skWitosAefAM9XBStASER6K_fpTVnYKDvJqy7i66RuvOJ8lg>
    <xmx:-ysQZ1F0DxzKJtQR6MBRoyLQKkIeyZ2vl6FDu3oopyKxxqK2tNXsbA>
    <xmx:_CsQZ6Vd7N9-7kJzoegq_jsMChEwxZsD1nafvTV48oXnqsaeHdw8-wUE>
Feedback-ID: ic641498e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B50322220071; Wed, 16 Oct 2024 17:11:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Wed, 16 Oct 2024 23:11:22 +0200
Message-Id: <D4XJFK5WGV2R.244DMWY2H7ABM@ringo>
Subject: Re: [RFC PATCH util-linux] text-utils: add bits command
Cc: <util-linux@vger.kernel.org>
From: "Robin Jarry" <robin@jarry.cc>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
User-Agent: aerc/0.18.2-81-g43ce621f36dd
References: <20241016202621.2124554-2-robin@jarry.cc>
 <0792f071-786b-4cb2-9733-2b10c98c20f2@t-8ch.de>
In-Reply-To: <0792f071-786b-4cb2-9733-2b10c98c20f2@t-8ch.de>

Hi Thomas,

Thomas Wei=C3=9Fschuh, Oct 16, 2024 at 23:00:
> On 2024-10-16 22:26:22+0200, Robin Jarry wrote:
>> Add a new test utility to convert between bit masks in various formats.
>
> "test" or "text" utility?

That was a typo, I meant "text" :)

>> This can be handy to avoid parsing affinity masks in one's head and/or
>> to interact with the kernel in a more human friendly way.
>>=20
>> This is a rewrite in C of the bits command from my linux-tools python
>> package so that it can be more widely available.
>>=20
>> Here is an example:
>>=20
>>  ~# cat /sys/kernel/debug/tracing/tracing_cpumask
>>  fffffff,ffffffff,ffffffff,ffffffff
>>  ~# bits -l ,$(cat /sys/kernel/debug/tracing/tracing_cpumask)
>>  0-128
>>  ~# bits -g 58,59,120,123
>>  9000000,00000000,0c000000,00000000
>>  ~# bits -g 58,59 > /sys/kernel/debug/tracing/tracing_cpumask
>>  ~# echo 1 > /sys/kernel/debug/tracing/tracing_on
>>=20
>> Add man page and basic tests.
>>=20
>> Link: https://git.sr.ht/~rjarry/linux-tools#bits
>> Signed-off-by: Robin Jarry <robin@jarry.cc>
>> ---
>>  bash-completion/bits                  |  21 ++
>>  meson.build                           |  11 ++
>>  tests/commands.sh                     |   1 +
>>  tests/expected/misc/bits              |   0
>>  tests/expected/misc/bits-and          |   1 +
>>  tests/expected/misc/bits-binary       |   1 +
>>  tests/expected/misc/bits-default      |   1 +
>>  tests/expected/misc/bits-grouped-mask |   1 +
>>  tests/expected/misc/bits-list         |   1 +
>>  tests/expected/misc/bits-mask         |   1 +
>>  tests/expected/misc/bits-not          |   1 +
>>  tests/expected/misc/bits-or           |   1 +
>>  tests/expected/misc/bits-overflow     |   1 +
>>  tests/expected/misc/bits-parse-mask   |   1 +
>>  tests/expected/misc/bits-parse-range  |   1 +
>>  tests/expected/misc/bits-stdin        |   1 +
>>  tests/expected/misc/bits-xor          |   1 +
>>  tests/ts/misc/bits                    |  82 ++++++++
>>  text-utils/Makemodule.am              |   6 +
>>  text-utils/bits.1.adoc                | 147 ++++++++++++++
>>  text-utils/bits.c                     | 265 ++++++++++++++++++++++++++
>>  text-utils/meson.build                |   4 +
>>  22 files changed, 550 insertions(+)
>>  create mode 100644 bash-completion/bits
>>  create mode 100644 tests/expected/misc/bits
>>  create mode 100644 tests/expected/misc/bits-and
>>  create mode 100644 tests/expected/misc/bits-binary
>>  create mode 100644 tests/expected/misc/bits-default
>>  create mode 100644 tests/expected/misc/bits-grouped-mask
>>  create mode 100644 tests/expected/misc/bits-list
>>  create mode 100644 tests/expected/misc/bits-mask
>>  create mode 100644 tests/expected/misc/bits-not
>>  create mode 100644 tests/expected/misc/bits-or
>>  create mode 100644 tests/expected/misc/bits-overflow
>>  create mode 100644 tests/expected/misc/bits-parse-mask
>>  create mode 100644 tests/expected/misc/bits-parse-range
>>  create mode 100644 tests/expected/misc/bits-stdin
>>  create mode 100644 tests/expected/misc/bits-xor
>>  create mode 100755 tests/ts/misc/bits
>>  create mode 100644 text-utils/bits.1.adoc
>>  create mode 100644 text-utils/bits.c
>
> ...
>
>> +++ b/tests/ts/misc/bits
>> @@ -0,0 +1,82 @@
>> +#!/bin/bash
>> +
>> +#
>> +# Copyright (c) 2024 Robin Jarry
>> +#
>> +# This file is part of util-linux.
>> +#
>> +# This file is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This file is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>
> New files should use SPDX tags.

Ack, will change in v2.

>> diff --git a/text-utils/bits.c b/text-utils/bits.c
>> new file mode 100644
>> index 000000000000..6dd0db81a5de
>> --- /dev/null
>> +++ b/text-utils/bits.c
>> @@ -0,0 +1,265 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * Copyright (c) 2024 Robin Jarry
>> + *
>> + * bits - convert bit masks from/to various formats
>> + */
>> +
>> +#include <errno.h>
>> +#include <getopt.h>
>> +#include <sched.h>
>> +#include <stdbool.h>
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +
>> +#include "c.h"
>> +#include "closestream.h"
>> +#include "cpuset.h"
>> +#include "nls.h"
>> +#include "strutils.h"
>> +#include "strv.h"
>> +
>> +typedef enum {
>> +	OP_OR,
>> +	OP_AND,
>> +	OP_NOT,
>> +	OP_XOR,
>> +} bitvise_op_t;
>
> "bitwise"?
> Also avoid using the _t suffix as it's reserved.
> "enum bitwise_op" seems clear enough.

Yes, bitwise is the correct spelling. I will probably remove that in v2=20
as you suggested below.

>> +
>> +static int parse_mask_or_list(const char *cmdline_arg, cpu_set_t *all_b=
its)
>> +{
>> +	bitvise_op_t op =3D OP_OR;
>> +	cpu_set_t bits, copy;
>
> This seems very geared towards cpu masks.
> What happens if a user wants to use it with very large non-CPU bitmasks,
> as the tool is advertised as a generic utility?
>
> Call the utility "cpumask"?

The default cpu_set_t size can hold up to 1024 bits (128 bytes).=20
I assumed it was more than enough for common use cases. I added a basic=20
test that checks that the program does not crash when specifying a too=20
large mask.

I also didn't want to call that tool "*mask" because it can also deal=20
with lists. But I don't have a strong opinion on the matter.

>
>> +	char buf[BUFSIZ];
>
> Only use BUFSIZ in cases where the actual value does not matter,
> for example loops.
> On musl BUFSIZ =3D=3D 1024 and this could not be enough fairly soon.

Good point. I wasn't sure what is a reasonable maximum argument size.=20
execve(2) says MAX_ARG_STRLEN (32 pages) which seems excessive. I could=20
hardcode 8192 and be done with it. What do you think?

>
>> +	char *arg =3D buf;
>> +
>> +	/* copy to allow modifying the argument contents */
>> +	strlcpy(buf, cmdline_arg, sizeof(buf));
>> +	buf[sizeof(buf) - 1] =3D '\0';
>
> You can just use xstrdup().

But then, I'd have to free it. I wanted to avoid this.

>
>> +
>> +	/* strip optional operator first */
>> +	if (startswith(arg, "&")) {
>> +		op =3D OP_AND;
>> +		arg++;
>> +	} else if (startswith(arg, "^")) {
>> +		op =3D OP_XOR;
>> +		arg++;
>> +	} else if (startswith(arg, "~")) {
>> +		op =3D OP_NOT;
>> +		arg++;
>> +	} else if (startswith(arg, "|")) {
>> +		op =3D OP_OR;
>> +		arg++;
>> +	}
>
> The whole op enum could also be replaced by the actual character,
> this is all in a single function.
>
> op =3D '&';
>
> ...
>
> switch (op) {
> case '&':
> }

Good point. I'll do that in v2.

>
>> +
>> +	if (startswith(arg, ",") || startswith(arg, "0x")) {
>> +		if (cpumask_parse(arg, &bits, sizeof(bits)) < 0)
>> +			return -EINVAL;
>
> As this is a commandline tool you can call errx() here to kill the
> process and provide better error information.
> It would also make the call sequence slightly more simple.

Ack.

>
>> +	} else {
>> +		if (cpulist_parse(arg, &bits, sizeof(bits), 1) < 0)
>> +			return -EINVAL;
>> +	}
>> +
>> +	switch (op) {
>> +	case OP_AND:
>> +		copy =3D *all_bits;
>> +		CPU_AND(all_bits, &copy, &bits);
>> +		break;
>> +	case OP_OR:
>> +		copy =3D *all_bits;
>> +		CPU_OR(all_bits, &copy, &bits);
>> +		break;
>> +	case OP_XOR:
>> +		copy =3D *all_bits;
>> +		CPU_XOR(all_bits, &copy, &bits);
>> +		break;
>> +	case OP_NOT:
>> +		for (int i =3D 0; i < CPU_SETSIZE; i++) {
>> +			if (CPU_ISSET(i, &bits))
>> +				CPU_CLR(i, all_bits);
>> +		}
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +typedef enum {
>> +	MODE_BINARY,
>> +	MODE_GROUPED_MASK,
>> +	MODE_LIST,
>> +	MODE_MASK,
>> +} output_mode_t;
>> +
>> +static void print_bits(cpu_set_t *bits, output_mode_t mode)
>> +{
>> +	bool started =3D false;
>> +	char buf[BUFSIZ];
>> +	ssize_t n =3D 0;
>> +
>> +	buf[0] =3D '\0';
>
> Is this necessary?

It may have been at some point but it isn't anymore. I'll remove it.

>
>> +
>> +	switch (mode) {
>> +	case MODE_MASK:
>> +		cpumask_create(buf, sizeof(buf), bits, sizeof(*bits));
>> +
>> +		/* strip leading zeroes */
>> +		while (buf[n] =3D=3D '0')
>> +			n++;
>> +		if (buf[n] =3D=3D '\0')
>> +			printf("0x0\n");
>> +		else
>> +			printf("0x%s\n", buf + n);
>> +		break;
>> +
>> +	case MODE_GROUPED_MASK:
>> +		cpumask_create(buf, sizeof(buf), bits, sizeof(*bits));
>> +
>> +		/* strip leading zeroes */
>> +		while (buf[n] =3D=3D '0')
>> +			n++;
>> +
>> +		while (buf[n] !=3D '\0') {
>> +			if (started && (n % 8) =3D=3D 0)
>> +				printf(",");
>> +			if (buf[n] !=3D '0')
>> +				started =3D true;
>> +			printf("%c", buf[n]);
>> +			n++;
>> +		}
>> +		printf("\n");
>> +		break;
>> +
>> +	case MODE_BINARY:
>> +		printf("0b");
>> +		for (n =3D CPU_SETSIZE; n >=3D 0; n--) {
>> +			if (started && ((n + 1) % 4) =3D=3D 0)
>> +				printf("_");
>> +			if (CPU_ISSET(n, bits)) {
>> +				started =3D true;
>> +				printf("1");
>> +			} else if (started) {
>> +				printf("0");
>> +			}
>> +		}
>> +		printf("\n");
>> +		break;
>> +
>> +	case MODE_LIST:
>> +		cpulist_create(buf, sizeof(buf), bits, sizeof(*bits));
>
> This could use the return values of cpulist_create() and
> cpumask_create().

Since I am printing into a stack buffer, is there a benefit?

>> +		printf("%s\n", buf);
>> +		break;
>> +	}
>> +
>> +}
>> +
>> +static void __attribute__((__noreturn__)) usage(void)
>> +{
>> +	fputs(USAGE_HEADER, stdout);
>> +	fprintf(stdout, _(" %s [options] [<mask_or_list>...]\n"), program_invo=
cation_short_name);
>> +
>> +	fputs(USAGE_SEPARATOR, stdout);
>> +	fputsln(_("Convert bit masks from/to various formats."), stdout);
>> +
>> +	fputs(USAGE_ARGUMENTS, stdout);
>> +	fputsln(_(" <mask_or_list>      A set of bits specified as a hex mask =
value (e.g. 0xeec2)\n"
>> +		"                     or as a comma-separated list of bit IDs.\n"
>> +		"                     If not specified, arguments will be read from s=
tdin."), stdout);
>> +
>> +	fputs(USAGE_OPTIONS, stdout);
>> +	fprintf(stdout, USAGE_HELP_OPTIONS(21));
>> +
>> +	fputs(_("\nMode:\n"), stdout);
>> +	fputsln(_(" -m, --mask          Print the combined args as a hex mask =
value (default).\n"), stdout);
>> +	fputsln(_(" -g, --grouped-mask  Print the combined args as a hex mask =
value in 32bit\n"
>> +			"                     comma separated groups."), stdout);
>> +	fputsln(_(" -b, --binary        Print the combined args as a binary ma=
sk value."), stdout);
>> +	fputsln(_(" -l, --list          Print the combined args as a compresse=
d list of bit IDs."), stdout);
>> +
>> +	fputs(USAGE_SEPARATOR, stdout);
>> +	fprintf(stdout, USAGE_MAN_TAIL("bits(1)"));
>> +	exit(EXIT_SUCCESS);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	output_mode_t mode =3D MODE_MASK;
>> +	char **stdin_lines =3D NULL;
>> +	cpu_set_t bits;
>> +	int c;
>> +
>> +	static const struct option longopts[] =3D {
>> +		{ "version",      no_argument, NULL, 'V'},
>> +		{ "help",         no_argument, NULL, 'h'},
>> +		{ "mask",         no_argument, NULL, 'm'},
>> +		{ "grouped-mask", no_argument, NULL, 'g'},
>> +		{ "binary",       no_argument, NULL, 'b'},
>> +		{ "list",         no_argument, NULL, 'l'},
>> +		{ NULL, 0, NULL, 0 }
>> +	};
>> +
>> +	setlocale(LC_ALL, "");
>> +	bindtextdomain(PACKAGE, LOCALEDIR);
>> +	textdomain(PACKAGE);
>> +	close_stdout_atexit();
>> +
>> +	while ((c =3D getopt_long(argc, argv, "Vhmgbl", longopts, NULL)) !=3D =
-1)
>> +		switch (c) {
>> +		case 'm':
>> +			mode =3D MODE_MASK;
>> +			break;
>> +		case 'g':
>> +			mode =3D MODE_GROUPED_MASK;
>> +			break;
>> +		case 'b':
>> +			mode =3D MODE_BINARY;
>> +			break;
>> +		case 'l':
>> +			mode =3D MODE_LIST;
>> +			break;
>> +		case 'V':
>> +			print_version(EXIT_SUCCESS);
>> +		case 'h':
>> +			usage();
>> +		default:
>> +			errtryhelp(EXIT_FAILURE);
>> +		}
>> +
>> +	argc -=3D optind;
>> +	argv +=3D optind;
>> +	if (argc =3D=3D 0) {
>> +		/* no arguments provided, read lines from stdin */
>> +		char buf[BUFSIZ];
>> +
>> +		while (fgets(buf, sizeof(buf), stdin)) {
>> +			/* strip LF, CR, CRLF, LFCR */
>> +			buf[strcspn(buf, "\r\n")] =3D '\0';
>
> rtrim_whitespace()?

Ack.

>
>> +			strv_push(&stdin_lines, strdup(buf));
>> +		}
>> +
>> +		argc =3D strv_length(stdin_lines);
>> +		argv =3D stdin_lines;
>> +	}
>> +
>> +	CPU_ZERO(&bits);
>> +
>> +	for (; argc > 0; argc--, argv++)
>> +		if (parse_mask_or_list(*argv, &bits) < 0) {
>> +			fprintf(stderr, _("error: invalid argument: %s\n"), *argv);
>> +			errtryhelp(EXIT_FAILURE);
>> +		}
>> +
>> +	strv_free(stdin_lines);
>
> No need to free this here. The process will exit anyways.

I wanted to make ASAN happy. Is this not necessary?

>
>> +
>> +	print_bits(&bits, mode);
>> +
>> +	return EXIT_SUCCESS;
>> +}

Thanks for the review!

