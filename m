Return-Path: util-linux-owner@vger.kernel.org
Received: from anakin.london.02.net ([87.194.255.134]:45931 "EHLO
	anakin.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab2IGNSv convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Sep 2012 09:18:51 -0400
From: Adam Sampson <ats@offog.org>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>
Subject: Re: runuser(1) and su(1) -g/-G
References: <20120904151843.GA6389@x2.net.home>
	<20120905123822.GZ1899@rampage> <20120905212804.GD1899@rampage>
	<20120907120716.GD23242@x2.net.home> <5049EB15.3080309@draigBrady.com>
Date: Fri, 07 Sep 2012 14:09:47 +0100
In-Reply-To: <5049EB15.3080309@draigBrady.com> (=?utf-8?Q?=22P=C3=A1draig?=
 Brady"'s message of
	"Fri, 07 Sep 2012 13:39:49 +0100")
Message-ID: <y2a4nnahtd0.fsf@cartman.at.offog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Pádraig Brady <P@draigBrady.com> writes:

> setuidgid
>   coreutils internal only

The name setuidgid for this tool was introduced by daemontools, and
various other projects have have their own versions of it:

  http://cr.yp.to/daemontools/setuidgid.html
  http://www.skarnet.org/software/s6/s6-setuidgid.html
  http://b0llix.net/perp/site.cgi?page=runuid.8
  http://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=blob;f=src/setuidgid.c
  http://offog.org/darcs/freedt/setuidgid.c

(It would often be helpful for the tool to do a bit more than just
setting the uid and gids -- e.g. setting $HOME...)

perp has a suite of "runtools" like this that do some sort of
environment setup before execing another program:

  http://b0llix.net/perp/site.cgi?page=manual

The most useful ones (for me!) have equivalents in util-linux already:

- runsession is setsid;

- runlimit is prlimit;

- runlock is flock -- but flock only has an su-style -c argument, so it
  would probably be worth fixing that at the same time as runuser?

Thanks,

-- 
Adam Sampson <ats@offog.org>                         <http://offog.org/>
