Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53308 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbbCRAaB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 20:30:01 -0400
Message-ID: <5508C704.1060500@gmx.com>
Date: Tue, 17 Mar 2015 20:29:56 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] hwclock: fix spelling, punctuation and formatting
 mistakes in the man page
References: <1426624493-2464-1-git-send-email-bensberg@justemail.net> <1426624493-2464-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1426624493-2464-3-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/17/2015 04:34 PM, Benno Schulenberg wrote:
> Also improve some wordings.
> 
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  sys-utils/hwclock.8.in |   78 +++++++++++++++++++++++------------------------
>  1 files changed, 38 insertions(+), 40 deletions(-)
> 
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index 145e089..a884ccc 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -23,16 +23,15 @@ Hardware Clock values based on its drift rate.
>  .PP
>  Since v2.26 important changes were made to the
>  .B \-\-hctosys
> -function, the
> +function and the
>  .B \-\-directisa
>  option, and a new option
>  .B \-\-update\-drift
> -was added. See their respective sections below.
> +was added.  See their respective descriptions below.

What guide says this is the proper style for an inline list?
What guide says that its current form is incorrect?

>  .
>  .SH FUNCTIONS
>  The following functions are mutually exclusive, only one can be given at
> -a time. If none are given the default is
> -.BR \-\-show .
> +a time.  If none is given, the default is \fB\-\-show\fR.

We've already been through this; 'none' in this context is plural and
countable, justifying the use of a plural verb. Do you want me to quote
your reference again? Secondly, I took the time to remove inline font
escapes, because I find using macros easier to maintain.

>  .TP
>  .B \-\-adjust
>  Add or subtract time from the Hardware Clock to account for systematic
> @@ -59,9 +58,9 @@ that the year counter in your Hardware Clock contains the number of
>  full years since 1952, then the kernel's Hardware Clock epoch value
>  must be 1952.
>  .sp
> -The set function requires using the
> +The \fB\%\-\-setepoch\fR function requires using the
>  .B \%\-\-epoch
> -option.
> +option to specify the year.

This is completely unnecessary verbosity.

>  .sp
>  This epoch value is used whenever
>  .B \%hwclock
> @@ -123,7 +122,7 @@ function does this based upon the information in the
>  .I @ADJTIME_PATH@
>  file or the command line arguments
>  .BR \%\-\-localtime " and " \-\-utc .
> -Note: no daylight saving adjustment is made. See the discussion below under
> +Note: no daylight saving adjustment is made.  See the discussion below, under
>  .BR "LOCAL vs UTC" .
>  .sp
>  The kernel also keeps a timezone value, the
> @@ -153,7 +152,7 @@ This is a good function to use in one of the system startup scripts before the
>  file systems are mounted read/write.
>  .sp
>  This function should never be used on a running system. Jumping system time
> -will cause problems, such as, corrupted filesystem timestamps.  Also, if
> +will cause problems, such as corrupted filesystem timestamps.  Also, if
>  something has changed the Hardware Clock, like NTP's \%'11\ minute\ mode', then
>  .B \%\-\-hctosys
>  will set the time incorrectly by including drift compensation.
> @@ -230,9 +229,9 @@ changed then a reboot would be required to inform the kernel.
>  .BR \-w , \ \-\-systohc
>  Set the Hardware Clock from the System Clock, and update the timestamps in
>  .IR @ADJTIME_PATH@ .
> -With the
> +When the
>  .B --update-drift
> -option (re)calculate the drift factor.
> +option is given, then also (re)calculate the drift factor.

Again, unnecessary verbosity.

>  .
>  .TP
>  .BR \-V , \ \-\-version
> @@ -298,7 +297,7 @@ The value of this option is used as an argument to the
>  option.  For example:
>  .RS
>  .IP "" 4
> -.BI "\%hwclock\ \-\-set\ \-\-date='" 2011-08-14\ 16:45:05 '
> +.B "hwclock\ \-\-set\ \-\-date='2011-08-14\ 16:45:05'

It is common practice for option arguments to be in italic. I've already
explained to you that the soft hyphen prevents this command structure
from wrapping on narrow windows when multitasking.

