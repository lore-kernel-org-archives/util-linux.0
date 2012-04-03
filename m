Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502Ab2DCOCL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Apr 2012 10:02:11 -0400
Date: Tue, 3 Apr 2012 16:01:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 13/20] uuidd: add systemd unit files
Message-ID: <20120403140140.GK1084@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-14-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333039528-24784-14-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 06:45:21PM +0200, Petr Uzel wrote:
> +AC_ARG_WITH([systemdsystemunitdir],
> +  AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [directory for systemd service files]),

 systemdsystemunitdir ???

 Don't use German dictionary as inspiration, words maybe short :-)

 --with-unitdir=DIR

> +  [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
> +
> +if test "x$with_systemdsystemunitdir" != "xno"; then
> +  AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
> +fi
> +
> +AM_CONDITIONAL(WITH_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])

 Is it necessary? Shouldn't be --enable-socket-activation enough?

> +if WITH_SYSTEMD
> +systemdsystemunit_DATA = \

 unitdir_DATA=

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
