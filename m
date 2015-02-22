Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:63228 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbBVOng (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:36 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so21165474wgg.11
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/31] pull: more changes
Date: Sun, 22 Feb 2015 14:42:56 +0000
Message-Id: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The following changes are clean ups and improvements to more(1) command. 
I feel this change set does not sufficiently address all issues, and
short comings of more(1).  For example, lines that have terminal control
characters to emphasis in bold or change color are after this change set
still wrapped too early.  That issue makes more(1) to be broken pager
when viewing manual pages.  Getting that issue fixed is my minimum before
next util-linux release.  Which leads me to bunch of questions;

* Should more(1) have similar to less(1) roll back and forth support?
* When searching should more(1) highlight what it finds?
* Or should more be the lightest weight, slickest, quickest, and least
  memory consuming pager?
* Does anyone care Posix Correctly(TM)[1] version of more(1)?
** Would include for example ctags support, case insensitive searching,
   exit rules, output filtering when stdout is not terminal, and so on.
* Any other ideas how & why more(1) could or should be improved?

[1] http://pubs.opengroup.org/onlinepubs/7908799/xcu/more.html

These changes are also available from my github remote repository.

 git://github.com/kerolasa/lelux-utiliteetit.git more

Sami Kerola (31):
  more: remove function declarations
  more: reorder includes, declarations, and global variables
  more: add struct more_control and remove global variables
  more: remove dead code and useless comments
  more: return is statement, not a function
  more: use paths.h to find bourne shell and vi editor
  more: remove function like preprocessor defines
  more: remove pointless functions
  more: remove 'register' keywords
  more: avoid long else segment in prbuf()
  more: move runtime usage output away from command()
  more: move editor execution to a function from command()
  more: move skipping backwards to a function from command()
  more: move skipping forewards to a function from command()
  more: check open(3) return value
  more: remove unnecessary braces
  more: do not call fileno() for std{in,out,err} streams
  more: split run time help screen to multiple translatable lines
  more: tell in run time help what the 'v' will execute as editor
  more: add display_file() to be shared with files and stdin input
  more: replace siglongjmp() and signal() calls with signalfd()
  more: init function variables at declaration
  more: rename variable and function names easier to understand
  more: add -i ignore-case posix compliance option
  more: add -n <number> posix compliance option
  more: add -e posix compliance option
  more: fix compiler warnings
  more: speed up command_expansion()
  more: remove unnecessary variable
  more: remove TIOCGWINSZ preprocessor #ifdef checks
  more: simplify initterm()

 text-utils/Makemodule.am |    4 +-
 text-utils/more-term.h   |  110 ++
 text-utils/more.1        |   13 +
 text-utils/more.c        | 3141 ++++++++++++++++++++++------------------------
 4 files changed, 1619 insertions(+), 1649 deletions(-)
 create mode 100644 text-utils/more-term.h

-- 
2.3.0

