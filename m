Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757338AbaCDMvO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Mar 2014 07:51:14 -0500
Date: Tue, 4 Mar 2014 13:50:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] logger: allow user to send structured journald messages
Message-ID: <20140304125058.GJ32036@x2.net.home>
References: <1393010730-25126-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393010730-25126-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 21, 2014 at 07:25:30PM +0000, Sami Kerola wrote:
>  bash-completion/logger   |  4 +--
>  configure.ac             | 16 ++++++++++++
>  misc-utils/Makemodule.am |  4 +++
>  misc-utils/logger.1      | 29 ++++++++++++++++++++-
>  misc-utils/logger.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 115 insertions(+), 4 deletions(-)

 Fixed & applied, thanks.

> +AC_ARG_ENABLE([journald],
> +  AS_HELP_STRING([--enable-journald], [add journald support to logger]),
> +  [], [enable_journald=no]
> +)
> +have_journald=no
> +AS_IF([test "x$enable_journald" = xyes], [
> +  PKG_CHECK_MODULES([SYSTEMD_JOURNAL], [libsystemd-journal], [], [
> +    AC_MSG_ERROR([cannot find libsystemd-journal support])
> +  ])
> +  have_journald=yes
> +  AC_DEFINE([HAVE_JOURNALD], [1], [Define if journald is available])
> +])
> +AM_CONDITIONAL([HAVE_JOURNALD], [test "x$have_journald" = xyes])

 Hmm, the latest systemd release merged all the libs to the one
 libsystemd, so it will be necessary to improve our configure.ac
 
 ... probably just add --enable-systemd and have_systemd= and 
 add fallbacks old versions with libsystemd-{journal,daemon} and
 remove --enable-journald etc.

> +	iovec = malloc(vectors * sizeof(struct iovec));

 xalloc.h :-)

> +	if (jfd) {
> +		int ret = journald_entry(jfd);
> +		if (stdin != jfd)
> +			fclose(jfd);
> +		if (ret == 0)
> +			return EXIT_SUCCESS;
> +		return EXIT_FAILURE;
> +	}

 #ifdef HAVE_JOURNALD ^^^

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
