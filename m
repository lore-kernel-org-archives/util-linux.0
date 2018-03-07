Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbeCGLsv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Mar 2018 06:48:51 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] tests: don't lock fd 1 (stdout)
Date: Wed, 7 Mar 2018 12:48:44 +0100
Cc: util-linux@vger.kernel.org
References: <20180306233807.10756-1-sweet_f_a@gmx.de> <20180307104252.zwdcehv27fp3ny6k@ws.net.home>
In-Reply-To: <20180307104252.zwdcehv27fp3ny6k@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803071248.45196.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
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

Oops.

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

Ah sorry, I've checked the tests only on that bsd box. I will review 
again and do it without "shopt -s nullglob". It's confusing anyways for 
test writers if the bash uses non-default options.

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

Hm, I had never really tried --parallel root checks yet because the 
non-deterministic behavior regarding udevadm and my NFS /home is 
already complicated enough for my taste ;)

Are the files unlocked automatically if we exit the test without calling 
ts_unlock?

BTW could it be better to use our own ./flock instead of the global one? 
And maybe it's possible to print separate messages for "failed to lock" 
and "timeout lock".

>
> Maybe we can use --nolocks for debian-kfreebsd (TS_NOLOCKS in
> tests/functions.sh).

Well, I had already tried to check whether /proc/*/fd is behaving like 
we expect. But seems difficult to find out. Maybe just the stupid way, 
like:

  if root && ! Linux; then parallel=1 
  if ! Linux; then TS_NOLOCKS=yes

cu,
Rudi

