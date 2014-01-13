Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbaAMNj5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Jan 2014 08:39:57 -0500
Date: Mon, 13 Jan 2014 14:39:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: nilfs2 backup superblock detection
Message-ID: <20140113133951.GC12700@x2.net.home>
References: <52C2316C.6010705@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52C2316C.6010705@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 30, 2013 at 09:52:28PM -0500, Phillip Susi wrote:
> Just noticed that the nilfs2 blkid probe code does not check for the
> backup superblock, so adding that might be nice.

 Improved. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
