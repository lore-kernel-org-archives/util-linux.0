Return-Path: <SRS0=DPLT=WP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86397C3A5A0
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAE5205C9
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 12:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfHSM7r (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfHSM7r (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Aug 2019 08:59:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 764CD20ABB;
        Mon, 19 Aug 2019 12:59:47 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC837B32C5;
        Mon, 19 Aug 2019 12:59:46 +0000 (UTC)
Date:   Mon, 19 Aug 2019 14:59:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Kevin Hao <kexin.hao@windriver.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: Keep the mnt_tab info for the existent dest in
 mnt_copy_fs()
Message-ID: <20190819125944.rbiz4v65vo7dtht6@ws.net.home>
References: <20190819083022.12289-1-kexin.hao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819083022.12289-1-kexin.hao@windriver.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 19 Aug 2019 12:59:47 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Aug 19, 2019 at 04:30:22PM +0800, Kevin Hao wrote:
> The "umount -f -a -r" get stuck in a endless loop when run with a
> mountinfo like below:
>   15 0 179:2 / / ro,relatime - ext4 /dev/root ro
>   16 15 0:6 / /dev rw,relatime - devtmpfs devtmpfs rw,size=242896k,nr_inodes=60724,mode=755
>   17 15 0:4 / /proc rw,relatime - proc proc rw
>   18 15 0:15 / /mnt/.psplash rw,relatime - tmpfs tmpfs rw,size=40k
>   19 15 0:16 / /sys rw,relatime - sysfs sysfs rw
>   20 19 0:7 / /sys/kernel/debug rw,relatime - debugfs debugfs rw
>   21 15 0:17 / /run rw,nosuid,nodev - tmpfs tmpfs rw,mode=755
>   22 15 0:18 / /var/volatile rw,relatime - tmpfs tmpfs rw
>   23 15 179:1 / /boot rw,relatime - vfat /dev/mmcblk0p1 rw,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro
>   24 16 0:19 / /dev/pts rw,relatime - devpts devpts rw,gid=5,mode=620,ptmxmode=000
>   25 18 0:20 / /mnt/.psplash rw,relatime - tmpfs tmpfs rw,size=40k
> 
> The reason is that the two same mnt entry "/mnt/.psplash" will cause
> the dst->tab set to NULL when umount this mnt entry the second time.
> This will trigger an endless loop in mnt_reset_table() because that
> mnt entry is linked on the libmnt_table but its .tab is set to NULL.

Good catch! Applied.

The cxt->fs usually does not point to any table, but it's context
specific setting. Unfortunately, umount --all is different, rather
than copy always a new setting from mount table (mtab) it point to the
file. This optimization works thanks to reference counting, but now we
also check for fs->tab and it makes things more tricky.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
