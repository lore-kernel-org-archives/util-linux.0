Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60966 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750960AbcLFXkm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 18:40:42 -0500
Subject: Re: [PATCH 1/2] Revert "hwclock: don't allow non-root access"
To: Marian Vomir <marian.vomir@ni.com>, util-linux@vger.kernel.org
References: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c0ddbe5a-caa4-c8ad-0d86-9b13c3277edc@gmx.com>
Date: Tue, 6 Dec 2016 18:40:32 -0500
MIME-Version: 1.0
In-Reply-To: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 12/06/2016 01:06 PM, Marian Vomir wrote:
> This reverts commit 687cc5d58942b24a9f4013c68876d8cbea907ab1.
> 
> There are cases when an unprivileged user wants to set the hardware clock.

This has never been allowed in over two decades of hwclock. I cannot
think of a legitimate reason to allow setting the Hardware Clock by a
normal user.

Having said that, while I agree with Karel's desire to remove all
mention of running hwclock with setuid, IMO the code should not have
been removed. Despite the comment directly above it, that code has
nothing to do with hwclock being run with setuid.

I would argue that there are some hwclock options intended for normal
users. A normal users should at least be able to display the Hardware
Clock time. In development of hwclock I use --test as a normal user for
all functions, including set function.


> The solution is to use capabilities, specifically CAP_SYS_TIME in this case.
> ---
>  sys-utils/hwclock.8.in | 15 +++++++++++++++
>  sys-utils/hwclock.c    | 34 +++++++++++++++++++++++++++++-----
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index dec7902..5a7f762 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -577,6 +577,21 @@ This second field is not used under Linux and is always zero.
>  See also
>  .BR \%settimeofday (2).
>  .
> +.SS User access and setuid
> +.PP
> +Sometimes, you need to install
> +.B \%hwclock
> +setuid root.  If you want users other than the superuser to be able to
> +display the clock value using the direct ISA I/O method, install it setuid
> +root.  If you have the rtc device interface on your system, or are on a non-ISA
> +compatible system, there is probably no need for users to have the direct
> +ISA I/O method, so do not bother.  See the
> +.BR \-\-rtc " option."
> +.PP
> +In any case, \fBhwclock\fR will not allow you to set anything unless you have the
> +superuser real uid.  (This restriction is not necessary if you haven't
> +installed setuid root, but it's there for now.)
> +.
>  .SS Hardware Clock Access Methods
>  .PP
>  .B \%hwclock
> diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
> index 4b201d7..880ba78 100644
> --- a/sys-utils/hwclock.c
> +++ b/sys-utils/hwclock.c
> @@ -1633,6 +1633,8 @@ int main(int argc, char **argv)
>  	 * fractions.
>  	 */
>  	time_t set_time = 0;	/* Time to which user said to set Hardware Clock */
> +
> +	bool permitted;		/* User is permitted to do the function */
>  	int rc, c;
>  
>  	/* Variables set by various options; show may also be set later */
> @@ -1861,11 +1863,6 @@ int main(int argc, char **argv)
>  	argc -= optind;
>  	argv += optind;
>  
> -	if (getuid() != 0) {
> -		warnx(_("Sorry, only the superuser can use the Hardware Clock."));
> -		hwclock_exit(EX_NOPERM);
> -	}
> -
>  #ifdef HAVE_LIBAUDIT
>  	if (testing != TRUE) {
>  		if (adjust == TRUE || hctosys == TRUE || systohc == TRUE ||
> @@ -1907,6 +1904,28 @@ int main(int argc, char **argv)
>  	      | setepoch | predict | compare | get))
>  		show = 1;	/* default to show */
>  
> +	if (getuid() == 0)
> +		permitted = TRUE;
> +	else {
> +		/* program is designed to run setuid (in some situations) */
> +		if ((set || systohc || adjust) && !testing) {
> +			warnx(_("Sorry, only the superuser can change "
> +				"the Hardware Clock."));
> +			permitted = FALSE;
> +		} else if ((systz || hctosys) && !testing) {
> +			warnx(_("Sorry, only the superuser can change "
> +				"the System Clock."));
> +			permitted = FALSE;
> +		} else if (setepoch && !testing) {
> +			warnx(_("Sorry, only the superuser can change the "
> +				"Hardware Clock epoch in the kernel."));
> +			permitted = FALSE;
> +		} else
> +			permitted = TRUE;
> +	}
> +
> +	if (!permitted)
> +		hwclock_exit(EX_NOPERM);
>  
>  #ifdef __linux__
>  	if (getepoch || setepoch) {
> @@ -2009,6 +2028,11 @@ void __attribute__((__noreturn__)) hwaudit_exit(int status)
>   * with any functions by these names, you will have unresolved external
>   * references when you link.
>   *
> + * The program is designed to run setuid superuser, since we need to be able
> + * to do direct I/O. (More to the point: we need permission to execute the
> + * iopl() system call). (However, if you use one of the methods other than
> + * direct ISA I/O to access the clock, no setuid is required).
> + *
>   * Here's some info on how we must deal with the time that elapses while
>   * this program runs: There are two major delays as we run:
>   *
> 
