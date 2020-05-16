Return-Path: <SRS0=aJkk=66=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27028C433E0
	for <util-linux@archiver.kernel.org>; Sat, 16 May 2020 08:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6232074D
	for <util-linux@archiver.kernel.org>; Sat, 16 May 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUSTMI57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgEPIKb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 16 May 2020 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgEPIKa (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 16 May 2020 04:10:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F05C061A0C
        for <util-linux@vger.kernel.org>; Sat, 16 May 2020 01:10:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so6016764wrt.5
        for <util-linux@vger.kernel.org>; Sat, 16 May 2020 01:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QIxnxEVlwB42KLcH5wvkrA4U5f21nd5Z0Uu5ZG6X0iM=;
        b=lUSTMI57xUAKWGctutinLZ7I7p80B+7gjpuHnY2L763VTB90I3lhS1fxPifDebPalz
         ldSLM8GpCQXt8pO1pJ4xi5MToGTrexJpNf1xA03KLQ9UFdxbzwWm60l3i9BLBIO+60b8
         E9KsYEMegBLVftP2Ts1xNZMnCF20tPrcTRAB+nh1nuSdoM2nhr8DafbLVfnsITNY2jdX
         ZDS8lNyNHmAJLRHRRiPSZbskGN8OuFwlkGPJXv1sxdW7tmha8vlwsRyaEzyehRipxz+v
         9YN5yGrM9YtPT6fqtqVG96dUwiFOYY+seTejkEg+Byq57WW5ewl9HwwaTWRFxqc9XvAG
         6KUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QIxnxEVlwB42KLcH5wvkrA4U5f21nd5Z0Uu5ZG6X0iM=;
        b=P9fKVk6+9UHwSqB6rCroJ8vEv3POB48/cK0Bac/cnG0a08cJuymFTaX2Xy17s1VTp+
         ADFXgbia0D4iH+OSu+WCOVK4oD3BB9Jf0K6bKlNW3siLWNdVGOjyXSh+S0nUu1i+mSS0
         uKFZ9/hwyygYan2CdV4IUX9w0OmD87Zb/ezMll2/wwsQNm2Ax01tbXdtNXDfzlf9vo+I
         SSjah+Tw8PF6rB35isqZwKgzhGuMp8uMhSrUKI3t0R9cGoiseghzBPdlxcm0u5w5Rf2x
         7NK3fUXvkFUk8w+u5KNC4yqmfpCMoMc9JhylLhMnRxYXt02esYxU0BVHS9miTqgliEoF
         Lhqw==
X-Gm-Message-State: AOAM531+cKlQUmghM6Yd+d9x2tVbo8xKMs6oThlSgifA49gXMgOU5XkT
        R0KU4XnFPzjOBGRFQhYzTrQ=
X-Google-Smtp-Source: ABdhPJz1r6A7ufmsPfDAN9NxjRw4t2tIWR5Qpt1g+pgXji/pjhJzVU/ye8ds1gMqNCmfx3RkE/GjTQ==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr3518849wrn.423.1589616628968;
        Sat, 16 May 2020 01:10:28 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id b12sm7190185wmj.0.2020.05.16.01.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 01:10:28 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org,
        Sami Kerola <kerolasa@iki.fi>
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH] ipcs.1: ipcs no longer needs read permission on IPC resources
Message-ID: <5700d4b6-c499-0881-263c-7df96df511ff@gmail.com>
Date:   Sat, 16 May 2020 10:10:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Michael Kerrisk <mtk.manpages@gmail.com>
Date: Sat, 16 May 2020 09:45:11 +0200
Subject: [PATCH] ipcs.1: ipcs no longer needs read permission on IPC resources

With changes starting around util-linux commit 058e81540fbb0d2b78
that switched from using IPC_STAT to parsing /proc/sysvipc/*,
ipcs now shows all IPC objects rather than just the objects for
which the user has read permission. Update the page to reflect this
fact, and also add a NOTES section describing the historical and
fallback behavior where /proc is not available.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 sys-utils/ipcs.1 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 93c35e323..4b3baaaa5 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -8,8 +8,7 @@ ipcs \- show information on IPC facilities
 [options]
 .SH DESCRIPTION
 .B ipcs
-shows information on the inter-process communication facilities
-for which the calling process has read access.
+shows information on inter-process communication facilities.
 By default it shows information about all three resources:
 shared memory segments, message queues, and semaphore arrays.
 .SH OPTIONS
@@ -76,6 +75,25 @@ Print sizes in bytes.
 .TP
 .B \-\-human
 Print sizes in human-readable format.
+.SH NOTES
+The current implementation of
+.B ipcs
+obtains information about available IPC resources by parsing the files in
+.IR /proc/sysvipc .
+Before util-linux version v2.23, an alternate mechanism was used: the
+.BR IPC_STAT
+command of
+.BR msgctl (2),
+.BR semctl (2),
+and
+.BR shmctl (2).
+This mechanism is also used in later util-linux versions in the case where
+.I /proc
+is unavailable.
+A limitation of the
+.B IPC_STAT
+mechanism is that it can only be used to retrieve information about
+IPC resources for which the user has read permission.
 .SH SEE ALSO
 .BR ipcmk (1),
 .BR ipcrm (1),
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
