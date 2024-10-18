Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280217E00F
	for <util-linux@vger.kernel.org>; Fri, 18 Oct 2024 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234412; cv=none; b=fNTp1fyd/Mt4U7xfdh83GnwRLuqfAmkyNKepMfCa/CUQ1mgH+k/GRG/UtDY7CFBqqA1oHGS+BACv+mlN7jI4FgksNYeJFlPfPACYXeCOTep8/FHEv2xBE64iinnqxsqBta9c8Em5NYjZmsD/Lm/vfmjpAdq+cR8pFKJIvGwSRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234412; c=relaxed/simple;
	bh=NXt002z5xE9wvbbm6uk2QMLD1AQ25ketrhabFd/bccM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=K2eMa8QQi1dusW70F+2xTYqM8E9vl86/eP/Rfglu2VLFLMKq2UUxR3SLjsU8ffw5LCydA7P3VnP2qqfSIGLzRHbNGDvmPrEhnZ4TrIw+N+AzTuipwMMDxs06dhGlyLT8fs1f+30mrWLW2JAjOB2yJfZ1Xo749y4BVH1+YyAlBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=pAw4d75c; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="pAw4d75c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1729234399; bh=NXt002z5xE9wvbbm6uk2QMLD1AQ25ketrhabFd/bccM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pAw4d75cwQubuhCVzOT3WUig87Ux97q7qhUOeJc9WyAcT8SrzE6Fva57P5pE9lsZs
	 /Pwfe+pU/2hn2xKvWwmQzB8BbFnwANuW1HsJeTTqfuk50uQhYOR10B/2GtDZe+fDkA
	 rEz/EnprR70gOUsMmsU2PAQRJxQZJIsb89S1C+5Q=
Date: Fri, 18 Oct 2024 08:53:16 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Robin Jarry <robin@jarry.cc>
Cc: util-linux@vger.kernel.org
Message-ID: <664fe6f0-1622-4372-b882-f81989a91cdd@t-8ch.de>
In-Reply-To: <D4XJFK5WGV2R.244DMWY2H7ABM@ringo>
References: <20241016202621.2124554-2-robin@jarry.cc> <0792f071-786b-4cb2-9733-2b10c98c20f2@t-8ch.de> <D4XJFK5WGV2R.244DMWY2H7ABM@ringo>
Subject: Re: [RFC PATCH util-linux] text-utils: add bits command
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <664fe6f0-1622-4372-b882-f81989a91cdd@t-8ch.de>

Oct 16, 2024 23:11:38 Robin Jarry <robin@jarry.cc>:

