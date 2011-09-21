Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f52.google.com ([209.85.212.52]:57036 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab1IUQ6X (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 21 Sep 2011 12:58:23 -0400
Received: by vws10 with SMTP id 10so2806307vws.11
        for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 09:58:22 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 Sep 2011 09:58:21 -0700
Message-ID: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
Subject: libuuid clock.txt fd leaks
From: Tim Pepper <tpepper@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libuuid's gen_uuid.c:get_clock() goes to some length to try to reuse
its fd and avoid repeated opens of /var/lib/libuuid/clock.txt and also
to be thread safe.  But the current implementation must lead to fd
leakage in multithreaded applications.  This has been reported
multiple places as the gen_uuid.c file seems to have been reused in
various open source projects.  But I don't see mention of this issue
in the util-linux archives.

Some mentions I've found:
http://sourceforge.net/tracker/index.php?func=detail&aid=3276476&group_id=2406&atid=102406
https://github.com/samuel/python-gearman/pull/3
And it's come into my lap by way of some complicated Java application
I can't claim to understand, but they error on too many open files and
note via lsof that opens of clock.txt grow unbounded during their
runtime.

While googling around I also noticed the C++98 spec (well maybe
anyway...as referenced here:
http://gcc.gnu.org/onlinedocs/gcc-4.6.1/gcc/C_002b_002b98-Thread_002dLocal-Edits.html#C_002b_002b98-Thread_002dLocal-Edits)
includes the idea that things in TLS shouldn't have non-trivial
destructors.  Shows at least that somebody's thought about the
problem.  I'd guess having to have something know to do fclose() /
close() on parts of the TLS counts as non-trivial and shouldn't be
done.

The sourceforge.net link above includes a number of suggested options.
 And there's also just the simple implementation option for
get_clock() that doesn't have the fd as static much less TLS and
opens/closes at each invocation.  That maybe comes with a noticable
performance hit for some types of users and I don't really know the
full list of possible use cases here...do some people really need that
high performance uuid generation?  Either way, the "right" general
solution isn't immediately obvious to me so I thought I'd see what
others here thought...




Tim
