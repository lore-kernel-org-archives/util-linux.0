Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57878 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaDLK2t (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:28:49 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so3558823wib.1
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:28:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/7] kill: add regression tests
Date: Sat, 12 Apr 2014 11:28:37 +0100
Message-Id: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Couple days ago I promised to deliver some kill regression tests so here
they come.

The promise: http://www.spinics.net/lists/util-linux-ng/msg09099.html

Sami Kerola (7):
  kill: make options --pid and --queue mutually exclusive
  kill: remove unnecessary indirection
  tests: add signal receiver program
  tests: check kill is converting signals names correctly
  tests: check various ways to specify kill signal
  tests: check kill print pid option
  tests: check kill all user processes

 misc-utils/kill.c                  |  10 ++-
 tests/commands.sh                  |   4 ++
 tests/expected/kill/all_processes  |   5 ++
 tests/expected/kill/name_to_number |   1 +
 tests/expected/kill/options        |   1 +
 tests/expected/kill/print_pid      |   1 +
 tests/helpers/Makemodule.am        |   3 +
 tests/helpers/test_sigreceive.c    | 126 +++++++++++++++++++++++++++++++++++++
 tests/ts/kill/all_processes        |  57 +++++++++++++++++
 tests/ts/kill/name_to_number       |  61 ++++++++++++++++++
 tests/ts/kill/options              |  63 +++++++++++++++++++
 tests/ts/kill/print_pid            |  56 +++++++++++++++++
 12 files changed, 385 insertions(+), 3 deletions(-)
 create mode 100644 tests/expected/kill/all_processes
 create mode 100644 tests/expected/kill/name_to_number
 create mode 100644 tests/expected/kill/options
 create mode 100644 tests/expected/kill/print_pid
 create mode 100644 tests/helpers/test_sigreceive.c
 create mode 100755 tests/ts/kill/all_processes
 create mode 100755 tests/ts/kill/name_to_number
 create mode 100755 tests/ts/kill/options
 create mode 100755 tests/ts/kill/print_pid

-- 
1.9.2

