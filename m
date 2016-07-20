Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:49310 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbcGTMgT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jul 2016 08:36:19 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C9903ACCE
	for <util-linux@vger.kernel.org>; Wed, 20 Jul 2016 12:36:17 +0000 (UTC)
From: Ales Novak <alnovak@suse.cz>
To: util-linux@vger.kernel.org
Cc: nfbrown@suse.com, jeffm@suse.com, Ales Novak <alnovak@suse.cz>
Subject: [PATCH] libmount: match host:/path and host://path
Date: Wed, 20 Jul 2016 14:36:08 +0200
Message-Id: <1469018169-5650-1-git-send-email-alnovak@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We've encoutered issues with "user" mount option (which is userspace-stored)
and NFSv4 mounts. The problem is that with NFSv4, the mount path appearing in
/proc/mounts may begin with different count of slashes than the one for which
the client asked (e.g. which is in /etc/fstab), causing not-matching records in
/run/mount/utab, and later the "user" mounts not user-unmountable.

Though I'd be happier with a clean solution within the kernel, I've been told
that this is not possible at the moment. So my workaround is to fix libmount to
treat mount paths containing ':' differently, ignore the difference amongst
slashes count directly after the ':'.

Ales Novak (1):
  libmount: after colon, ignore double slashes in path start

 include/strutils.h |  1 +
 lib/strutils.c     | 36 ++++++++++++++++++++++++++++++++++++
 libmount/src/fs.c  |  2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.7.0

