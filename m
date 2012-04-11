Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5594 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758781Ab2DKLm0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Apr 2012 07:42:26 -0400
Date: Wed, 11 Apr 2012 13:42:23 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: v2.22 wish list
Message-ID: <20120411114223.GU19784@x2.net.home>
References: <20120229154420.GD8471@x2.net.home>
 <CAG27Bk1kMB9Mw46T3Lb0DBttqDOrHU0JBTkSERd7rfL8ikvH8A@mail.gmail.com>
 <CAG27Bk0ZtUj0-7Jr4VKaQ++YzKzeqhVQsOQzYwkBPGWV1pan-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAG27Bk0ZtUj0-7Jr4VKaQ++YzKzeqhVQsOQzYwkBPGWV1pan-A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 01, 2012 at 10:51:05PM +0100, Sami Kerola wrote:
> CC: mail list.
> On Thu, Mar 1, 2012 at 22:47, Sami Kerola <kerolasa@iki.fi> wrote:
> > On Wed, Feb 29, 2012 at 16:44, Karel Zak <kzak@redhat.com> wrote:
> >> This is my v2.22 wish list. The list contains large/invasive tasks only.
> >> Comments, volunteers, .... ? ;-)
> > [snip]
> >>  * non-recursive build-system (now many files from lib/ are compileted
> >>   more than once), see:
> >>   http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297
> >
> > I gave a try to non-recursive build, and getting it to work took a bit

 In your implementation you're successfully resolved the problem with
 lib/*.c, but it's not non-recursive build.

 The non-recursive build means that there is only one Makefile.am, so
 make(1) is able to optimize compilation and SMP machines. See the old
 discussion with Flameeyel for more details.

 Your attempt could be a first step to make the build system more
 effective and maintainable. The second step (real non-recursive
 build) is more invasive.

 Notes:

  - we have SUID_{LDFLAGS,CFLAGS} so it would be better to have
    separate libcommon.la for suid utils

  - please define on $top_builddir based $($ul_libcommon_la) rather than use
    everywhere ../lib/libcommon.la

> > work meaning changes here and there. I think the preview version below
> > does what was asked, but in all honesty it is not ready be merged. The
> > change needs to be split to reasonable chunks (now single big commit).

 Yes :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
