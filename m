Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752955AbdKXKbT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 05:31:19 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH v2 0/7] Add netnsid and nsfs columns to lsns
Date: Fri, 24 Nov 2017 19:31:02 +0900
Message-Id: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This patch-set adds netnsid and nsfs columns to lsns command.

The new columns are useful to understand namespaces information
printed in the output of "ip link" and "ip netns".  The new columns
are visible only when --type net is specified.

Masatake YAMATO (7):
  lsns: add netnsid column
  lsns: disable netnsid column by default
  lsns: add a case for testing netnsid column
  lsns: add nsfs column
  lsns: add --nowrap(-W) option
  lsns: add a case for testing nsfs column
  man: write about using multi-line in NSFS cell of lsns

 configure.ac                |   1 +
 sys-utils/Makemodule.am     |   4 +-
 sys-utils/lsns.8            |   8 ++
 sys-utils/lsns.c            | 319 +++++++++++++++++++++++++++++++++++++++++++-
 tests/commands.sh           |   1 +
 tests/expected/lsns/netnsid |   1 +
 tests/expected/lsns/nsfs    |   1 +
 tests/ts/lsns/netnsid       |  65 +++++++++
 tests/ts/lsns/nsfs          |  68 ++++++++++
 9 files changed, 459 insertions(+), 9 deletions(-)
 create mode 100644 tests/expected/lsns/netnsid
 create mode 100644 tests/expected/lsns/nsfs
 create mode 100644 tests/ts/lsns/netnsid
 create mode 100644 tests/ts/lsns/nsfs

-- 
2.13.6

