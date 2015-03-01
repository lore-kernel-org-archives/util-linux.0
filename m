Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sun, 1 Mar 2015 11:46:11 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/16] flock: improve timeout handling
In-Reply-To: <20150224102128.GF19430@ws.net.home>
Message-ID: <alpine.LNX.2.03.1503011134070.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-4-git-send-email-kerolasa@iki.fi> <20150224102128.GF19430@ws.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 24 Feb 2015, Karel Zak wrote:

> On Sun, Feb 22, 2015 at 02:41:33PM +0000, Sami Kerola wrote:
> > Signal ALRM raised by the timer, and the timer only, will be considered
> > as a timeout criteria.
> > 
> > Secondly time interval is made to use monotonic clock.  Documentation of
> > ITIMER_REAL is unclear whether that time is affected various sources of
> > clock skew, or does it even tick when system is suspended.
> 
> I agree, setitimer() API is also obsolete.
> 
> > This code is moved from libcommon.la to flock.c because of two reasons.
> > This is the only utility using the function, and setup_timer() along with
> > cancel_timer() need to be linked with -lrt option.
> 
> Hmm... yes, it's used by flock only, but I still think it would be
> better to keep it in common lib/ code. Maybe we can use the timers on
> another places later (uuidd, login, sulogin, ...).
> 
> What about to keep all -lrt stuff in lib/monotonic.c?

Thanks Karel,

Moving to monotonic sounds good to me. Notice that there is linking change 
in configure.ac making monotonic.c to be linked with -lrt even when 
clock_gettime() would not require it. The timer_create() requires -lrt at 
last for now.

https://github.com/kerolasa/lelux-utiliteetit/commit/50425160a825986abb4e9c22ef8acee8e7b34834

> > --- a/sys-utils/Makemodule.am
> > +++ b/sys-utils/Makemodule.am
> > @@ -2,7 +2,7 @@ if BUILD_FLOCK
> >  usrbin_exec_PROGRAMS += flock
> >  dist_man_MANS += sys-utils/flock.1
> >  flock_SOURCES = sys-utils/flock.c lib/monotonic.c
> > -flock_LDADD = $(LDADD) libcommon.la $(CLOCKGETTIME_LIBS)
> > +flock_LDADD = $(LDADD) libcommon.la -lrt
> 
> Don't use -l<foo> in Makefiles, always use $(FOO) and initialize the
> variable in ./configure, $(CLOCKGETTIME_LIBS) is fine (although the
> name of the variable is not perfect in this context).

TODO:

s/CLOCKGETTIME_LIBS/UL_REALTIME_LIBS/

Better?

> > +static void timeout_handler(int sig __attribute__((__unused__)),
> > +			    siginfo_t *info,
> > +			    void *context __attribute__((__unused__)))
> >  {
> > -	timeout_expired = 1;
> > +	if (info->si_code == SI_TIMER)
> > +		timeout_expired = 1;
> >  }
> 
> BTW, it mean that "kill -ALRM" does not force the program to set 
> timeout_expired, right? Nice.

Correct. After the change flock(1) cannot be forced to timeout by sending 
an ALRM signal. Is that good, bad, or possible regression is debatable. I 
think allowing external signals to cause timeout is unintented behavior. 
If someone requires external timeouts then adding an option to allow them 
is justified.

> > +static int setup_timer(timer_t *t_id, struct itimerval *timeout)
> 
> if you move it to lib/ than add a pointer to timeout_handler() too
> 
> Anyway, it seems more elegant than the previous implementation.

Function pointer is added.

https://github.com/kerolasa/lelux-utiliteetit/commit/50425160a825986abb4e9c22ef8acee8e7b34834

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
