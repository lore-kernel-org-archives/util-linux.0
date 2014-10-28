Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:57861 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946AbaJ1BJp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 21:09:45 -0400
Message-ID: <544EECC9.2000300@gmx.com>
Date: Mon, 27 Oct 2014 21:09:29 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net> <1414444693-16407-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1414444693-16407-4-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/27/2014 05:18 PM, Benno Schulenberg wrote:
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  sys-utils/hwclock.8.in |   73 +++++++++++++++++++++++-------------------------
>  1 files changed, 35 insertions(+), 38 deletions(-)
> 
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index 30f191b..9219218 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -1,4 +1,4 @@
> -.TH HWCLOCK 8 "July 2014" "util-linux" "System Administration"
> +.TH HWCLOCK 8 "October 2014" "util-linux" "System Administration"
>  .SH NAME
>  hwclock \- query or set the hardware clock (RTC)
>  .SH SYNOPSIS
> @@ -22,15 +22,16 @@ gains time at a certain rate when left to run).
>  Since v2.26
>  .B hwclock
>  does not update the Hardware Clock's drift factor in @ADJTIME_PATH@ by default.
> -It is necessary to use \fB\-\-update-drift\fR, with \fB\-\-set\fR or
> +It is necessary to use the option \fB\-\-update-drift\fR, with \fB\-\-set\fR or
>  \fB\-\-systohc\fR, to force drift factor updates.

The rest of the manual uses 'the --xxxx option'.

>  
>  Since v2.26
>  .B hwclock \-\-hctosys
> -automatically compensates time read from the Hardware Clock to account for
> -systematic drift before using it to set the System Clock.  Therefore,
> -\fB\-\-adjust\fR is no longer necessary during boot. This functionality makes
> -hwclock usable early in the boot process when the root filesystem is read-only.
> +automatically takes a systematic drift of the Hardware Clock into account,
> +setting the System Clock to the drift-compensated time.  Therefore the option
> +\fB\-\-adjust\fR is no longer necessary during boot.  This feature makes
> +.B hwclock
> +usable early on in the boot process when the root filesystem is read-only.

"a systematic drift"? That entire phrase does not sound natural to me.

You've re-injected the ambiguity of Karel's original sentence.  Hwclock has always
compensated for drift by *setting* the Hardware Clock.  I think it is important to
stress that *the_time_read* from the Clock is what is being compensated as this is
a new behavior.  Other than setting hwclock to bold, I don't see any of this change
as an improvement.

Thank you for fixing the other formatting issues.


 
