Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:52652 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaDOLPl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:41 -0400
Received: by mail-we0-f182.google.com with SMTP id p61so9426005wes.27
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/9] pull: kill tests
Date: Tue, 15 Apr 2014 12:15:26 +0100
Message-Id: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Here are the kill tests again.  Kudos to Bernhard whiping me to right
direction after first submission.  Changes since previous submission.

* in test scripts wait for test_sigreceiver is more pessimistic
* the test_sigreceiver tells to mother proces when it's ready be killed
  with a witness file
* in test scripts $(jobs -p) was changed to $!
* kill --verbose option is added
* lib/procutils got a fix


The following changes since commit b233dcb6ffa9a880882d58f85162ff97cede050f:

  libsmartcols: use buffer struct in table_print.c (2014-04-14 16:41:20 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git kill-tests-v2

for you to fetch changes up to 81143d7ad2bd5ac8fe86e0738f3e7a21e2c6f06c:

  lib/procutils: reset errno before strtol() call (2014-04-15 11:54:21 +0100)

----------------------------------------------------------------
Sami Kerola (9):
      kill: make options --pid and --queue mutually exclusive
      kill: remove unnecessary indirection
      tests: add signal receiver program
      tests: check kill is converting signals names correctly
      tests: check various ways to specify kill signal
      tests: check kill print pid option
      tests: check kill all user processes
      kill: add --verbose option to display what is killed
      lib/procutils: reset errno before strtol() call

 lib/procutils.c                    |   3 +-
 misc-utils/kill.c                  |  21 +++--
 tests/commands.sh                  |   3 +
 tests/expected/kill/all_processes  |   5 ++
 tests/expected/kill/name_to_number |   1 +
 tests/expected/kill/options        |   1 +
 tests/expected/kill/print_pid      |   1 +
 tests/helpers/Makemodule.am        |   3 +
 tests/helpers/test_sigreceive.c    | 153 +++++++++++++++++++++++++++++++++++++
 tests/ts/kill/all_processes        |  61 +++++++++++++++
 tests/ts/kill/name_to_number       |  64 ++++++++++++++++
 tests/ts/kill/options              |  66 ++++++++++++++++
 tests/ts/kill/print_pid            |  58 ++++++++++++++
 13 files changed, 434 insertions(+), 6 deletions(-)
 create mode 100644 tests/expected/kill/all_processes
 create mode 100644 tests/expected/kill/name_to_number
 create mode 100644 tests/expected/kill/options
 create mode 100644 tests/expected/kill/print_pid
 create mode 100644 tests/helpers/test_sigreceive.c
 create mode 100755 tests/ts/kill/all_processes
 create mode 100755 tests/ts/kill/name_to_number
 create mode 100755 tests/ts/kill/options
 create mode 100755 tests/ts/kill/print_pid
