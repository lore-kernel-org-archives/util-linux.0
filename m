Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:61031 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641AbcBURzR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Feb 2016 12:55:17 -0500
Received: from assos.lan ([84.185.150.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MTCDO-1aQIiY0C0s-00SA0n for
 <util-linux@vger.kernel.org>; Sun, 21 Feb 2016 18:55:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/4] fix and improve strutils errno usage
Date: Sun, 21 Feb 2016 18:55:10 +0100
Message-Id: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

As discussed in recently here on mailing list.

This is github pull request #285
https://github.com/karelzak/util-linux/pull/285

Ruediger Meier (4):
  lib/strutils: fix errno usage in strtoint functions
  lib/strutils: add more ERANGE messages
  lib/strutils: parse_size(), sync errno and return value
  tests: add logger tests "id _numbers_ with spaces"

 lib/strutils.c                             | 55 +++++++++++++++++-------------
 tests/expected/logger/errors-check_socket  |  7 ++++
 tests/expected/logger/errors-id_with_space |  6 ++++
 tests/ts/logger/errors                     |  4 +++
 4 files changed, 48 insertions(+), 24 deletions(-)

-- 
1.9.1

