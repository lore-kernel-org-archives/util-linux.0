Return-Path: d@falconindy.com
Date: Wed, 5 Sep 2012 08:38:22 -0400
From: Dave Reisner <d@falconindy.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Ludwig Nussel <ludwig.nussel@suse.de>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Subject: Re: runuser(1) and su(1) -g/-G
Message-ID: <20120905123822.GZ1899@rampage>
References: <20120904151843.GA6389@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120904151843.GA6389@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 04, 2012 at 05:18:43PM +0200, Karel Zak wrote:
> 
>  Hi,
> 
> I did some changes to the su(1):
> 
>   - add --group= option to specify the primary group
>   - add --supp-group= option to specify a supplemental group
> 
> the both options are based on Fedora runuser(1) patch and it's
> available for root only (non-root cannot specify any groups).
> 
> 
> I have also added new command runuser(1) -- it's completely based on
> su(1) code. The difference is that runuser does not ask for password,
> has to be executed by root and it uses different PAM configuration
> (/etc/pam.d/runuser[-l]).
> 
> The changes should be available in v2.23 (or easily backported to
> 2.22, I'll do that for Fedora).
> 
> See master branch and "git whatchanged login-utils/".
> 
>     Karel
> 

Hi Karel,

I think we're missing out on an opportunity with runuser. su insists on
starting a shell which, among other subtle problems, leads to the
largeer problem of quoting and escaping the command passed to the -c
flag. I think we should do something like this:

- separate out argument parsing to runuser and su
- remove most of the flags from runuser (-f, -c, -l, -, -s), add a -u
  flag (optional, for user)
- create a single common entry point for creating a session
- separate out the run command logic

With a name like runuser, I would expect that its purpose would be to
simply run commands (and not necessarily get a shell for a user, as is
done with su). runuser could take non-option arguments as argv for the
new command so that we'd have examples like this:

  runuser -u notroot vi /etc/fstab
  runuser notroot foocmd embedded '"quotes"'
  runuser -u notroot foocmd has args "with spaces" sometimes

If you still desperately want to abuse the command to create a shell for
a user, then you just do that:

  runuser -u notroot -- /bin/sh -

I can't make any guarantees that I'll be able to offers patches for this
myself, but I'll definitely be taking a look if I have some free time.
Just thought I'd bring up the idea, since it's always been a pet peeve
of mine to fix if ever there were an opportunity for a mulligan on su
(and this is it!).

Cheers,
Dave
