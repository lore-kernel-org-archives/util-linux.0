Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B987EB64D9
	for <util-linux@archiver.kernel.org>; Tue, 11 Jul 2023 03:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGKDM0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Jul 2023 23:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGKDM0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 10 Jul 2023 23:12:26 -0400
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B65EE3
        for <util-linux@vger.kernel.org>; Mon, 10 Jul 2023 20:12:21 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee864acc8927c6-ece00;
        Tue, 11 Jul 2023 11:12:20 +0800 (CST)
X-RM-TRANSID: 2ee864acc8927c6-ece00
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee664acc892f56-5a117;
        Tue, 11 Jul 2023 11:12:19 +0800 (CST)
X-RM-TRANSID: 2ee664acc892f56-5a117
From:   zhujun2 <zhujun2@cmss.chinamobile.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhujun2@cmss.chinamobile.com
Subject: Re: [PATCH] blkid: solve a bug that the disk device of the ceph_bluestore
Date:   Mon, 10 Jul 2023 20:12:18 -0700
Message-Id: <20230711031218.4579-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620095725.juhogmjqjue4ohjf@ws.net.home>
References: <20230620095725.juhogmjqjue4ohjf@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 20, 2023 at 10:35:32AM +0800, karel wrote:
> Not sure if I understand. According to docs BlueStore uses XFS
> partition to store metadata and another device to store raw data. It
> sounds like the XFS should be visible as a normal filesystem.

> From your description it sounds like the both is on the same device
> and we should not detect it as XFS log. If yes, then I do not
> understand why anyone use XFS log header for this purpose.

> XFS log detection seems robust, so I guess if libblkid detects the
> superblock then it's really the FS.

You can specify another disk device to store the external log for the XFS file system, similar to the following command:
mkfs.xfs -l logdev=/dev/nvme0n1p2,size=10000b /dev/nvme0n1p3

Using the dd command, you can copy the first sector of /dev/nvme0n1p2 to any sector between 17 and 512 of the 
Ceph BlueStore file system for disk device A, for example, sector 51. After performing this action, a problem occurs where an additional file system, 
efs_external_log, is created on the disk device A originally used for Ceph BlueStore. 
This leads to udev errors and the loss of the disk device A's partlabel. for example

blkid -o udev -p /dev/xxxx
ID_FS_AMBIVALIENT=other:ceph_blueStore other:efs_external_log

Ceph BlueStore file system for Disk device A is exposed as a block device for users to use as a cloud disk. 
Users can create an XFS External Log on it.

zhujun2

>> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
>> ---
>>  libblkid/src/superblocks/xfs.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
>> index d8c6fb6d4..3686bd52b 100644
>> --- a/libblkid/src/superblocks/xfs.c
>> +++ b/libblkid/src/superblocks/xfs.c
>> @@ -259,6 +259,11 @@ static int probe_xfs_log(blkid_probe pr,
>>  		if (memcmp(&buf[i*512], "XFSB", 4) == 0)
>>  			return 1;
>>  
>> +		if (memcmp(&buf[i*512], "bluestore block device", 22) == 0) {
>> +			DBG(LOWPROBE, ul_debug("\t device has ceph_bluestore ambivalent"));
>> +			return 1;
>> +		}
>> +
>>  		rhead = (struct xlog_rec_header *)&buf[i*512];
>>  
>>  		if (xlog_valid_rec_header(rhead)) {
>> -- 
>> 2.20.1


