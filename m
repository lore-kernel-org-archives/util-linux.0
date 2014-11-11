Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62568 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaKKWIo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Nov 2014 17:08:44 -0500
Received: by mail-pa0-f44.google.com with SMTP id bj1so11472653pad.17
        for <util-linux@vger.kernel.org>; Tue, 11 Nov 2014 14:08:44 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <5461B803.4050707@linux.com>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
	<5461B803.4050707@linux.com>
Date: Tue, 11 Nov 2014 22:08:44 +0000
Message-ID: <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
From: Sami Kerola <kerolasa@iki.fi>
To: Boris Egorov <egorov@linux.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11 November 2014 07:17, Boris Egorov <egorov@linux.com> wrote:
> On 11/11/2014 03:49 AM, Sami Kerola wrote:
>
>> The short description is: when the code is at very last line of mkswap at
>> 'return EXIT_SUCCESS;' somehow the EXIT_SUCCESS is 1.  If I change the
>> 'return EXIT_SUCCESS;' to 'exit(EXIT_SUCCESS);' the return value stays
>> expected.  Possible explanations include:
>
> That's interesting.
>
>> 1. I'm doing something silly and/or wrong.
>
> I doubt it.
>
>> 2. This happens only on my laptop (or imagination).  Please, let it not
>>     be this.
>
> No, I can confirm: It works as you describe with clang-3.5.0 from Debian
> Jessie. Returns 1 with ld.bfd too.

Hi Boris,

Excellent to hear the issue is reproducible.

>> 3. This is a bug in clang, llvm, and/or AddressSanitizer.
>>     clang / llvm version 3.5.0 from Archlinux packages 3.5.0-2.1
>
> Probably it is.
>
>> 4. With gcc 4.9.2 and the same CFLAGS the mkswap works.
>
> Confirmed with gcc 4.9.1.
>
> I found more info: problem connected with atexit(close_stdout). If I comment
> this line, mkswap exits normally. Looks like close_stdout ends successfully
> (I've made it not inline and checked it with gdb), but then program exits
> with code 1.

Good idea. Removal of the atexit(close_stdout) made a leak to appear.
In wipe_device() the 'char *type' leaked. Unfortunately this
correction did nothing to exit value issue.

It's time to get a core.

$ ASAN_OPTIONS=abort_on_error=1 ./mkswap test ; echo $?
lt-mkswap: test: warning: wiping old swap signature.
Setting up swapspace version 1, size = 6.5 MiB (6819840 bytes)
no label, UUID=0cd79d6a-4abc-4ce8-951a-308506e5a09e
Aborted (core dumped)
134

Almost good news.

Nov 11 21:55:08 kerolasa-home systemd-coredump[4941]: Coredump of 4921
(lt-mkswap) is larger than configured processing limit, refusing.
Nov 11 21:55:09 kerolasa-home systemd-coredump[4941]: Process 4921
(lt-mkswap) of user 1000 dumped core.

If I'm reading code right the core has to be more than 2 gigabytes
before that happens.

src/journal/coredump.c:#define PROCESS_SIZE_MAX ((off_t)
(2LLU*1024LLU*1024LLU*1024LLU))

I'm running out of ideas.

> Also, there is a problem building mkswap with clang on my machine. autoconf
> test for HAVE_SCANF_MS_MODIFIER is incomplete. clang/llvm have %m modifier
> (I've checked it), but this test fails to detect it. Test for
> HAVE_SCANF_AS_MODIFIER fails too, I suppose. So when I build mkswap I have
> an error:
>
>     lib/colors.c:620:19: error: use of undeclared identifier 'UL_SCNsA'
>                     rc = sscanf(p,  UL_SCNsA" "     /* name */
>
> So, we need to detect %m modifier with clang on build somehow.

The scanf modifier detection fix is the first change in this  pull request.

http://marc.info/?l=util-linux-ng&m=141565620610774&w=2

> PS. Forgot to add mail list on reply, resending message. Sorry for the
> duplicate, Sami.

NP.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
