Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeC0Q2S (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Mar 2018 12:28:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE201C04B943
        for <util-linux@vger.kernel.org>; Tue, 27 Mar 2018 16:28:17 +0000 (UTC)
Received: from [10.3.116.224] (ovpn-116-224.phx2.redhat.com [10.3.116.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCFA75D9D6
        for <util-linux@vger.kernel.org>; Tue, 27 Mar 2018 16:28:17 +0000 (UTC)
Reply-To: tasleson@redhat.com
To: util-linux@vger.kernel.org
From: Tony Asleson <tasleson@redhat.com>
Subject: Clarification on blkid_do_safeprobe
Message-ID: <851d5595-3f7e-8198-5b23-fde793ec31fd@redhat.com>
Date: Tue, 27 Mar 2018 11:28:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From looking at the documentation and the code for blkid_do_safeprobe
it's not totally apparent to me that when the function returns -2
(ambivalent) that there is any results which may be retrieved by
utilizing blkid_probe_numof_values and blkid_probe_get_value.

Any clarification on this would be appreciated.  Also, do you only get
the -2 return if BLKID_SUBLKS_BADCSUM is set?

Thanks!
-Tony