>  .PP
>  The argument must be in local time, even if you keep your Hardware Clock in
>  UTC.  See the
> @@ -381,7 +380,7 @@ as recorded in
>  will be used.  If the adjtime file doesn't exist, the default is UTC.
>  .sp
>  Note: daylight saving time changes may be inconsistent when the
> -Hardware Clock is kept in local time. See the discussion below under
> +Hardware Clock is kept in local time.  See the discussion below, under
>  .BR "LOCAL vs UTC" .
>  .
>  .TP
> @@ -447,9 +446,9 @@ option to be used.  See the discussion below, under
>  .TP
>  .B \-\-arc
>  This option is equivalent to
> -.BI \%\-\-epoch= 1980
> +.B \%\-\-epoch=1980

Option arguments should be in italic.

>  and is used to specify the most common epoch on Alphas
> -with ARC console (but Ruffians have an epoch of 1900).
> +with an ARC console (although Ruffians have an epoch of 1900).
>  .
>  .TP
>  .BI \-\-epoch= year
> @@ -462,7 +461,7 @@ option to set the kernel's idea of the epoch of the Hardware Clock.
>  For example, on a Digital Unix machine:
>  .RS
>  .IP "" 4
> -.BI hwclock\ \-\-setepoch\ \-\-epoch= 1952
> +.B hwclock\ \-\-setepoch\ \-\-epoch=1952

Option arguments should be in italic.

>  .RE
>  .
>  .TP
> @@ -481,15 +480,15 @@ is mounted.
>  option is used for Jensen models;
>  .B \%\-\-funky\-toy
>  means that the machine requires the UF bit instead of the UIP bit in
> -the Hardware Clock to detect a time transition.  "Toy" in the option
> +the Hardware Clock to detect a time transition.  The "toy" in the option

What style guide is this from? Unnecessary, you're making changes for
the sake of making changes.

>  name refers to the Time Of Year facility of the machine.
>  .
>  .TP
>  .B \-\-srm
>  This option is equivalent to
> -.BI \%\-\-epoch= 1900
> +.B \%\-\-epoch=1900

Option arguments should be in italic.

>  and is used to specify the most common epoch on Alphas
> -with SRM console.
> +with an SRM console.
>  .
>  .SH NOTES
>  .
> @@ -556,11 +555,11 @@ file, as explained in the man page for
>  However, some programs and fringe parts of the Linux kernel such as filesystems
>  use the kernel's timezone value.  An example is the vfat filesystem.  If the
>  kernel timezone value is wrong, the vfat filesystem will report and set the
> -wrong timestamps on files. Another example is the kernel's NTP \%'11\ minute\ mode.'
> +wrong timestamps on files.  Another example is the kernel's NTP \%'11\ minute\ mode'.
>  If the kernel's timezone value and/or the
>  .I \%persistent_clock_is_local
>  variable are wrong, then the Hardware Clock will be set incorrectly
> -by \%'11\ minute\ mode.'  See the discussion below, under
> +by \%'11\ minute\ mode'.  See the discussion below, under
>  .BR "Automatic Hardware Clock Synchronization by the Kernel" .
>  .PP
>  .B \%hwclock
> @@ -588,7 +587,7 @@ compatible system, there is probably no need for users to have the direct
>  ISA I/O method, so do not bother.  See the
>  .BR \-\-rtc " option."
>  .PP
> -In any case, hwclock will not allow you to set anything unless you have the
> +In any case, \fBhwclock\fR will not allow you to set anything unless you have the

I'd prefer macros.

