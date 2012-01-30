Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab2A3M0x (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Jan 2012 07:26:53 -0500
Date: Mon, 30 Jan 2012 13:26:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Rogier Goossens <goossens.rogier@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid fails to detect not-so-big OCFS2 filesystems
Message-ID: <20120130122651.GD22107@x2.net.home>
References: <201201271818.19325.goossens.rogier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201201271818.19325.goossens.rogier@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 27, 2012 at 06:18:18PM +0100, Rogier Goossens wrote:
> While testing KDE partitionmanager, I discovered that blkid did not 
> detect the test OCFS2 filesystem I created. After some investigation, 
> it appeared that it will assume the filesystem cannot be OCFS2 if 

 yes, we don't want to probe for some filesystems on very small
 devices.

> smaller than 108M. However, mkfs.ocfs2 from ocfs2-tools (1.6.3) will 
> happily create filesystems that are much smaller, only failing below 
> approx. 15000 1k blocks, and below approx. 6000 4k blocks.

 OK, fixed ... the new limit is 14000 * 1024.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
