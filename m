Return-Path: d@falconindy.com
Date: Fri, 7 Sep 2012 08:47:51 -0400
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: runuser(1) and su(1) -g/-G
Message-ID: <20120907124751.GG1899@rampage>
References: <20120904151843.GA6389@x2.net.home>
 <20120905123822.GZ1899@rampage>
 <20120905212804.GD1899@rampage>
 <20120907120716.GD23242@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120907120716.GD23242@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 07, 2012 at 02:07:16PM +0200, Karel Zak wrote:
> On Wed, Sep 05, 2012 at 05:28:04PM -0400, Dave Reisner wrote:
> > > I think we're missing out on an opportunity with runuser. su insists on
> > > starting a shell which, among other subtle problems, leads to the
> > > largeer problem of quoting and escaping the command passed to the -c
> > > flag. I think we should do something like this:
> 
>  good point
> 
> > > - separate out argument parsing to runuser and su
> > > - remove most of the flags from runuser (-f, -c, -l, -, -s), add a -u
> > >   flag (optional, for user)
> > > - create a single common entry point for creating a session
> > > - separate out the run command logic
> 
>  well, we still need to initialize the session and it would be also
>  to have independent PAM setting for "login-like-session" (-l - options).
> 
> > > With a name like runuser, I would expect that its purpose would be to
> > > simply run commands (and not necessarily get a shell for a user, as is
> > > done with su). runuser could take non-option arguments as argv for the
> > > new command so that we'd have examples like this:
> > > 
> > >   runuser -u notroot vi /etc/fstab
> > >   runuser notroot foocmd embedded '"quotes"'
> > >   runuser -u notroot foocmd has args "with spaces" sometimes
> > > 
> > > If you still desperately want to abuse the command to create a shell for
> > > a user, then you just do that:
> > > 
> > >   runuser -u notroot -- /bin/sh -
> 
>  well, but it will NOT use /etc/pam.d/runuser-l
>
>  I agree that -f -s -c are unnecessary (and -c is wrong at all...). It
>  would be probably better to support:
> 
>     runuser [-u] notroot [<command> [arg]]
> 
>  and if <command> is not specified then start a shell, and if -l is
>  specified create a login-like session.

I like all this.

> 
> > Hrmm... I had no idea that runuser was an existing command in the RedHat
> > world, which makes my idea of a "mulligan" less feasible. Boo.
> 
>  Well, that's question if we (upstream) have to care about one crazy
>  distro specific command. Maybe we can introduce a new command (with a
>  different name) and ignore the original runuser. For good reason the
>  command has not been accepted by coreutils upstream.
> 
>  Any suggestion for the new name?
> 
>     runuid
>     runid
>     execuser

I'm digging deep, back to my windows admin days -- perhaps 'runas'?
Maybe something shorter? Could we use 'ru' (a step back!) for irony? ;P

>  I have no problem to revert the runuser patch, really ;-) It was
>  probably too hasty decision to merge whole my su branch.
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
