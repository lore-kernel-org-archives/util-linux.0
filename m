Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbeCES4L (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Mar 2018 13:56:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBDFC85376
        for <util-linux@vger.kernel.org>; Mon,  5 Mar 2018 18:56:11 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-116-54.phx2.redhat.com [10.3.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85EBC5D9CA
        for <util-linux@vger.kernel.org>; Mon,  5 Mar 2018 18:56:11 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 0/1] Hide private Stratis device mapper devices
Date: Mon,  5 Mar 2018 12:56:10 -0600
Message-Id: <20180305185611.16667-1-tasleson@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stratis like lvm is utilizing device mapper thin provisioning feature.  Thus
internal devices which should not be manipulated by end users show up with
blkid when they should not contain any relevant data.  See commit:
20e1c3dc03399d6988ef35dedc1364cfc12e9263 for more background.

Tony Asleson (1):
  libblkid: ignore private Stratis devices

 disk-utils/fdisk-list.c |  2 +-
 include/sysfs.h         |  2 +-
 lib/sysfs.c             | 39 +++++++++++++++++++++++++++++----------
 libblkid/src/probe.c    |  4 ++--
 libblkid/src/verify.c   |  2 +-
 5 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.13.6

