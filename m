Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE12EC4320A
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C619260F92
	for <util-linux@archiver.kernel.org>; Fri, 27 Aug 2021 07:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbhH0HgB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:36:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37290 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbhH0Hfy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 27 Aug 2021 03:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630049705; x=1661585705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=82ixSyQlG/pWDrshmPmny8XDxRFWvxG9hQogj4qxcJQ=;
  b=l79oMC97PayQz5lMXaAmcLufHMuKP4k+Q6N+39+6CMEctJGAu4V/fF76
   BbZ5asmtByAi3JXDdzyqETVJPsZ9a53JYEBG9eVjx+oFBl6mIVCIj+H37
   aJP15So1wjDFDl6yXPfFrQe8B5xd29bWWizbU0UiNH0eK9AB5VBC2mOhV
   npd3n1eGp+BOBj2FGyStFm2EYIB39FYtCweP+tVi1AI4BrJMILKuhg8Pw
   qPUnl7FRdI+fqIAkaJ6TQfDm8H4VUWsrOWbb73714jtW6BeDMFwvB7msu
   bGbJ+XFjXkjU+ZDfZv/goIrQeH3pmJng+jmcf/bID2APNHqVJS90bz0/f
   w==;
X-IronPort-AV: E=Sophos;i="5.84,355,1620662400"; 
   d="scan'208";a="290159626"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Aug 2021 15:35:05 +0800
IronPort-SDR: ezN1AwGLUzWfXQPkaS42PkKZtpLJ4Sju8pBp4TBsbm70q7A8MYrjHwNnEffALrBlsc2tMP3knI
 24ai3HQtw4D0bJj8BXtmOJacicdVKJPg+R8QdLTes8gmcNz1LLJyG/TOsUY05brkr9Gprigu8a
 nknAu3SDxQSSHFUI1IcVwKh3ygT+BVlFozu3LM0yWtJEi8tA1dgP1mtf5EX+osxsUFIa9HOVV5
 88wnmSfNjdvBZ/+xma7EQ5pDTe05y1AT/kgzbVp9xxrsbZf57nVjmEFzePybJRN82LAWn7c91o
 TLSfx9Jb6eHjPlNw+57FpFXQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 00:12:00 -0700
IronPort-SDR: XP+Sw3sXLBBp4sGVKoQdd1snCl+3x7+7+wMA0E4DjKZPnhHclFsZ5WX8mHmfh0OySWGynU6Jsl
 mZQN6V18VkeXnxsohTNWFwn4nAXD58sL8iJ6DUQzUReRTIu+t2xxzrlp2/zN8Ua2kdb+VNXJ0u
 hBSlABTLrHSw929fdXXFcIwm0DNxAvbOCi8Nv6OxykihSeH0EvqEdMxo0lBM8Vp2acMBFYbsbm
 J93rZ3CJRCjh3csulDV3r84nPzSMmXIIe7EavHNOJ9teiiJRWRRbJOuaGwNDHui2HIKrSJtO15
 Q8E=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.59.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Aug 2021 00:35:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] add columns for zoned parameters
Date:   Fri, 27 Aug 2021 16:34:50 +0900
Message-Id: <20210827073453.4079636-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several parameters for zoned devices are missing from lsblk's columns. This
series introduces them as following.

 Column Name   Description             Sysfs path
 ------------------------------------------------------------------
 ZONE-SZ       zone size               queue/chunk_sectors
 ZONE-GRAN     zone write granularity  queue/zone_write_granularity
 ZONE-APP      zone append max bytes   queue/zone_append_max_bytes
 ZONE-NR       number of zones         queue/nr_zones
 ZONE-OMAX     max open zones          queue/max_open_zones
 ZONE-AMAX     max active zones        queue/max_active_zones

These columns are also added to the "-z" output.

Sample output:

$ lsblk -z -i
NAME        ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-GRAN
sda         host-managed    256M   55880         0       128     672K        4K
sdb         host-managed    256M   55880         0       128     672K        4K
zram0       none              0B       0         0         0       0B        0B
nvme2n1     none              0B       0         0         0       0B        0B
|-nvme2n1p1 none              0B       0         0         0       0B        0B
|-nvme2n1p2 none              0B       0         0         0       0B        0B
`-nvme2n1p3 none              0B       0         0         0       0B        0B
nvme0n1     none              0B       0         0         0       0B        0B
nvme1n1     none              0B       0         0         0       0B        0B
nvme0n2     host-managed      2G    1844        14        14       4M        4K
nvme1n2     host-managed      2G    1844        14        14       4M        4K

$ lsblk --help|grep -i zone
 -z, --zoned          print zone model
        ZONED  zone model
      ZONE-SZ  zone size
    ZONE-GRAN  zone write granularity
     ZONE-APP  zone append max bytes
      ZONE-NR  number of zones
    ZONE-OMAX  max open zones
    ZONE-AMAX  max active zones

Naohiro Aota (3):
  lsblk: factor out function to read sysfs param as bytes
  lsblk: add columns of zoned parameters
  lsblk: add zoned columns to "lsblk -z"

 bash-completion/lsblk   |   3 +-
 misc-utils/lsblk.8.adoc |   2 +-
 misc-utils/lsblk.c      | 103 ++++++++++++++++++++++++++++++----------
 3 files changed, 81 insertions(+), 27 deletions(-)

-- 
2.33.0

