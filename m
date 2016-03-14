Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52408 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbcCNBno (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 Mar 2016 21:43:44 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: [PATCH 00/12] another BSD/OSX related patch-set
Date: Mon, 14 Mar 2016 02:43:40 +0100
Cc: util-linux@vger.kernel.org
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de> <20160308012836.GA26455@newbook>
In-Reply-To: <20160308012836.GA26455@newbook>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603140243.40546.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 08 March 2016, Isaac Dunham wrote:
> On Tue, Mar 08, 2016 at 12:11:50AM +0100, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > This is github pull request #299
> > https://github.com/karelzak/util-linux/pull/299
> >
> > Again some arbitrary BSD, OSX and musl related fixes and clean-up
>
> <snip>
>
> > For OSX one should additionally disable all utmp.h related
> > programs.
>
> FYI:
> With musl, utmpx is stubbed out and utmp is wrappers for utmpx, so
> users should disable utmp(x)-related programs and code.

> (The point is to let things build, but not use utmp because the
> maintainer considers it a fundamentally flawed idea.)
>
> Additionally, systemd is working on allowing disabling of utmp(x).

Will there be another interface to be used by last(1)?

> This seems to imply that --disable-utmp/--disable-utmpx options would
> be helpful.

Do you mean --without-utmp to build our progs without utmp or really 
disabling the build of all progs which are using utmp right now?

Actually I thought the next step could be to remove utmp and use utmpx 
only because it's POSIX and more portable. See commit d00c10ed. 

> > Almost no interesting compiler warnings left. Xcode/clang warnings
> > are a bit over the top anyways.
> >
> >
> > Ruediger Meier (12):
> >   wipefs, sfdisk: include libgen.h for basename(3p)
>
> I'm glad to see use of POSIX basename(), which is the only version
> that musl implements.

There are still two files to be fixed
  login-utils/last.c
  login-utils/su-common.c

On the other hand I thought we could also completely avoid basename(3p) 
and use something like our stripoff_last_component() from 
lib/fileutils.c.

> The way musl implements basename, strdup() is not needed, but
> following POSIX is better than relying on implementation-specific
> details.
>
> Thanks,
> Isaac Dunham
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


