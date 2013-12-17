Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64865 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3LQRQC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Dec 2013 12:16:02 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so7234597pbc.35
        for <util-linux@vger.kernel.org>; Tue, 17 Dec 2013 09:16:02 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1387274534.32475.60577705.14EC62A9@webmail.messagingengine.com>
References: <1387274534.32475.60577705.14EC62A9@webmail.messagingengine.com>
Date: Tue, 17 Dec 2013 17:16:02 +0000
Message-ID: <CAG27Bk096iW65aEUApwHtJqMRY9zyiN0MpHao+jvJvjkEcP-jA@mail.gmail.com>
Subject: Re: [attempt at patch] adding --no-wrap to msgmerge
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 17 December 2013 10:02, Benno Schulenberg <bensberg@justemail.net> wrote:
> Attached is a patch that should add the option --no-wrap to the runs
> of msgmerge (after a renewal of the POT file) to reduce the number
> of spurious differences.
>
> However, I can't get the thing to work here.  When i run autogen.sh
> it says "Copying file po/Makefile.in.in", and when I then look in that
> file it mentions "# Origin: gettext-0.14".  But the only Makefile.in.in
> I have on this testing system is /usr/share/gettext/po/Makefile.in.in
> and in that file it says "# Origin: gettext-0.18".  (That version is needed,
> otherwise it doesn't know the MSGMERGE_OPTIONS variable.)
>
> So... where does autogen.sh/autopoint take its Makefile.in.in from?

Hi Benno,

I think the change should include configure.ac update to require
gettext version 0.18.

-- snip
diff --git a/configure.ac b/configure.ac
index 8665780..5444cd3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -145,7 +145,7 @@ UL_SET_ARCH([HPPA], [hppa*])

 AC_SYS_LARGEFILE

-AM_GNU_GETTEXT_VERSION([0.14.1])
+AM_GNU_GETTEXT_VERSION([0.18])
 AM_GNU_GETTEXT([external])

 AS_IF([test -d "$srcdir/po"], [
-- snip

Feel free to add when resubmitting.

Acked-by: Sami Kerola <kerolasa@iki.fi>

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
