Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28090 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933221Ab2IGMHX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Sep 2012 08:07:23 -0400
Date: Fri, 7 Sep 2012 14:07:16 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: runuser(1) and su(1) -g/-G
Message-ID: <20120907120716.GD23242@x2.net.home>
References: <20120904151843.GA6389@x2.net.home>
 <20120905123822.GZ1899@rampage>
 <20120905212804.GD1899@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120905212804.GD1899@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 05, 2012 at 05:28:04PM -0400, Dave Reisner wrote:
> > I think we're missing out on an opportunity with runuser. su insists on
> > starting a shell which, among other subtle problems, leads to the
> > largeer problem of quoting and escaping the command passed to the -c
> > flag. I think we should do something like this:

 good point

> > - separate out argument parsing to runuser and su
> > - remove most of the flags from runuser (-f, -c, -l, -, -s), add a -u
> >   flag (optional, for user)
> > - create a single common entry point for creating a session
> > - separate out the run command logic

 well, we still need to initialize the session and it would be also
 to have independent PAM setting for "login-like-session" (-l - options).

> > With a name like runuser, I would expect that its purpose would be to
> > simply run commands (and not necessarily get a shell for a user, as is
> > done with su). runuser could take non-option arguments as argv for the
> > new command so that we'd have examples like this:
> > 
> >   runuser -u notroot vi /etc/fstab
> >   runuser notroot foocmd embedded '"quotes"'
> >   runuser -u notroot foocmd has args "with spaces" sometimes
> > 
> > If you still desperately want to abuse the command to create a shell for
> > a user, then you just do that:
> > 
> >   runuser -u notroot -- /bin/sh -

 well, but it will NOT use /etc/pam.d/runuser-l

 I agree that -f -s -c are unnecessary (and -c is wrong at all...). It
 would be probably better to support:

    runuser [-u] notroot [<command> [arg]]

 and if <command> is not specified then start a shell, and if -l is
 specified create a login-like session.

> Hrmm... I had no idea that runuser was an existing command in the RedHat
> world, which makes my idea of a "mulligan" less feasible. Boo.

 Well, that's question if we (upstream) have to care about one crazy
 distro specific command. Maybe we can introduce a new command (with a
 different name) and ignore the original runuser. For good reason the
 command has not been accepted by coreutils upstream.

 Any suggestion for the new name?

    runuid
    runid
    execuser

 I have no problem to revert the runuser patch, really ;-) It was
 probably too hasty decision to merge whole my su branch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
