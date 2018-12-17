Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FECC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE2B2084D
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLQJOZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:14:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJOZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 04:14:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05F314902D;
        Mon, 17 Dec 2018 09:14:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E09648A6;
        Mon, 17 Dec 2018 09:14:24 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:14:21 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Hank Barta <hbarta@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Partitioning or blkid issue?
Message-ID: <20181217091421.zcj3f3bfe3ps6mpu@ws.net.home>
References: <CABTDG89z-g=LmHobptPBmYVzTucz_ZWrPo4yo_Gh7O9ZEQAqfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTDG89z-g=LmHobptPBmYVzTucz_ZWrPo4yo_Gh7O9ZEQAqfQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 17 Dec 2018 09:14:25 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Dec 14, 2018 at 11:53:52AM -0600, Hank Barta wrote:
> I have an issue where `gparted` seems to display incorrect information
> on my system drive (and `parted` seems to report correct information.)
> I filed a bug on Launchpad (since this manifests on Ubuntu 18.10)
> https://bugs.launchpad.net/ubuntu/+source/gparted/+bug/1808421 and was
> directed to https://gitlab.gnome.org/GNOME/gparted/issues/14 which
> does appear to be the same issue. Near the end of the first link is
> information I collected when running Ubuntu 18.04 (from `blkid` and
> `wipefs`)
> 
> I have found that when this system is running Debian Stretch from USB
> that `gparted` appears to produce the correct output. Below is the
> same information collected when running Debian Stretch.
> 
> root@debian:/home/user# apt policy util-linux
> util-linux:
>   Installed: 2.29.2-1+deb9u1
>   Candidate: 2.29.2-1+deb9u1
>   Version table:
>  *** 2.29.2-1+deb9u1 500
>         500 http://deb.debian.org/debian stretch/main amd64 Packages
>         100 /var/lib/dpkg/status
> root@debian:/home/user# blkid /dev/sda
> /dev/sda: LABEL="rpool" UUID="4510611204828545482"
> UUID_SUB="9816084798696086204" TYPE="zfs_member"
> PTUUID="eba09d2e-0f70-4d11-8e37-c1c170cfd9dd" PTTYPE="gpt"
> root@debian:/home/user# wipefs --no-act /dev/sda
> offset               type
> ----------------------------------------------------------------
> 0x200                gpt   [partition table]
> 
> 0xe8e0d3f000         zfs_member   [filesystem]
>                      LABEL: rpool
>                      UUID:  4510611204828545482
> 
> root@debian:/home/user#
> 
> I would like to know if this identifies a problem in the partition
> table or an issue with `blkid`. (Or something else?)
> I don't think I installed a ZFS pool on the entire disk but I could be
> wrong about that. It is also possible that one of my operations did
> cause a problem with the partition table.

It seems like disk originally formatted as ZFS has been later
partitioned by GPT.

In this case it does not seem like false positive ZFS detection. You
need ZFS magic string and guid= (aka UUID_SUB), pool_guid= (aka UUID)
and name= (aka LABEL) variable names and data on the right offsets.

> This is a test system and relatively new install so it would not be a
> huge problem to 'nuke and repave' if that is necessary to fix this or
> to try anything that can further identify the problem.
> 
> Suggestions on what I should do next are most welcome!

The ideal is to use partitioning tools that wipe the disk before it
writes partition table. Or use "wipefs -a" to cleanup all from the
disk before you use it (this is recommended step during system
installation).

For now you can use "wipefs -o 0xe8e0d3f000" to remove only the
unwanted ZFS stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
