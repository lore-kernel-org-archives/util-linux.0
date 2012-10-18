Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60276 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809Ab2JRUGa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Oct 2012 16:06:30 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so2585449wib.1
        for <util-linux@vger.kernel.org>; Thu, 18 Oct 2012 13:06:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20121015152558.GK18377@x2.net.home>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
	<1350246070-10544-4-git-send-email-kerolasa@iki.fi>
	<201210142212.50597.vapier@gentoo.org>
	<20121015152558.GK18377@x2.net.home>
Date: Thu, 18 Oct 2012 21:06:28 +0100
Message-ID: <CAG27Bk3bRTppXcBpqEZeRSMhqK1+BTrQqje9E0NYPSgfqcm4fQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Mike and Karel,

Executive summary; try II is available at github.

The following changes since commit df0f2ad7633b3e2cc830298239cbaaa656e724cd:

  lib/loopdev: check for /sys (2012-10-17 11:51:10 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk41

for you to fetch changes up to 1ada6eeb7046bc2fec71b244f404028ef8d9e158:

  build-sys: remove gethostbyname() check (2012-10-18 20:23:16 +0100)

----------------------------------------------------------------
Sami Kerola (17):
      include/env: add get_hostname_max() inline function
      include/env: unify indentation
      login: stop using MAXHOSTNAMELEN
      write: stop using MAXHOSTNAMELEN
      agetty: stop using MAXHOSTNAMELEN
      docs: add line breaks to whereis.1
      libmount: replace usleep with nanosleep
      include/all-io: replace usleep with nanosleep
      hwclock: replace usleep with nanosleep
      rtcwake: replace usleep with nanosleep
      agetty: replace usleep with nanosleep
      tailf: replace usleep with nanosleep
      include/usleep: remove remaining references to usleep
      libmount, eject: replace index() and rindex() with strrch() or strrchr()
      logger: replace gethostbyname() with getaddrinfo()
      agetty: replace gethostbyname() with getaddrinfo()
      build-sys: remove gethostbyname() check


And then to detailed comments.

On Mon, Oct 15, 2012 at 2:46 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sunday 14 October 2012 16:20:52 Sami Kerola wrote:
>> --- a/login-utils/last.c
>> +++ b/login-utils/last.c
>> @@ -418,22 +418,19 @@ addtty(char *ttyname) {
>>   */
>>  static void
>>  hostconv(char *arg) {
>> -     static int      first = 1;
>> -     static char     *hostdot,
>> -                     name[MAXHOSTNAMELEN];
>> -     char    *argdot;
>> +     static char *hostdot;
>> +     static char *argdot;
>> +     static char *name;
>>
>>       if (!(argdot = strchr(arg, '.')))
>>               return;
>> -     if (first) {
>> -             first = 0;
>> -             if (gethostname(name, sizeof(name)))
>> -                     err(EXIT_FAILURE, _("gethostname failed"));
>> -
>> -             hostdot = strchr(name, '.');
>> -     }
>> +     name = xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
>> +     if (gethostname(name, sysconf(_SC_HOST_NAME_MAX)))
>> +             err(EXIT_FAILURE, _("gethostname failed"));
>> +     hostdot = strchr(name, '.');
>>       if (hostdot && !strcmp(hostdot, argdot))
>>               *argdot = '\0';
>> +     free(name);
>>  }
>
> marking argdot static doesn't make sense
>
> the way you're rewritten things also doesn't make sense to have "name"
> be static.  i'd go so far as to say it's wrong.  keep the existing
> "first" logic.

I had another look of the last(1) code, and came to conclusion I need to
drop the patch.  It seems source of this command would benefit from major
rewrite clean up, but as it is marked as deprecated I do not feel there
is point doing that.  Maybe some day this implementation of last will be
found being deprecated long enough that it can be removed.


On Mon, Oct 15, 2012 at 3:14 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sunday 14 October 2012 16:20:59 Sami Kerola wrote:
>> POSIX.1-2001 declares usleep is obsolete.
>
> this is true, but it seems like a better answer would be to add a
> usleep test to configure and provide a local fallback using nanosleep
> if it doesn't exist.

Is that necessary?  There has been for example in old mount since March
2007[1] nanosleep() call, and I cannot remember anyone complaining it
causing problems.

[1] commit dc8fdc57cd3ba0658cf4ab05031695c2d2965f93


On Mon, Oct 15, 2012 at 4:25 PM, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Oct 14, 2012 at 10:12:49PM -0400, Mike Frysinger wrote:
>> On Sunday 14 October 2012 16:20:54 Sami Kerola wrote:
>> > +   host = xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
>> > +   if (gethostname(host, sysconf(_SC_HOST_NAME_MAX)) < 0)
>>
>> sysconf() isn't labeled pure or anything, so it'd be better imo to
>> store this
>> in a local var so you don't waste time calling it twice.
>>       long len = sysconf(...);
>
>  I agree.
>
>  IMHO it would be nice to add somewhere to the include/ directory a
>  robust function that always returns the size. Something like:
>
>  static inline size_t get_hostname_max(void)
>  {
>     long len = sysconf(_SC_HOST_NAME_MAX);
>
>     if (len > 0)
>         return len;
>
>     return 64;
>  }

Yes, that seems right.  I added the function to include/env.h which is
perhaps a bit strange file for it, but I did not want to add 'yet another
single inline function file' and I with quick looking I could not find
any other file that would have been more suitable.

https://github.com/kerolasa/lelux-utiliteetit/commit/351ec5992e42556051cb303361b962247fa1f752


On Mon, Oct 15, 2012 at 6:39 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 15 October 2012 04:36:43 Sami Kerola wrote:
>> On Mon, Oct 15, 2012 at 3:17 AM, Mike Frysinger <vapier@gentoo.org>
>> wrote:
>> > On Sunday 14 October 2012 16:21:10 Sami Kerola wrote:
>> >> +     if (utimensat(path, &epoch, 0) < 0)
>> >
>> > err, did you test this at all ?  utimensat() takes 4 args one of
>> > which is
>> > a reference file descriptor.
>>
>> I thought I did, but what ever I did where partly unsuccessful.
>
> cramfs isn't built by default, so you'll need to pass the right
> configure flag

*sigh* I see.  And I dropped the patch.

I wonder if anyone is ever reaching code that requires INCLUDE_FS_TESTS
defined.  Should there be a configure --enable-fs-crams-tests switch?  If
that sort of switch is added it should perhaps be included when
--enable-most-builds is set.  Comments, opinions?

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
