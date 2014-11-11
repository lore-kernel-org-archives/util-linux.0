Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f181.google.com ([209.85.217.181]:50423 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbaKKHOT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Nov 2014 02:14:19 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so7265218lbv.12
        for <util-linux@vger.kernel.org>; Mon, 10 Nov 2014 23:14:17 -0800 (PST)
Message-ID: <5461B803.4050707@linux.com>
Date: Tue, 11 Nov 2014 13:17:23 +0600
From: Boris Egorov <egorov@linux.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

On 11/11/2014 03:49 AM, Sami Kerola wrote:

> The short description is: when the code is at very last line of mkswap at
> 'return EXIT_SUCCESS;' somehow the EXIT_SUCCESS is 1.  If I change the
> 'return EXIT_SUCCESS;' to 'exit(EXIT_SUCCESS);' the return value stays
> expected.  Possible explanations include:
That's interesting.

> 1. I'm doing something silly and/or wrong.
I doubt it.

> 2. This happens only on my laptop (or imagination).  Please, let it not
>     be this.
No, I can confirm: It works as you describe with clang-3.5.0 from Debian 
Jessie. Returns 1 with ld.bfd too.

> 3. This is a bug in clang, llvm, and/or AddressSanitizer.
>     clang / llvm version 3.5.0 from Archlinux packages 3.5.0-2.1
Probably it is.

> 4. With gcc 4.9.2 and the same CFLAGS the mkswap works.
Confirmed with gcc 4.9.1.

I found more info: problem connected with atexit(close_stdout). If I 
comment this line, mkswap exits normally. Looks like close_stdout ends 
successfully (I've made it not inline and checked it with gdb), but then 
program exits with code 1.

Also, there is a problem building mkswap with clang on my machine. 
autoconf test for HAVE_SCANF_MS_MODIFIER is incomplete. clang/llvm have 
%m modifier (I've checked it), but this test fails to detect it. Test 
for HAVE_SCANF_AS_MODIFIER fails too, I suppose. So when I build mkswap 
I have an error:

     lib/colors.c:620:19: error: use of undeclared identifier 'UL_SCNsA'
                     rc = sscanf(p,  UL_SCNsA" "     /* name */

So, we need to detect %m modifier with clang on build somehow.

PS. Forgot to add mail list on reply, resending message. Sorry for the 
duplicate, Sami.

-- 
Best Regards,
Boris Egorov
