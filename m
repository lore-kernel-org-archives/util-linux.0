Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61248 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752680AbdACOfF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 3 Jan 2017 09:35:05 -0500
Subject: Re: pull: hwclock 27 changes
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20161231214107.8658-1-kerolasa@iki.fi>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c0f6e636-33fd-6c09-4361-6adca71f9688@gmx.com>
Date: Tue, 3 Jan 2017 09:34:48 -0500
MIME-Version: 1.0
In-Reply-To: <20161231214107.8658-1-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hey Sami,
 I'm reviewing these, but there is a lot to digest.

 Karel, I hope you are not in a hurry to commit these. I should have a
 review ready in a few days.

On 12/31/2016 04:41 PM, Sami Kerola wrote:
> Good New Year,
> 
> Most of the changes in this pull request has been lying in my git repo for
> few months, and now when 2016 is coming to an end I had a look what
> unsubmitted work there is.  After reviewing my changes, and improving some
> of them modestly, these are now ready for review.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 963f7dfb82d44661d76c6fb61fda309b846726ce:
> 
>   Merge branch 'getrandom' of git://github.com/kerolasa/lelux-utiliteetit (2016-12-22 15:27:25 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/kerolasa/lelux-utiliteetit.git hwclock
> 
> for you to fetch changes up to c7a8f56920c738a90038cd6baaaec676c642b926:
> 
>   hwclock: remove trailing dot from messages that include system error message (2016-12-31 21:29:27 +0000)
> 
> ----------------------------------------------------------------
> Sami Kerola (27):
>       hwclock: remove UTC-0 localization hack
>       lib: add timegm() portability function to lib/timeutils.c
>       hwclock: remove FLOOR macro
>       hwclock: remove hwclock_exit() indirection
>       hwclock: do not hardcode date command magic string twice
>       hwclock: remove unnecessary type casts
>       hwclock: move command-line options to control structure
>       hwclock: clarify set_cmos_epoch() code
>       hwclock: move error messages to determine_clock_access_method()
>       docs: add instructions how to avoid alpha epoc Y2020 bug
>       hwclock: remove dead code and other minor fixes
>       hwclock: simplify save_adjtime() execution flow
>       hwclock: alloate date_resp parsing buffer in interpret_date_string()
>       hwclock: initialize struct adjtime members
>       hwclock: use symbolic magic values passed in between functions
>       hwclock: remove magic constants from interpret_date_string()
>       hwclock: add debugging to open_rtc()
>       hwclock: remove division by zero [asan]
>       hwclock: use integer arithmetics in compare_clock()
>       docs: deprecate hwclock --compare option
>       hwclock: improve coding style
>       hwclock: stream line synchronize_to_clock_tick_rtc()
>       hwclock: try RTCGET and RTCSET only when normal rtc fails
>       hwclock: clarify cmos inb and outb preprocessor directives
>       hwclock: fix rtc atexit registration
>       hwclock: make --date=argument less prone to injection
>       hwclock: remove trailing dot from messages that include system error message
> 
>  configure.ac             |   1 +
>  include/pathnames.h      |   4 +
>  include/timeutils.h      |   4 +
>  lib/timeutils.c          |  19 ++
>  login-utils/utmpdump.c   |   1 +
>  sys-utils/hwclock-cmos.c | 228 +++++++------
>  sys-utils/hwclock-rtc.c  | 221 ++++++------
>  sys-utils/hwclock.8.in   |  11 +
>  sys-utils/hwclock.c      | 874 +++++++++++++++++++++--------------------------
>  sys-utils/hwclock.h      |  71 +++-
>  10 files changed, 702 insertions(+), 732 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
