Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f54.google.com ([209.85.160.54]:56731 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab3LSKaI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 19 Dec 2013 05:30:08 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so969371pbc.41
        for <util-linux@vger.kernel.org>; Thu, 19 Dec 2013 02:30:07 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1387406874.28811.61304297.734D6974@webmail.messagingengine.com>
References: <1387274534.32475.60577705.14EC62A9@webmail.messagingengine.com>
	<CAG27Bk096iW65aEUApwHtJqMRY9zyiN0MpHao+jvJvjkEcP-jA@mail.gmail.com>
	<1387406874.28811.61304297.734D6974@webmail.messagingengine.com>
Date: Thu, 19 Dec 2013 10:30:07 +0000
Message-ID: <CAG27Bk3kBSsebBN1w9CMP1RWG6vJGmLs35Tx3hzvbTd9WkPeNA@mail.gmail.com>
Subject: Re: [patch] adding --no-wrap to msgmerge
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18 December 2013 22:47, Benno Schulenberg <bensberg@justemail.net> wrote:
> Although, now, during ./autogen.sh, I get the following warning:
>
> configure.ac:149: warning: The 'AM_PROG_MKDIR_P' macro is deprecated, and its use is discouraged.
> configure.ac:149: You should use the Autoconf-provided 'AC_PROG_MKDIR_P' macro instead,
> configure.ac:149: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your Makefile.am fi

Yes, that is coming from gettext. I have hunch the error is expected.
See link below for details.

http://git.savannah.gnu.org/cgit/gettext.git/commit/gettext-tools/po?id=c35de4365ac8f7a87b62b85a35eb122f79cb12ad

I'm sure bug-gnu-gettext@gnu.org can make just call if the $(mkdir_p)
should replaced with $(MKDIR_P), and if the gettext should attempt to
find the value for the macro.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
