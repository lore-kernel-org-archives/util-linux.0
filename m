Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:52342 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaFVKcK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jun 2014 06:32:10 -0400
Received: by mail-we0-f179.google.com with SMTP id w62so5648185wes.10
        for <util-linux@vger.kernel.org>; Sun, 22 Jun 2014 03:32:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/6] pull: rename fixes
Date: Sun, 22 Jun 2014 11:31:51 +0100
Message-Id: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here are the rename(1) changes again.  Last time changing directory end
up to make merging not preferred, so I added ts_cd() function that does
everything I could think of ensuring directory change is successful.

On top of the previous patch set there are also two new rename(1)
changes.  Either the first four patches are merged now and the last two
later, or the whole thing should wait until final v2.25 release is out. 
My feeling later is the correct decision.


The following changes since commit d121efdb6e7bfe57d91d7ac46c3a3e13e9506584:
  cfdisk: add --zero command line option (2014-06-20 12:17:53 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git
for you to fetch changes up to d14036b0793c8bdddb89680fcfbb80b19b49e6ca:
  rename: use function pointer to select file or s

Sami Kerola (6):
  rename: allow renaming in subdirectories
  tests: add function to change directory reliable way
  tests: use ts_cd everywhere to change direcrory
  tests: add rename(1) checks
  rename: continue despite something failed
  rename: use function pointer to select file or symlink operation

 misc-utils/rename.c               | 124 ++++++++++++++++++++------------------
 tests/commands.sh                 |   1 +
 tests/expected/rename/basic       |   4 ++
 tests/expected/rename/subdir      |  20 ++++++
 tests/expected/rename/symlink     |   3 +
 tests/functions.sh                |  14 +++++
 tests/ts/build-sys/config         |   6 +-
 tests/ts/column/fillrow           |   2 +-
 tests/ts/column/invalid-multibyte |   2 +-
 tests/ts/column/multi-file        |   2 +-
 tests/ts/column/separator_table   |   2 +-
 tests/ts/cramfs/mkfs              |   8 +--
 tests/ts/namei/logic              |   2 +-
 tests/ts/rename/basic             |  41 +++++++++++++
 tests/ts/rename/subdir            |  42 +++++++++++++
 tests/ts/rename/symlink           |  41 +++++++++++++
 16 files changed, 245 insertions(+), 69 deletions(-)
 create mode 100644 tests/expected/rename/basic
 create mode 100644 tests/expected/rename/subdir
 create mode 100644 tests/expected/rename/symlink
 create mode 100755 tests/ts/rename/basic
 create mode 100755 tests/ts/rename/subdir
 create mode 100755 tests/ts/rename/symlink

-- 
2.0.0

