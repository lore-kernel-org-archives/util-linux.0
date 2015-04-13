Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56204 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbbDMMB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:57 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MCcE2-1YYFOL0bdS-009SNH for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:55 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 0/7] logger tests do not need /dev/log but socat
Date: Mon, 13 Apr 2015 14:01:46 +0200
Message-Id: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is version 2 of pull request #194 on github
https://github.com/karelzak/util-linux/pull/194

Now we require socat for logger tests. We should NOT add fallback to
netcat-like tools. I have tried this but there are too many different
and broken netcat versions out there.

To avoid socat dependency we could write our own test helper. I had
already done this for testing but I think that socat is just the right
tool for this. We may also add more tests with for tcp or udp listeners
...


Ruediger Meier (7):
  logger: --stderr and --no-act turn "auto-errors" on
  tests: simplify common logger options
  tests: logger with socat device
  tests: logger, validate written socket data
  tests: logger/errors does not use --no-act
  tests: add subtests for invalid logger devive
  travis: install socat

 .travis-functions.sh                        |  1 +
 misc-utils/logger.c                         |  5 ++-
 tests/expected/logger/errors-check_socket   | 21 ++++++++++++
 tests/expected/logger/errors-invalid_socket |  2 ++
 tests/expected/logger/formats-check_socket  |  1 +
 tests/expected/logger/options-check_socket  |  1 +
 tests/functions.sh                          | 29 ++++++++++++++++
 tests/ts/logger/errors                      | 52 +++++++++++++++++++----------
 tests/ts/logger/formats                     | 39 +++++++++++++++-------
 tests/ts/logger/journald                    |  2 +-
 tests/ts/logger/options                     | 21 ++++++++++--
 11 files changed, 138 insertions(+), 36 deletions(-)
 create mode 100644 tests/expected/logger/errors-check_socket
 create mode 100644 tests/expected/logger/errors-invalid_socket
 create mode 100644 tests/expected/logger/formats-check_socket
 create mode 100644 tests/expected/logger/options-check_socket

-- 
1.8.4.5

