Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:56935 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290Ab2IDP5m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Sep 2012 11:57:42 -0400
Message-ID: <504624F3.2020601@bernhard-voelker.de>
Date: Tue, 04 Sep 2012 17:57:39 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: su: (why not?) merged from latest coreutils
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

su has not been "merged from latest coreutils".

If you look at su.c's history, the coreutils changes stop at March 2007,
only followed by 5 SuSE and 1 Redhat patches before the integration in
util-linux began:

  $ git log --oneline 7943f79..v2.21-559-gff6b15d -- login-utils/su.c
  ff6b15d make su build as part of util-linux
  c6a1746 call setsid() when called with -c
  a6fdd3f make sure /sbin resp /usr/sbin are in PATH
  589554a honor settings in /etc/default/su resp /etc/login.defs
  a9980c8 set sane default path
  b14d022 log all su attempts
  8171142 pam support for su
  ce5f2f2 Help translators include translation team's web or email address.

If you look at su.c's history in the coreutils tree, then there are
25 changes before it has been removed from the project:

  $ git log --oneline v6.1-64-gd8049d7..v8.17-16-g928dd73 -- src/su.c
  928dd73 su: remove program (util-linux is now the best source for it)
  d787845 maint: use single copyright year range
  a517386 maint: src/*.c: change remaining quotes (without embedded spaces)
  101d120 maint: use new emit_try_help in place of equivalent fprintf
  5111aa4 maint: update all copyright year number ranges
  71b7ddc port to GNU hosts, where getuid and friends can fail
  9d6231e maint: update all copyright year number ranges
  1aa17dc maint: update all FSF copyright year lists to include 2010
  1c59bb3 nice, nohup, su: detect write failure to stderr
  c690047 maint: let gnulib provide environ
  b6540b9 chroot, env, nice, su: use EXIT_CANCELED for internal failure
  32f987a build: avoid compiler warnings on cygwin 1.5
  5d4f09d doc: mention the texinfo documentation in --help
  5e778f7 global: convert indentation-TABs to spaces
  2232b4d maint: update all Copyright year lists to include 2009
  9fdf584 maint: Clarify ambiguous refs to Linux kernels or GNU/Linux systems
  22a2a43 build: add configure-time --enable-gcc-warnings option; avoid warnings
  45e6718 remove redundant const directives
  1463824 add "const" attribute, where possible
  896b672 use gnulib's progname module
  434258c declare program_name consistently
  581b2e3 adjust copyright dates
  b69b4cc convert single-author programs to use proper_name
  3575545 Use EXIT_FAILURE, not EXIT_FAIL, now that EXIT_FAILURE is always 1.
  71aa3ea Update all copyright notices to use the newer form.
  33342c1 Change "version 2" to "version 3" in all copyright notices.
  a0faff1 Help translators include translation team's web or email address.


Many of the changes are minor ones regarding identation, internal error
code fixes, copyright year number changes etc. but at least the following
seem to be worth including:

  71b7ddc port to GNU hosts, where getuid and friends can fail
  1c59bb3 nice, nohup, su: detect write failure to stderr

and these would be nice:

  a517386 maint: src/*.c: change remaining quotes (without embedded spaces)
  9fdf584 maint: Clarify ambiguous refs to Linux kernels or GNU/Linux systems

WDYT?

Have a nice day,
Berny
