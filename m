Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36365 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcEIV1e (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so22499805wmw.3
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/12] pull: write(1) improvements
Date: Mon,  9 May 2016 22:27:16 +0100
Message-Id: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Recent write(1) regression inspired me to have a look what is going on with
this source file.  Here are the results of the inspection.  I am pretty
confident most of the changes are quick and easy to review, with exception
of one - the last change.  Let me explain a little bit closer.

Current messaging is fine assuming group ownership and setgid bit are set,
but if they are not then one will get misleading message about oneself not
having mesg(1) enabled (even if they would be).  The difficult bit is how
should be fixed.  I can think of three different options:

  1) Match process effective gid with tty device file gid, and complain when
  not matching.  This is what I propose.

  2) Use faccessat(3) to determine whether run time has effivice access to
  tty path.

  3) Perform the check at the time of stdout freopen(2), and fail with
  permission denied when necessary.

Second option feels a bit pointless as the third option does exactly the
same, and one only has to delete code to make that to work.  Main reason why
I like first option is that it gives hint how one ought to fix an issue. 
Simple 'permission denied' is less obvious.  Unfortunately the option 1 can
cause failure when write would have been possible due ownership of the tty
file - so in that sense option 2 is better.  So where I'm getting at is that
there's good and bad sides in each of these options and it would be nice to
hear what others think is the best thing to do.

----------------------------------------------------------------
The following changes since commit 94af67f2aaaafce58f495b2415e534a0c2508332:
  Merge branch 'no-fork' of https://github.com/terryburton/util-linux (2016-05-09 13:28:52 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git write-improvements
for you to fetch changes up to 354f2ee527fe9d6f5d6dcd111af49b47469eaad6:
  write: tell when effective gid and tty path group mismatch (2016-05-09 22:03:14 +0100)
----------------------------------------------------------------

Sami Kerola (12):
  write: remove unused variable
  write: get rid of function prototypes
  write: remove pointless fileno(3) calls
  write: set atime value in term_chk() only if needed
  write: use xstrncpy() from strutils.h
  write: run atexit() checks at the end of execution
  write: add control structure to clarify what is going on
  write: improve variable names
  write: remove unnecessary utmp variables
  write: make timestamp to be obviously just a clock time
  write: improve coding style
  write: tell when effective gid and tty path group mismatch

 term-utils/write.c | 395 +++++++++++++++++++++++++++--------------------------
 1 file changed, 199 insertions(+), 196 deletions(-)

-- 
2.8.2

