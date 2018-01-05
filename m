Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeAERPk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 5 Jan 2018 12:15:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB01F2D1C6
        for <util-linux@vger.kernel.org>; Fri,  5 Jan 2018 17:15:40 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-116-224.phx2.redhat.com [10.3.116.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D6805DC19
        for <util-linux@vger.kernel.org>; Fri,  5 Jan 2018 17:15:40 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH RFC 0/1] libblkid: Initial support for Stratis
Date: Fri,  5 Jan 2018 11:15:38 -0600
Message-Id: <20180105171539.5948-1-tasleson@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

My initial pass at adding support to libblkid for Stratis
https://github.com/stratis-storage.

Documentation including on disk format (needs a couple of updates):
https://stratis-storage.github.io/StratisSoftwareDesign.pdf

I would like to add the appropriate sample super block img and associated 
test(s) to this patch series as well.  However, at the moment I'm not exactly 
sure how to do that.  Pointers to how that is accomplished would be greatly
appreciated, otherwise I will splunk around in the code base until I figure it
out.

Thanks!

Regards,
Tony Asleson

Tony Asleson (1):
  libblkid: Add support for stratis

 libblkid/src/Makemodule.am             |   1 +
 libblkid/src/superblocks/stratis.c     | 104 +++++++++++++++++++++++++++++++++
 libblkid/src/superblocks/superblocks.c |   1 +
 libblkid/src/superblocks/superblocks.h |   1 +
 4 files changed, 107 insertions(+)
 create mode 100644 libblkid/src/superblocks/stratis.c

-- 
2.13.6

