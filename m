Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46604 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab1FLTDB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 12 Jun 2011 15:03:01 -0400
Received: by qwk3 with SMTP id 3so1927488qwk.19
        for <util-linux@vger.kernel.org>; Sun, 12 Jun 2011 12:03:00 -0700 (PDT)
Message-ID: <4DF50D58.9020800@tds.net>
Date: Sun, 12 Jun 2011 15:02:48 -0400
From: John Lindgren <john.lindgren@tds.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: blkid: excessive random reads probing for ZFS on NTFS filesystem
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I noticed blkid causing a noticeable amount of disk hits while
identifying an NTFS (Win7) partition, and did an strace to find out why
this was.  It seems that the probe_zfs() function does a
seek-and-read-41-bytes pattern 64 times in the 130 to 520 KB region of
the partition.  This of course is slow on a traditional hard disk, and
seems excessive.  I don't know the internals of NTFS or of ZFS.  Can
someone with a little more knowledge in this area provide some pointers
as to why this might be happening?

-- John Lindgren
