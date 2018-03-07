Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: don't lock fd 1 (stdout)
Date: Wed, 7 Mar 2018 15:31:19 +0100
Cc: util-linux@vger.kernel.org
References: <20180306233807.10756-1-sweet_f_a@gmx.de> <20180307104252.zwdcehv27fp3ny6k@ws.net.home>
In-Reply-To: <20180307104252.zwdcehv27fp3ny6k@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803071531.19865.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 March 2018, Karel Zak wrote:
> On Wed, Mar 07, 2018 at 12:38:07AM +0100, Ruediger Meier wrote:
> > This is how this patch changes the test output:
> >
> > --- /tmp/a      2018-03-06 22:31:15.000000000 +0000
> > +++ /tmp/b      2018-03-06 22:30:34.000000000 +0000
>
> git-am had really difficult time to accept to your patch with patch
> in the patch comment :-)
>
> > index d1c97e0b6..8cc148fb8 100644
> > --- a/tests/functions.sh
> > +++ b/tests/functions.sh
> > @@ -226,6 +226,8 @@ function ts_init_env {
> >  	local mydir=$(ts_abspath ${0%/*})
> >  	local tmp
> >
> > +	shopt -s nullglob
> > +
>
> 1) It seems it breaks ts/ipcs/limits:ipcs_limits_check(), the sed
>    arguments in the line
>
>     "echo \$(cat /proc/sys/kernel/shmall) / 1024 \* $PAGE_SIZE | bc
> -l | sed 's/\..*//'"
>
> are ignored, so with eval it calls
>
>     eval echo '$(cat' '/proc/sys/kernel/shmall)' / 1024 '\*' 4096 '|'
> bc -l '|' sed
>
> I have added
>
>     shopt -u nullglob
>
> to the function to fix the problem. It seems it works.
>
>
> 2) I see
>
>             mount: btrfs (fstab)                  ...
>
>                 : btrfs                       ... OK
>                 : auto                        ... SKIPPED (failed to
>                 : lock fstab)
>
>  and with ./run.sh --parallel I see another "failed to lock" messages
> :-(

This seems independent of my patch. The test-suite does not survive when 
flock timeouts after 30s because then ts_cleanup_on_exit() may use 
resources (e.g. rmmod scsi_debug) while not having the lock. You will 
see it even better when using

  flock --exclusive --timeout 1

I'm going to fix that and send patches.

>
> Maybe we can use --nolocks for debian-kfreebsd (TS_NOLOCKS in
> tests/functions.sh).
