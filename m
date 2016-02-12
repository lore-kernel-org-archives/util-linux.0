Return-Path: elseifthen@gmx.com
Subject: [PATCH 0/1] hwclock --show format
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <56BD2A87.30009@gmx.com>
Date: Thu, 11 Feb 2016 19:42:47 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>


The following commit is incorrect.
 _______________________
commit dadaad018721a82aafc06af2e94c1c2f8cef68de
Author: Anna Jonna Ã<81>rmannsdÃ³ttir <annajonna@gmail.com>
Date:   Thu Jan 28 19:03:20 2016 +0000

    Change of output format and documentation.
 _______________________

RE: hwclock.8.in changes

hwclock --show does not use the date(1) format, it uses strftime(3) %c.

Under POSIX date(1) format has a specific definition. In the glibc
locale database it is set to the keyword date_fmt; hwclock uses
strftime(3) %c format which is keyword d_t_fmt. For example:

LC_TIME=en_HK locale -k date_fmt d_t_fmt
date_fmt="%a %b %e %H:%M:%S %Z %Y"
d_t_fmt="%A, %B %d, %Y %p%I:%M:%S %Z"

LC_TIME=en_US locale -k date_fmt d_t_fmt
date_fmt="%a %b %e %H:%M:%S %Z %Y"
d_t_fmt="%a %d %b %Y %r %Z"

For the above locales date(1) format is the same, but hwclock(8) (strftime
%c) is very different:

LC_TIME=en_HK date; LC_TIME=en_US date
Thu Feb 11 16:58:23 EST 2016
Thu Feb 11 16:58:23 EST 2016

LC_TIME=en_HK /sbin/hwclock; LC_TIME=en_US /sbin/hwclock
Thursday, February 11, 2016 PM04:59:34 EST  .559820 seconds
Thu 11 Feb 2016 04:59:35 PM EST  .004092 seconds


RE: hwclock.c changes:

OLD: Thu 11 Feb 2016 03:41:17 PM EST  .490796 seconds
NEW: Thu 11 Feb 2016 03:40:55 PM EST and 000850 microseconds

"hwclock --show" is supposed to display the Hardware Clock time; it is
not a dialog. Adding more and longer words, IMO, is not a improvement.
(There also should not have been any zero padding.)

The apparent purpose of this change is to address the ambiguity created
by having the fractional seconds separate from the time display. In the
past it had to be that way, because the fractional part was always
negative and did not wrap on overflow. After fixing that, I intended to
concatenate the fractional part to the time display; using the %c format
made doing so non-trivial. I wanted to change to a different format, but
I had assumed that there would be push back against it. So the task went
to the bottom of my TODO list.

Now that a format change has already been committed, I will go with that and
submit a further change to ISO 8601.

RATIONAL

As hwclock is a system administration tool having its --show function in
the ISO 8601 format is appropriate because:

* the format should be machine friendly
* the format should be conducive to logging
* the format should be conducive for timestamping
* it should use a predictable, locale independent, international format
* it does not need to pretty print because:
    * it cannot be called by a normal user
    * it is not used for wallclock time


PULL REQUEST INFORMATION

The following changes since commit 583627ef363f0e0bd8a7dac646507c2458accc56:

  agetty: add support for \e in issue file to print \033 (2016-02-11 12:33:57 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git 020716

for you to fetch changes up to 0c0d33d1f6d564fdc16a655edecda38db74bce0e:

  hwclock.c, hwclock.8.in: new --show format (2016-02-11 16:02:05 -0500)

----------------------------------------------------------------
J William Piggott (1):
      hwclock.c, hwclock.8.in: new --show format

 sys-utils/hwclock.8.in |  8 +++-----
 sys-utils/hwclock.c    | 16 +++++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)
