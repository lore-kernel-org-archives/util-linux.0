Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeBBIhs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Feb 2018 03:37:48 -0500
Date: Fri, 2 Feb 2018 09:37:42 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: failed exec() exit codes
Message-ID: <20180202083742.dww2utw4wvpz7gzk@ws.net.home>
References: <20180201145809.jjtadzla22wlw7rv@ws.net.home>
 <201802011701.19780.sweet_f_a@gmx.de>
 <20180201202249.65v5yicgejiewwvu@ws.net.home>
 <3f789a8a-c1c3-a175-3c88-0e6d43758387@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3f789a8a-c1c3-a175-3c88-0e6d43758387@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 01, 2018 at 10:31:55PM +0100, Rüdiger Meier wrote:
> 
> 
> On 02/01/18 21:22, Karel Zak wrote:
> > On Thu, Feb 01, 2018 at 05:01:19PM +0100, Ruediger Meier wrote:
> > > On Thursday 01 February 2018, Karel Zak wrote:
> > > > Now we use on many places where commands executing another command:
> > > > 
> > > >      execvp(argv[optind], argv + optind);
> > > >      err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
> > > > 
> > > > the problem is that EXIT_FAILURE is too generic and it does not
> > > > provide any way how to detect failed exec()s.
> > > 
> > > I think you did a bit too much. I assume that these exec codes are only
> > > useful for the programs which get a "command" from the user's command
> > > line. So that the user can expect the original exit code of his
> > > wanted "command" if and only if it's not 126 or 127.
> > > 
> > > So for taskset(1) these exit codes are good but maybe not needed for
> > > swapon(1) or eject(1).
> > 
> > I know, but it seems no problem and it's good way to consolidate the
> > error message and use the came code pattern.
> 
> But isn't it just an implementation detail that we exec umount(1)? If we
> would replace that later by a library call, should we change the exit code
> again?

No, see the code. The exit code is used in our child and handled by
our waitpid(). It's not used as exit code for whole eject or swapon.
There is no visible change for users.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
