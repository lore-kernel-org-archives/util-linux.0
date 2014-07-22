Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t3426.houston.hp.com ([15.201.208.54]:49097 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbaGVXpF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 19:45:05 -0400
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 00/13] sfdisk:
Date: Tue, 22 Jul 2014 16:44:44 -0700
Message-Id: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The sfdisk(8) program is the only one left to be rewritten to use the new libfdisk library.
To do so, however, there are first a series of cleanups that must be done in order to make
the effort easier, without introducing regressions or unexpected changes to users.

This patch is an initial attempt, and while there are plenty of leftover things to fix/cleanup,
I believe it's a pretty good start. While the set is fairly large, most of the patches are
rather straightforward -- specially patch 5, which is just an indentation change.

Thanks!

Davidlohr Bueso (13):
  sfdisk: usage() can use noreturn attribute
  sfdisk: remove bogus argc check
  sfdisk: deprecate --linux option
  sfdisk: remove dead code
  sfdisk: remove 'short_opts' global variable
  sfdisk: fix indentation
  sfdisk: remove declaraion of 'partname()'
  sfdisk: remove 'exit_status' global variable
  sfdisk: move main function at the end of the file
  fdisk: remove bugus space after header includes
  sfdisk: update [embarrassingly] old man-page
  sfdisk: rework option handling
  sfdisk: fix --unhide segfault

 disk-utils/fdisk.c  |    2 -
 disk-utils/sfdisk.8 |    4 +-
 disk-utils/sfdisk.c | 4751 ++++++++++++++++++++++++++-------------------------
 3 files changed, 2417 insertions(+), 2340 deletions(-)

-- 
1.8.1.4

