Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757107Ab3AYLQL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 06:16:11 -0500
Date: Fri, 25 Jan 2013 12:10:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: kerolasa@gmail.com, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] a bunch of textual fixes, plus -V for renice
Message-ID: <20130125111017.GI27413@x2.net.home>
References: <1358679376.31211.140661179923553.796CC6BD@webmail.messagingengine.com>
 <CAG27Bk0TErNurB5fOaM9=3O4Wzy6dv7Gx7oHL-vzuv=NGEiVyA@mail.gmail.com>
 <1358688927.20076.140661179956885.59525AA5@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358688927.20076.140661179956885.59525AA5@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 20, 2013 at 02:35:27PM +0100, Benno Schulenberg wrote:
> 
> Hello Sami,
> 
> On Sun, Jan 20, 2013, at 12:25, Sami Kerola wrote:
> > +       fprintf(stderr, _("%s from %s\n"),
> > +                       program_invocation_short_name, PACKAGE_STRING);
> > 
> > should use UL version printing macro.
> > 
> > +       fprintf(stderr, UTIL_LINUX_VERSION);
> 
> Ah.  Okay.  Then it is good to leave that out for now.  I will provide a
> new patch for that later.

 I have fixed this issue.

> > In the patch 0007 the renice(1) adds -V short option along side with
> > -v to print version. IMHO if the upper case option is added the lower
> > case equivalent should be dropped.
> 
> I agree -v should be dropped for --version, but I didn't want to do that
> right away.  Maybe one or two releases down the line?

 Well, we have to care about backward compatibility. It seems better
 to support (now undocumented) -v as well as new and documented -V.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
