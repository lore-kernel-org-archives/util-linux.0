Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:55834 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862Ab3GAK65 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Jul 2013 06:58:57 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so4827969pab.20
        for <util-linux@vger.kernel.org>; Mon, 01 Jul 2013 03:58:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130701090103.GA28709@x2.net.home>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
	<1371408836-16663-16-git-send-email-kerolasa@iki.fi>
	<20130701090103.GA28709@x2.net.home>
Date: Mon, 1 Jul 2013 11:58:56 +0100
Message-ID: <CAG27Bk38mrA54btgSAQsiKTOoh2ZXFD8jgJ3vLHWf12QAy9-dw@mail.gmail.com>
Subject: Re: [PATCH 15/15] hexdump: use simple printing functions when possible
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 1 July 2013 10:01, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Jun 16, 2013 at 07:53:56PM +0100, Sami Kerola wrote:
>> This makes common cases 35-50% quicker.
>
>  What about portability and code readability?
>
>  It would be nice to have include/unlocked-io.h and add
>  AC_CHECK_DECLS_ONCE() for all *_unlocked functions.
>
>  See gnulib/lib/unlocked-io.h
>      gnulib/m4/unlocked-io.m4
>
>  .. then you can control all the behaviour by "#include unlocked-io.h"
>  rather than change all the code in the util(s). Maybe we can use the
>  functions in more utils where we intensively print something (e.g.
>  dmesg).
>
>  I guess we don't want separate m4 file for this stuff.

Good idea.

When I tested the putchar_unlocked() was more or less equally quick
with putchar(), but I chose to squeeze even the theoretical speed out
of the printing. For now it might be best, from portability point of
view, to 's/_unlocked//' and add later some clever build time
automation which will pick the most suitable function.

--
Sami Kerola
http://www.iki.fi/kerolasa/
