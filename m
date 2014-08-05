Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37262 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006AbaHEHKd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 Aug 2014 03:10:33 -0400
Date: Tue, 5 Aug 2014 09:10:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: util-linux@vger.kernel.org
Subject: Re: ? fdisk -l bug: wrong devices listed ?
Message-ID: <20140805071029.GC12104@x2.net.home>
References: <53E04EE1.1090107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53E04EE1.1090107@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 04, 2014 at 11:26:25PM -0400, Felix Miata wrote:
> fdisk: cannot open /dev/sr0: No medium found

 Seems like already fixed bug:

commit 52d92543ffb8efb56036f316a1072d8fbba62c38
Author: Karel Zak <kzak@redhat.com>
Date:   Mon Jul 28 11:57:10 2014 +0200

    fdisk: fix -l [<device>]
    
     * don't use err(), but warn(), so don't stop after the first error
    
     * display all errors when "-l <device> ..." specified
    
     * display only EACCES errors when list whole disks from
       /proc/partitions ("fdisk -l" )
    
    Reported-by: Boian Bonev <bbonev@ipacct.com>
    Addresses: https://github.com/karelzak/util-linux/pull/106
    Signed-off-by: Karel Zak <kzak@redhat.com>

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
