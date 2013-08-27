Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f180.google.com ([209.85.215.180]:43667 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3H0SGf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:35 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so2425555eaj.39
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/17] pull: term-utils changes with emphasis on last(1)
Date: Tue, 27 Aug 2013 19:06:03 +0100
Message-Id: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Notice that the first patch is skipped intentionally.  I sent it already
yesterday, but it is in my git tree if someone prefers inspecting the
work that way.

The patches 02 to 08 are fairly trivial changes, and commit messages
should be enough.

The 09 is perhaps more interesting.  I were unable to send with write(1)
a message from one of my own terminals to other when mesg(1) had enabled. 
Because I felt that is unexpeceted the 09 will change how write(1) will
determine messaging permission.  As with any permissions change it would
be great to get this change properly scrutinised.

>From patch 10 onwards the changes are mostly outcome of earlier request
in the maillist.

http://www.spinics.net/lists/util-linux-ng/msg08227.html

To make time format parsing user friendly I decided to plunder code from
systemd.  It is a pity there does not seem to be libtime for all sorts of
time related format parsing, conversions, etc high level needs to avoid
each project doing these on their own.

The last command got couple new options, --since and --time-format, which
hopefully make the utility more useful.  The patch 15 aims to make
contributors happier by removing bunch of global variables, and simplify
function argument passing.

Looking these changes I realized there is still at least one last(1) thing
missing.  The last(1) test coverage is zero.  If I don't need to rewrite
all/most of these patches I could concentrate the tests next.

Meanwhile all sort of comments, proposals, and corrections are welcome.


The following changes since commit ef2c9e3f5e51cf13ec9cf6738d4f1d695ee32a6f:

  tests: minor changes to make tests more portable (2013-08-26 13:48:40 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk34

for you to fetch changes up to 69d9bdd65371edf37bb20308582f05fe2c095195:

  docs: add --time-format to last(1) manual page (2013-08-27 18:15:00 +0100)

----------------------------------------------------------------
Sami Kerola (17):
      build-sys: pylibmount will not work when python3 is present
      wall: send message also to sessions opened by user 'sleeper'
      last: fix typo
      wall: sync usage() with howto-usage-function.txt
      mesg: sync usage() with howto-usage-function.txt
      wall: line wrap at column 79 also when line has tab chars
      docs: add --present to last(1) manual page
      docs: add note to wall(1) about sessions which will not get message
      write: change determination can user write to a terminal
      lib/time-util: copy time parsing functions from systemd
      last: parse easy to use time formats
      last: add --since time spec option
      docs: add --since and time option formats to last(1) manual
      last: fix --present option logic error
      last: use configuration struct
      last: add --time-format with iso-8601 format
      docs: add --time-format to last(1) manual page

 configure.ac              |   6 +
 include/Makemodule.am     |   1 +
 include/time-util.h       |  55 +++++++
 lib/Makemodule.am         |   1 +
 lib/time-util.c           | 388 ++++++++++++++++++++++++++++++++++++++++++++++
 login-utils/Makemodule.am |   1 +
 login-utils/last.1        |  63 +++++++-
 login-utils/last.c        | 359 ++++++++++++++++++++++++++++--------------
 term-utils/mesg.c         |  15 +-
 term-utils/wall.1         |   6 +
 term-utils/wall.c         |  28 ++--
 term-utils/write.c        |   9 +-
 12 files changed, 784 insertions(+), 148 deletions(-)
 create mode 100644 include/time-util.h
 create mode 100644 lib/time-util.c


