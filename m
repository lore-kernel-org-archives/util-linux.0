Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:32774 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbCOMzE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:04 -0400
Received: by wejb47 with SMTP id b47so20857278wej.0
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/8] pull: logger: add tests and fix couple issues
Date: Sun, 15 Mar 2015 12:54:46 +0000
Message-Id: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Coverage of these tests is not magnificent.  None of the communications
to external systems using tcp, udp, or to journald are tested, but at
least some aspects of the logger(1) functionality gets to be checked -
that is message formats and input validation.


----------------------------------------------------------------
The following changes since commit 7ff6948e59172c1942544c9a064708e5666ba20d:
  logger: use xstrdup() (2015-03-13 15:36:39 +0100)
are available in the git repository at:
   tests_logger 
for you to fetch changes up to e3f7951113a68b171b5cea52ae0d36609faf4438:
  tests: add logger(1) error condition tests (2015-03-15 12:46:30 +0000)
----------------------------------------------------------------

Sami Kerola (8):
  logger: tidy few indentation issues
  logger: check xgethostname() return value
  tests: add test_logger helper command
  tests: add logger(1) command line options tests
  logger: fix rfc5424 format crash
  tests: add logger(1) message format tests
  logger: use errx() when checking user input
  tests: add logger(1) error condition tests

 misc-utils/Makemodule.am                           |   4 +
 misc-utils/logger.c                                | 173 +++++++++++++--------
 tests/commands.sh                                  |   1 +
 tests/expected/logger/errors                       |   0
 tests/expected/logger/errors-id_with_space         |   2 +
 tests/expected/logger/errors-invalid_prio          |   1 +
 tests/expected/logger/errors-kern_priority         |   1 +
 tests/expected/logger/errors-kern_priority_numeric |   1 +
 tests/expected/logger/errors-rfc5424_exceed_size   |   1 +
 .../logger/errors-rfc5424_msgid_with_space         |   1 +
 tests/expected/logger/errors-tag_with_space        |   2 +
 tests/expected/logger/formats                      |   0
 tests/expected/logger/formats-priorities           | 152 ++++++++++++++++++
 tests/expected/logger/formats-rfc3164              |   1 +
 tests/expected/logger/formats-rfc5424_msgid        |   1 +
 tests/expected/logger/formats-rfc5424_nohost       |   1 +
 tests/expected/logger/formats-rfc5424_notime       |   1 +
 tests/expected/logger/formats-rfc5424_simple       |   1 +
 tests/expected/logger/input_empty_line             |   3 +
 tests/expected/logger/input_prio_prefix            |   1 +
 tests/expected/logger/input_simple                 |   1 +
 tests/expected/logger/options                      |   0
 .../expected/logger/options-input_file_empty_line  |   3 +
 .../expected/logger/options-input_file_prio_prefix |   1 +
 tests/expected/logger/options-input_file_simple    |   1 +
 .../expected/logger/options-input_file_skip_empty  |   2 +
 tests/expected/logger/options-log_pid              |   1 +
 tests/expected/logger/options-log_pid_define       |   1 +
 tests/expected/logger/options-log_pid_long         |   1 +
 tests/expected/logger/options-log_pid_no_arg       |   1 +
 tests/expected/logger/options-simple               |   1 +
 tests/ts/logger/errors                             |  60 +++++++
 tests/ts/logger/formats                            |  53 +++++++
 tests/ts/logger/options                            |  57 +++++++
 34 files changed, 465 insertions(+), 66 deletions(-)
 create mode 100644 tests/expected/logger/errors
 create mode 100644 tests/expected/logger/errors-id_with_space
 create mode 100644 tests/expected/logger/errors-invalid_prio
 create mode 100644 tests/expected/logger/errors-kern_priority
 create mode 100644 tests/expected/logger/errors-kern_priority_numeric
 create mode 100644 tests/expected/logger/errors-rfc5424_exceed_size
 create mode 100644 tests/expected/logger/errors-rfc5424_msgid_with_space
 create mode 100644 tests/expected/logger/errors-tag_with_space
 create mode 100644 tests/expected/logger/formats
 create mode 100644 tests/expected/logger/formats-priorities
 create mode 100644 tests/expected/logger/formats-rfc3164
 create mode 100644 tests/expected/logger/formats-rfc5424_msgid
 create mode 100644 tests/expected/logger/formats-rfc5424_nohost
 create mode 100644 tests/expected/logger/formats-rfc5424_notime
 create mode 100644 tests/expected/logger/formats-rfc5424_simple
 create mode 100644 tests/expected/logger/input_empty_line
 create mode 100644 tests/expected/logger/input_prio_prefix
 create mode 100644 tests/expected/logger/input_simple
 create mode 100644 tests/expected/logger/options
 create mode 100644 tests/expected/logger/options-input_file_empty_line
 create mode 100644 tests/expected/logger/options-input_file_prio_prefix
 create mode 100644 tests/expected/logger/options-input_file_simple
 create mode 100644 tests/expected/logger/options-input_file_skip_empty
 create mode 100644 tests/expected/logger/options-log_pid
 create mode 100644 tests/expected/logger/options-log_pid_define
 create mode 100644 tests/expected/logger/options-log_pid_long
 create mode 100644 tests/expected/logger/options-log_pid_no_arg
 create mode 100644 tests/expected/logger/options-simple
 create mode 100755 tests/ts/logger/errors
 create mode 100755 tests/ts/logger/formats
 create mode 100755 tests/ts/logger/options

-- 
2.3.2

