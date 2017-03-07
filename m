Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932285AbdCGDz4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Mar 2017 22:55:56 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 0/4] fincore command
Date: Tue,  7 Mar 2017 11:33:48 +0900
Message-Id: <20170307023352.7340-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch set proposes adding fincore command to util-linux
distribution.  The command counts pages of file contents being
resident in memory(in core), and reports the numbers.

It helps system administrators understand how their systems use
physical memory, especially about page caches when they have to do
trouble shooting and/or performance tuning.

This is just my case. A person in other role may also get benefits
from this command.


Masatake YAMATO (4):
  fincore: new command for counting pages of file contents in core
  man: add a page for fincore command
  tests: add cases for testing fincore command
  bash-completion: add a function for fincore command

 bash-completion/Makemodule.am |   3 +
 bash-completion/fincore       |  25 +++++
 configure.ac                  |   4 +
 misc-utils/Makemodule.am      |   6 ++
 misc-utils/fincore.1          |  76 ++++++++++++++
 misc-utils/fincore.c          | 209 +++++++++++++++++++++++++++++++++++++
 misc-utils/fincore_orig.c     | 235 ++++++++++++++++++++++++++++++++++++++++++
 tests/commands.sh             |   1 +
 tests/expected/fincore/count  |  62 +++++++++++
 tests/ts/fincore/count        | 194 ++++++++++++++++++++++++++++++++++
 10 files changed, 815 insertions(+)
 create mode 100644 bash-completion/fincore
 create mode 100644 misc-utils/fincore.1
 create mode 100644 misc-utils/fincore.c
 create mode 100644 misc-utils/fincore_orig.c
 create mode 100644 tests/expected/fincore/count
 create mode 100755 tests/ts/fincore/count

-- 
2.9.3