>  superuser real uid.  (This restriction is not necessary if you haven't
>  installed setuid root, but it's there for now.)
>  .
> @@ -781,7 +780,7 @@ Hardware Clock timescale configuration is changed, then a reboot is required to
>  notify the kernel.
>  .PP
>  .B \%hwclock\ \-\-adjust
> -should not be used with NTP \%'11\ minute\ mode.'
> +should not be used with NTP \%'11\ minute\ mode'.
>  .
>  .SS ISA Hardware Clock Century value
>  .PP
> @@ -809,15 +808,15 @@ are supported by the hardware.
>  .PP
>  This discussion is based on the following conditions:
>  .IP \(bu 2
> -Nothing is running that alters the date-time clocks, e.g.,
> -.BR \%ntpd "(1), cron jobs, et al."
> +Nothing is running that alters the date-time clocks, as for example
> +.BR \%ntpd "(1) or a cron job."

s/as for example/for example/

http://www.merriam-webster.com/dictionary/e.g.

>  .IP \(bu 2
> -The system timezone is configured for the correct local time.  See below
> +The system timezone is configured for the correct local time.  See below, under
>  .BR "POSIX vs 'RIGHT'" .
>  .IP \(bu 2
> -Early in startup the following are called in this order:
> +Early during startup the following are called, in this order:
>  .br
> -.BI \%adjtimex\ \-\-tick \ <value>\  \-\-frequency \ <value>
> +.BI \%adjtimex\ \-\-tick \ value\  \-\-frequency \ value

How does the reader know they do not literally enter 'value'?

>  .br
>  .B \%hwclock\ \-\-hctosys
>  .IP \(bu 2
> @@ -842,8 +841,7 @@ different for each of them.  However, most systems are configured to
>  exchange values between these two clocks at startup and shutdown.  Now
>  the individual device's time keeping errors are transferred back and
>  forth between each other.  Attempt to configure drift correction for only
> -one of them, and the other's drift will be overlaid upon it.  If the big
> -picture is not kept in mind, confusion will soon ensue.
> +one of them, and the other's drift will be overlaid upon it.

This is true and valuable information. I know from experience.

>  .PP
>  This problem can be avoided when configuring drift correction for the
>  System Clock by simply not shutting down the machine.  This, plus the
> @@ -855,11 +853,11 @@ should be done first.
>  .PP
>  The System Clock drift is corrected with the
>  .BR \%adjtimex "(8) command's " \-\-tick " and " \%\-\-frequency
> -options.  These two work together, tick is the course adjustment and
> -frequency is the fine adjustment. (For system that do not have an
> +options.  These two work together; tick is the coarse adjustment and
> +frequency is the fine adjustment.  (For systems that do not have an

Improper use of a semicolon, "These two work together" is incomplete.

>  .BR \%adjtimex " package,"
> -.BI \%ntptime\ \-f\  <ppm>
> -may be use instead.)
> +.BI \%ntptime\ \-f\  ppm
> +may be used instead.)

How does the reader know they do not literally enter 'ppm'?

>  .PP
>  Some Linux distributions attempt to automatically calculate the System
>  Clock drift with
> @@ -887,27 +885,27 @@ Once the System Clock is ticking smoothly, move on to the Hardware Clock.
>  .PP
>  As a rule, cold drift will work best for most use cases.  This should be
>  true even for 24/7 machines whose normal downtime consists of a reboot.
> -In that case the drift factor value makes little difference, but on the
> -rare occasion that the machine is shutdown for an extended period then
> +In that case the drift factor value makes little difference.  But on the
> +rare occasion that the machine is shut down for an extended period, then
>  cold drift should yield better results.
>  .PP
>  .B Steps to calculate cold drift:
>  .IP 1 2
> -.RB "Confirm that " ntpd "(1) will not be launched at startup."
> +.RB "Ensure that " ntpd "(1) will not be launched at startup."

They were instructed at the beginning of the section to do this. There
is nothing wrong with 'confirm'. Changes for the sake of changes.

>  .IP 2 2
>  .RI The " System Clock " "time must be correct at shutdown!"
>  .IP 3 2
> -Shutdown the system.
> +Shut down the system.

This is wrong.

http://www.merriam-webster.com/dictionary/shutdown
http://www.merriam-webster.com/dictionary/shut%20down


>  .IP 4 2
>  Let an extended period pass without changing the Hardware Clock.
>  .IP 5 2
>  Start the system.
>  .IP 6 2
> -.RB "Immediately use " hwclock " to set the correct time with the"
> +.RB "Immediately use " hwclock " to set the correct time, adding the"
>  .BR \%\-\-update\-drift " option."
>  .PP
> -Note: if step six uses
> -.RB \%\-\-systohc ,
> +Note: if step 6 uses
> +.BR \%\-\-systohc ,
>  then the System Clock must be set correctly (step 6a) just before doing so.
>  .PP
>  .RB "Having " hwclock
> 
