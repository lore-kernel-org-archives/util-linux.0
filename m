Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49208 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab1LKS6I (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 Dec 2011 13:58:08 -0500
Received: by qcqz2 with SMTP id z2so3142322qcq.19
        for <util-linux@vger.kernel.org>; Sun, 11 Dec 2011 10:58:08 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 0/2] Add user-defined fstab location for findmnt
Date: Sun, 11 Dec 2011 13:58:03 -0500
Message-Id: <1323629885-17940-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This adds an optional argument to the --fstab parameter of findmnt to allow for
a custom location of /etc/fstab. The first patch is a minor fixup for a bug I
discovered while testing.

Dave Reisner (2):
  findmnt: use warnx for libmnt error callback
  findmnt: support alternative location of fstab

 misc-utils/findmnt.8 |    6 ++++--
 misc-utils/findmnt.c |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
1.7.8

