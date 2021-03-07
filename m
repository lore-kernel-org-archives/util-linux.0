Return-Path: <SRS0=9FCZ=IF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7F8C433E0
	for <util-linux@archiver.kernel.org>; Sun,  7 Mar 2021 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F19F64F98
	for <util-linux@archiver.kernel.org>; Sun,  7 Mar 2021 00:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCGA1C (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 6 Mar 2021 19:27:02 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:37120 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhCGA0n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 6 Mar 2021 19:26:43 -0500
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1F588362056
        for <util-linux@vger.kernel.org>; Sun,  7 Mar 2021 00:26:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a11.g.dreamhost.com (100-96-17-38.trex.outbound.svc.cluster.local [100.96.17.38])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AB4F7361F14
        for <util-linux@vger.kernel.org>; Sun,  7 Mar 2021 00:26:42 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
Received: from pdx1-sub0-mail-a11.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.38 (trex/6.0.2);
        Sun, 07 Mar 2021 00:26:43 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|jidanni@jidanni.org
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Arch: 4702572c7833ec0b_1615076802904_2663918199
X-MC-Loop-Signature: 1615076802903:2097193185
X-MC-Ingress-Time: 1615076802903
Received: from pdx1-sub0-mail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a11.g.dreamhost.com (Postfix) with ESMTP id 622E582DC6
        for <util-linux@vger.kernel.org>; Sat,  6 Mar 2021 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jidanni.org; h=from:to
        :subject:date:message-id:mime-version:content-type; s=
        jidanni.org; bh=qAx7c+kr678Zaiy0/uFGlvGIfVU=; b=iS+5AgYvlKHysalb
        n3YQqoR6CdcSTdUNqORSQR6zaWQDHb0b4jbMfli47Gk6PsdcTesJ8pbhfpfQpX6M
        BlFIoP46rsPNT4hy4afsCI3pBt/2Mh7BjtBEGhv+mE2IjN3P7F3m7AydJ2hHxrPU
        397YwwkFXa822J/6NPFQi/xfSFg=
Received: from jidanni.org (114-41-37-222.dynamic-ip.hinet.net [114.41.37.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jidanni@jidanni.org)
        by pdx1-sub0-mail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 931AB7EF6D
        for <util-linux@vger.kernel.org>; Sat,  6 Mar 2021 16:26:41 -0800 (PST)
X-DH-BACKEND: pdx1-sub0-mail-a11
From:   Dan Jacobson <jidanni@jidanni.org>
To:     util-linux@vger.kernel.org
Subject: Mention fdisk -l order on man page
Date:   Sun, 07 Mar 2021 08:05:12 +0800
Message-ID: <87o8fvrfpj.8.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Regarding fdisk -l,
the partitions are sorted
# fdisk -l|grep -P /dev/\\S+\\d|sed 's/ .*//'
/dev/sda1
/dev/sda2
/dev/sda3
/dev/sda4
/dev/sda5
/dev/sda6
/dev/sda7
/dev/sda8

So why can't the disks also be sorted:
# fdisk -l|grep Disk\ /
Disk /dev/sda: 119.24 GiB, 128035676160 bytes, 250069680 sectors
Disk /dev/sdb: 14.91 GiB, 16008609792 bytes, 31266816 sectors
Disk /dev/sdd: 465.76 GiB, 500107862016 bytes, 976773168 sectors
Disk /dev/sdc: 14.46 GiB, 15525216256 bytes, 30322688 sectors
Disk /dev/sdg: 3.8 GiB, 4075290624 bytes, 7959552 sectors
Disk /dev/sdj: 28.84 GiB, 30963400704 bytes, 60475392 sectors
Disk /dev/sdk: 29.72 GiB, 31914983424 bytes, 62333952 sectors
# fdisk -l|grep Disk\ /|sort -c
sort: -:4: disorder: Disk /dev/sdc: 14.46 GiB, 15525216256 bytes, 30322688 sectors

Sure we can do
# fdisk -l /dev/sd?|grep Disk\ /
fdisk: cannot open /dev/sde: No medium found
fdisk: cannot open /dev/sdf: No medium found
fdisk: cannot open /dev/sdh: No medium found
fdisk: cannot open /dev/sdi: No medium found
Disk /dev/sda: 119.24 GiB, 128035676160 bytes, 250069680 sectors
Disk /dev/sdb: 14.91 GiB, 16008609792 bytes, 31266816 sectors
Disk /dev/sdc: 14.46 GiB, 15525216256 bytes, 30322688 sectors
Disk /dev/sdd: 465.76 GiB, 500107862016 bytes, 976773168 sectors
Disk /dev/sdg: 3.8 GiB, 4075290624 bytes, 7959552 sectors
Disk /dev/sdj: 28.84 GiB, 30963400704 bytes, 60475392 sectors
Disk /dev/sdk: 29.72 GiB, 31914983424 bytes, 62333952 sectors

But as you see, there is some noise often.

OK, maybe it is just reading in physical disk/partition/device order
always. OK, mention that on the man page.
