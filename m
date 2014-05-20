Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52569 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbaETPmp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 11:42:45 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>
Subject: [PATCH 0/5] lscpu: improve hypervisor detection
Date: Tue, 20 May 2014 15:42:26 +0000
Message-Id: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This patch set is based on an openSUSE / SLE patch. Original author was
probably Petr Uzel.

I've splitted the original patch into smaller pieces, removed some
incompatible output format changes and added some test data.

You can also review and pull from my github repo
https://github.com/rudimeier/util-linux/compare/lscpu-detect?expand=1

CC: Stanislav Brabec <sbrabec@suse.cz>
CC: Petr Uzel <petr.uzel@suse.cz>

Ruediger Meier (5):
  lscpu: minor cleanup and improve hypervisor detection
  tests: add vbox lscpu dump
  lscpu: detect OS/400 and pHyp hypervisors
  lscpu: improve vmware detection
  lscpu: avoid compiler warnings

 sys-utils/lscpu.c                    | 148 ++++++++++++++++++++++++++++++++++-
 sys-utils/lscpu.h                    |   5 +-
 tests/expected/lscpu/lscpu-vbox-win  |  29 +++++++
 tests/ts/lscpu/dumps/vbox-win.tar.gz | Bin 0 -> 15769 bytes
 4 files changed, 179 insertions(+), 3 deletions(-)
 create mode 100644 tests/expected/lscpu/lscpu-vbox-win
 create mode 100644 tests/ts/lscpu/dumps/vbox-win.tar.gz

-- 
1.8.4.5