> Hi Thomas,
>
> Thomas Wei=C3=9Fschuh, Oct 16, 2024 at 23:00:
>> On 2024-10-16 22:26:22+0200, Robin Jarry wrote:
>>> Add a new test utility to convert between bit masks in various formats.
>>
>> "test" or "text" utility?
>
> That was a typo, I meant "text" :)
>
>>> This can be handy to avoid parsing affinity masks in one's head and/or
>>> to interact with the kernel in a more human friendly way.
>>> This is a rewrite in C of the bits command from my linux-tools python
>>> package so that it can be more widely available.
>>> Here is an example:
>>> ~# cat /sys/kernel/debug/tracing/tracing_cpumask
>>> fffffff,ffffffff,ffffffff,ffffffff
>>> ~# bits -l ,$(cat /sys/kernel/debug/tracing/tracing_cpumask)
>>> 0-128
>>> ~# bits -g 58,59,120,123
>>> 9000000,00000000,0c000000,00000000
>>> ~# bits -g 58,59 > /sys/kernel/debug/tracing/tracing_cpumask
>>> ~# echo 1 > /sys/kernel/debug/tracing/tracing_on
>>> Add man page and basic tests.
>>> Link: https://git.sr.ht/~rjarry/linux-tools#bits
>>> Signed-off-by: Robin Jarry <robin@jarry.cc>
>>> ---
>>> bash-completion/bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 ++
>>> meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 ++
>>> tests/commands.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>>> tests/expected/misc/bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>> tests/expected/misc/bits-and=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-binary=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-default=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>>> tests/expected/misc/bits-grouped-mask |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-not=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-or=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-overflow=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 1 +
>>> tests/expected/misc/bits-parse-mask=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-parse-range=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-stdin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>>> tests/expected/misc/bits-xor=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> tests/ts/misc/bits=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 82 =
++++++++
>>> text-utils/Makemodule.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +
>>> text-utils/bits.1.adoc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 147 ++++++++++++++
>>> text-utils/bits.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 265 ++=
++++++++++++++++++++++++
>>> text-utils/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
>>> 22 files changed, 550 insertions(+)
>>> create mode 100644 bash-completion/bits
>>> create mode 100644 tests/expected/misc/bits
>>> create mode 100644 tests/expected/misc/bits-and
>>> create mode 100644 tests/expected/misc/bits-binary
>>> create mode 100644 tests/expected/misc/bits-default
>>> create mode 100644 tests/expected/misc/bits-grouped-mask
>>> create mode 100644 tests/expected/misc/bits-list
>>> create mode 100644 tests/expected/misc/bits-mask
>>> create mode 100644 tests/expected/misc/bits-not
>>> create mode 100644 tests/expected/misc/bits-or
>>> create mode 100644 tests/expected/misc/bits-overflow
>>> create mode 100644 tests/expected/misc/bits-parse-mask
>>> create mode 100644 tests/expected/misc/bits-parse-range
>>> create mode 100644 tests/expected/misc/bits-stdin
>>> create mode 100644 tests/expected/misc/bits-xor
>>> create mode 100755 tests/ts/misc/bits
>>> create mode 100644 text-utils/bits.1.adoc
>>> create mode 100644 text-utils/bits.c
>>
>> ...
>>
>>> +++ b/tests/ts/misc/bits
>>> @@ -0,0 +1,82 @@
>>> +#!/bin/bash
>>> +
>>> +#
>>> +# Copyright (c) 2024 Robin Jarry
>>> +#
>>> +# This file is part of util-linux.
>>> +#
>>> +# This file is free software; you can redistribute it and/or modify
>>> +# it under the terms of the GNU General Public License as published by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This file is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the
>>> +# GNU General Public License for more details.
>>
>> New files should use SPDX tags.
>
> Ack, will change in v2.
>
>>> diff --git a/text-utils/bits.c b/text-utils/bits.c
>>> new file mode 100644
>>> index 000000000000..6dd0db81a5de
>>> --- /dev/null
>>> +++ b/text-utils/bits.c
>>> @@ -0,0 +1,265 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * This program is free software; you can redistribute it and/or modif=
y
>>> + * it under the terms of the GNU General Public License as published b=
y
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * Copyright (c) 2024 Robin Jarry
>>> + *
>>> + * bits - convert bit masks from/to various formats
>>> + */
>>> +
>>> +#include <errno.h>
>>> +#include <getopt.h>
>>> +#include <sched.h>
>>> +#include <stdbool.h>
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +
>>> +#include "c.h"
>>> +#include "closestream.h"
>>> +#include "cpuset.h"
>>> +#include "nls.h"
>>> +#include "strutils.h"
>>> +#include "strv.h"
>>> +
>>> +typedef enum {
>>> +=C2=A0=C2=A0 OP_OR,
>>> +=C2=A0=C2=A0 OP_AND,
>>> +=C2=A0=C2=A0 OP_NOT,
>>> +=C2=A0=C2=A0 OP_XOR,
>>> +} bitvise_op_t;
>>
>> "bitwise"?
>> Also avoid using the _t suffix as it's reserved.
>> "enum bitwise_op" seems clear enough.
>
> Yes, bitwise is the correct spelling. I will probably remove that in v2 a=
s you suggested below.
>
>>> +
>>> +static int parse_mask_or_list(const char *cmdline_arg, cpu_set_t *all_=
bits)
>>> +{
>>> +=C2=A0=C2=A0 bitvise_op_t op =3D OP_OR;
>>> +=C2=A0=C2=A0 cpu_set_t bits, copy;
>>
>> This seems very geared towards cpu masks.
>> What happens if a user wants to use it with very large non-CPU bitmasks,
>> as the tool is advertised as a generic utility?
>>
>> Call the utility "cpumask"?
>
> The default cpu_set_t size can hold up to 1024 bits (128 bytes). I assume=
d it was more than enough for common use cases. I added a basic test that c=
hecks that the program does not crash when specifying a too large mask.

> I also didn't want to call that tool "*mask" because it can also deal wit=
h lists. But I don't have a strong opinion on the matter.

I don't have an strong opinions on naming. Except that I'm bad at it.
The limitation should at least be documented.
(I didn't check of it already is)

>>> +=C2=A0=C2=A0 char buf[BUFSIZ];
>>
>> Only use BUFSIZ in cases where the actual value does not matter,
>> for example loops.
>> On musl BUFSIZ =3D=3D 1024 and this could not be enough fairly soon.
>
> Good point. I wasn't sure what is a reasonable maximum argument size. exe=
cve(2) says MAX_ARG_STRLEN (32 pages) which seems excessive. I could hardco=
de 8192 and be done with it. What do you think?
>
>>
>>> +=C2=A0=C2=A0 char *arg =3D buf;
>>> +
>>> +=C2=A0=C2=A0 /* copy to allow modifying the argument contents */
>>> +=C2=A0=C2=A0 strlcpy(buf, cmdline_arg, sizeof(buf));
>>> +=C2=A0=C2=A0 buf[sizeof(buf) - 1] =3D '\0';
>>
>> You can just use xstrdup().
>
> But then, I'd have to free it. I wanted to avoid this.

The CLI utilities of util-linux generally don't free memory if the tool wil=
l exit soon anyways.

>>
>>> +
>>> +=C2=A0=C2=A0 /* strip optional operator first */
>>> +=C2=A0=C2=A0 if (startswith(arg, "&")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D OP_AND;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg++;
>>> +=C2=A0=C2=A0 } else if (startswith(arg, "^")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D OP_XOR;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg++;
>>> +=C2=A0=C2=A0 } else if (startswith(arg, "~")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D OP_NOT;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg++;
>>> +=C2=A0=C2=A0 } else if (startswith(arg, "|")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D OP_OR;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg++;
>>> +=C2=A0=C2=A0 }
>>
>> The whole op enum could also be replaced by the actual character,
>> this is all in a single function.
>>
>> op =3D '&';
>>
>> ...
>>
>> switch (op) {
>> case '&':
>> }
>
> Good point. I'll do that in v2.
>
>>
>>> +
>>> +=C2=A0=C2=A0 if (startswith(arg, ",") || startswith(arg, "0x")) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpumask_parse(arg, &bits, siz=
eof(bits)) < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -E=
INVAL;
>>
>> As this is a commandline tool you can call errx() here to kill the
>> process and provide better error information.
>> It would also make the call sequence slightly more simple.
>
> Ack.
>
>>
>>> +=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpulist_parse(arg, &bits, siz=
eof(bits), 1) < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -E=
INVAL;
>>> +=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0 switch (op) {
>>> +=C2=A0=C2=A0 case OP_AND:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy =3D *all_bits;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_AND(all_bits, &copy, &bits);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0 case OP_OR:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy =3D *all_bits;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_OR(all_bits, &copy, &bits);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0 case OP_XOR:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy =3D *all_bits;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU_XOR(all_bits, &copy, &bits);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0 case OP_NOT:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < CPU_SETSIZE=
; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CPU_I=
SSET(i, &bits))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CPU_CLR(i, all_bits);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +typedef enum {
>>> +=C2=A0=C2=A0 MODE_BINARY,
>>> +=C2=A0=C2=A0 MODE_GROUPED_MASK,
>>> +=C2=A0=C2=A0 MODE_LIST,
>>> +=C2=A0=C2=A0 MODE_MASK,
>>> +} output_mode_t;
>>> +
>>> +static void print_bits(cpu_set_t *bits, output_mode_t mode)
>>> +{
>>> +=C2=A0=C2=A0 bool started =3D false;
>>> +=C2=A0=C2=A0 char buf[BUFSIZ];
>>> +=C2=A0=C2=A0 ssize_t n =3D 0;
>>> +
>>> +=C2=A0=C2=A0 buf[0] =3D '\0';
>>
>> Is this necessary?
>
> It may have been at some point but it isn't anymore. I'll remove it.
>
>>
>>> +
>>> +=C2=A0=C2=A0 switch (mode) {
>>> +=C2=A0=C2=A0 case MODE_MASK:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_create(buf, sizeof(buf), =
bits, sizeof(*bits));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* strip leading zeroes */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (buf[n] =3D=3D '0')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (buf[n] =3D=3D '\0')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("0=
x0\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("0=
x%s\n", buf + n);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0 case MODE_GROUPED_MASK:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_create(buf, sizeof(buf), =
bits, sizeof(*bits));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* strip leading zeroes */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (buf[n] =3D=3D '0')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n++;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (buf[n] !=3D '\0') {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (start=
ed && (n % 8) =3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printf(",");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (buf[n=
] !=3D '0')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 started =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%=
c", buf[n]);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0 case MODE_BINARY:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("0b");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (n =3D CPU_SETSIZE; n >=3D 0;=
 n--) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (start=
ed && ((n + 1) % 4) =3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printf("_");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CPU_I=
SSET(n, bits)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 started =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printf("1");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if=
 (started) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printf("0");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0 case MODE_LIST:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpulist_create(buf, sizeof(buf), =
bits, sizeof(*bits));
>>
>> This could use the return values of cpulist_create() and
>> cpumask_create().
>
> Since I am printing into a stack buffer, is there a benefit?

Wouldn't the same hold true for a non-stack buffer?
Anyways, this shouldn't be important.

>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%s\n", buf);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0 }
>>> +
>>> +}
>>> +
>>> +static void __attribute__((__noreturn__)) usage(void)
>>> +{
>>> +=C2=A0=C2=A0 fputs(USAGE_HEADER, stdout);
>>> +=C2=A0=C2=A0 fprintf(stdout, _(" %s [options] [<mask_or_list>...]\n"),=
 program_invocation_short_name);
>>> +
>>> +=C2=A0=C2=A0 fputs(USAGE_SEPARATOR, stdout);
>>> +=C2=A0=C2=A0 fputsln(_("Convert bit masks from/to various formats."), =
stdout);
>>> +
>>> +=C2=A0=C2=A0 fputs(USAGE_ARGUMENTS, stdout);
>>> +=C2=A0=C2=A0 fputsln(_(" <mask_or_list>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
A set of bits specified as a hex mask value (e.g. 0xeec2)\n"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 or as a comma-separated list of bit IDs.\n"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 If not specified, arguments will be read from stdin."), std=
out);
>>> +
>>> +=C2=A0=C2=A0 fputs(USAGE_OPTIONS, stdout);
>>> +=C2=A0=C2=A0 fprintf(stdout, USAGE_HELP_OPTIONS(21));
>>> +
>>> +=C2=A0=C2=A0 fputs(_("\nMode:\n"), stdout);
>>> +=C2=A0=C2=A0 fputsln(_(" -m, --mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Print the combined args as a hex mask value (default)=
.\n"), stdout);
>>> +=C2=A0=C2=A0 fputsln(_(" -g, --grouped-mask=C2=A0 Print the combined a=
rgs as a hex mask value in 32bit\n"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comma separated groups."), stdout);
>>> +=C2=A0=C2=A0 fputsln(_(" -b, --binary=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Print the combined args as a binary mask value."), stdout);
>>> +=C2=A0=C2=A0 fputsln(_(" -l, --list=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Print the combined args as a compressed list of bit I=
Ds."), stdout);
>>> +
>>> +=C2=A0=C2=A0 fputs(USAGE_SEPARATOR, stdout);
>>> +=C2=A0=C2=A0 fprintf(stdout, USAGE_MAN_TAIL("bits(1)"));
>>> +=C2=A0=C2=A0 exit(EXIT_SUCCESS);
>>> +}
>>> +
>>> +int main(int argc, char **argv)
>>> +{
>>> +=C2=A0=C2=A0 output_mode_t mode =3D MODE_MASK;
>>> +=C2=A0=C2=A0 char **stdin_lines =3D NULL;
>>> +=C2=A0=C2=A0 cpu_set_t bits;
>>> +=C2=A0=C2=A0 int c;
>>> +
>>> +=C2=A0=C2=A0 static const struct option longopts[] =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "version",=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 no_argument, NULL, 'V'},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "help",=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 no_argument, NULL, 'h'},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mask",=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 no_argument, NULL, 'm'},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "grouped-mask", no_argument, NU=
LL, 'g'},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "binary",=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 no_argument, NULL, 'b'},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "list",=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 no_argument, NULL, 'l'},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { NULL, 0, NULL, 0 }
>>> +=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0 setlocale(LC_ALL, "");
>>> +=C2=A0=C2=A0 bindtextdomain(PACKAGE, LOCALEDIR);
>>> +=C2=A0=C2=A0 textdomain(PACKAGE);
>>> +=C2=A0=C2=A0 close_stdout_atexit();
>>> +
>>> +=C2=A0=C2=A0 while ((c =3D getopt_long(argc, argv, "Vhmgbl", longopts,=
 NULL)) !=3D -1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (c) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'm':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D =
MODE_MASK;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'g':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D =
MODE_GROUPED_MASK;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'b':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D =
MODE_BINARY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'l':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode =3D =
MODE_LIST;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'V':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_ver=
sion(EXIT_SUCCESS);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 'h':
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errtryhel=
p(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0 argc -=3D optind;
>>> +=C2=A0=C2=A0 argv +=3D optind;
>>> +=C2=A0=C2=A0 if (argc =3D=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no arguments provided, read li=
nes from stdin */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char buf[BUFSIZ];
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (fgets(buf, sizeof(buf), st=
din)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* strip =
LF, CR, CRLF, LFCR */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf[strcs=
pn(buf, "\r\n")] =3D '\0';
>>
>> rtrim_whitespace()?
>
> Ack.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strv_push=
(&stdin_lines, strdup(buf));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argc =3D strv_length(stdin_lines)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 argv =3D stdin_lines;
>>> +=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0 CPU_ZERO(&bits);
>>> +
>>> +=C2=A0=C2=A0 for (; argc > 0; argc--, argv++)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parse_mask_or_list(*argv, &bi=
ts) < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(s=
tderr, _("error: invalid argument: %s\n"), *argv);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errtryhel=
p(EXIT_FAILURE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0 strv_free(stdin_lines);
>>
>> No need to free this here. The process will exit anyways.
>
> I wanted to make ASAN happy. Is this not necessary?

As mentioned above, freeing memory at the end of the process lifetime isn't
really useful.
The kernel will need to clean it up anyways.

>>> +
>>> +=C2=A0=C2=A0 print_bits(&bits, mode);
>>> +
>>> +=C2=A0=C2=A0 return EXIT_SUCCESS;
>>> +}
>
> Thanks for the review!

