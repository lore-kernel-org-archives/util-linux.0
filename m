Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751142AbeCGKm4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Mar 2018 05:42:56 -0500
Date: Wed, 7 Mar 2018 11:42:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: don't lock fd 1 (stdout)
Message-ID: <20180307104252.zwdcehv27fp3ny6k@ws.net.home>
References: <20180306233807.10756-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180306233807.10756-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 07, 2018 at 12:38:07AM +0100, Ruediger Meier wrote:
> This is how this patch changes the test output:
> 
> --- /tmp/a      2018-03-06 22:31:15.000000000 +0000
> +++ /tmp/b      2018-03-06 22:30:34.000000000 +0000

git-am had really difficult time to accept to your patch with patch in the patch
comment :-)

> index d1c97e0b6..8cc148fb8 100644
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -226,6 +226,8 @@ function ts_init_env {
>  	local mydir=$(ts_abspath ${0%/*})
>  	local tmp
>  
> +	shopt -s nullglob
> +

1) It seems it breaks ts/ipcs/limits:ipcs_limits_check(), the sed
   arguments in the line

    "echo \$(cat /proc/sys/kernel/shmall) / 1024 \* $PAGE_SIZE | bc -l | sed 's/\..*//'"

are ignored, so with eval it calls

    eval echo '$(cat' '/proc/sys/kernel/shmall)' / 1024 '\*' 4096 '|' bc -l '|' sed

I have added

    shopt -u nullglob 

to the function to fix the problem. It seems it works.


2) I see

            mount: btrfs (fstab)                  ...
                : btrfs                       ... OK
                : auto                        ... SKIPPED (failed to lock fstab)


 and with ./run.sh --parallel I see another "failed to lock" messages :-(


Maybe we can use --nolocks for debian-kfreebsd (TS_NOLOCKS in
tests/functions.sh).

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
