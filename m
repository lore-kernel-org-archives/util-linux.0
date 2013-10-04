Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44493 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab3JDLgC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Oct 2013 07:36:02 -0400
Date: Fri, 4 Oct 2013 13:35:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] clean up term lib handling
Message-ID: <20131004113559.GE14360@x2.net.home>
References: <1380429883-25187-1-git-send-email-vapier@gentoo.org>
 <20130930130718.GN5101@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130930130718.GN5101@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 30, 2013 at 03:07:18PM +0200, Karel Zak wrote:
> 
>  I have applied the patch, but now when play with it I see that
> 
> On Sun, Sep 29, 2013 at 12:44:43AM -0400, Mike Frysinger wrote:
> > With a minor tweak to how tinfo is handled, we can do the same thing -- we
> > just always use TINFO_LIBS in the Makefile's.
> 
> you have introduced unnecessary dependence on ncurses for utils where
> was "ifdef tinfo *else* ncurses"

...

>  Maybe we need to revert back to 
> 
>    AM_CONDITIONAL([HAVE_TINFO], [test "x$have_tinfo" = xyes])

 Done. It also seems that we can use pkg-config for tinfo.

 Please, test the changes in your environment. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
