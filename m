Return-Path: util-linux-owner@vger.kernel.org
Received: from canardo.mork.no ([148.122.252.1]:38173 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbcK1QLq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 28 Nov 2016 11:11:46 -0500
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 0/2] sulogin: fixing Control-D and --timeout
Date: Mon, 28 Nov 2016 17:11:26 +0100
Message-Id: <20161128161128.2657-1-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I recently discovered that sulogin in Debian stretch didn't time out,
and even was unresponsive to EOF after the failed timeout.  This was
reported as Debian bugs:

 https://bugs.debian.org/846107
 https://bugs.debian.org/846112

since I assumed it was a problem with the Debian migration to
util-linux sulogin.

But then I checked the upstream repo and was surprised to find the
same bugs there...  I don't know how these have crept in, or how to
properly fix them.  But from looking at the code, it is pretty clear
that getpasswd() must return NULL if the main program is supposed to
exit.  It is also clear that getpasswd() must return immediately if
the read() is interrupted by a SIGALRM, without waiting for any
further keypress.

I do not know if pressing any key is supposed to reset the alarm, but
it if is then I believe that should be done with an explicit alarm()
on every keypress.

So here are two basic oneline fixes for these issues. The testing
state is: Works for me.


Note that I tried to be consistent with the existing code, using
(char *)0 instead of NULL.  It looks odd, but...



Bjørn Mork (2):
  sulogin: make --timeout actually time out
  sulogin: make Control-D break out of the main loop

 login-utils/sulogin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.10.2

