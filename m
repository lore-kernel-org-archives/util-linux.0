Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45817 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2A0RS2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jan 2012 12:18:28 -0500
Received: by eekc14 with SMTP id c14so638631eek.19
        for <util-linux@vger.kernel.org>; Fri, 27 Jan 2012 09:18:27 -0800 (PST)
From: Rogier Goossens <goossens.rogier@gmail.com>
To: util-linux@vger.kernel.org
Subject: libblkid fails to detect not-so-big OCFS2 filesystems
Date: Fri, 27 Jan 2012 18:18:18 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201201271818.19325.goossens.rogier@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

While testing KDE partitionmanager, I discovered that blkid did not 
detect the test OCFS2 filesystem I created. After some investigation, 
it appeared that it will assume the filesystem cannot be OCFS2 if 
smaller than 108M. However, mkfs.ocfs2 from ocfs2-tools (1.6.3) will 
happily create filesystems that are much smaller, only failing below 
approx. 15000 1k blocks, and below approx. 6000 4k blocks.

Kind regards,

Rogier.
