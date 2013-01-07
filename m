Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16751 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab3AGMKl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Jan 2013 07:10:41 -0500
Date: Mon, 7 Jan 2013 13:10:26 +0100
From: Karel Zak <kzak@redhat.com>
To: helmut@hullen.de
Cc: util-linux@vger.kernel.org
Subject: Re: blkid tells different informations to user or root
Message-ID: <20130107121026.GE28963@x2.redhat.com>
References: <COGoGFiPCXB@helmut.hullen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <COGoGFiPCXB@helmut.hullen.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 05, 2013 at 12:20:00PM +0100, Helmut Hullen wrote:
> Running "blkid" as an underprivileged user apparently shows data (for  
> sdb) which don't fit for the actually configuration.

 Sure, if you have no permissions to revalidate the data...

> a) where's the bug for this different output?

 It's expected behavior, this is reason why programs like mount(8)
 have suid permissions.

 Please, use lsblk(1) if you want see more reliable overview about
 system block devices. It reads data from /sys and some details from
 udevd DB.

> b) how can I create an actual "/run/blkid/blkid.tab"? Only via "rm"?

 It should be unnecessary for privileged users.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
