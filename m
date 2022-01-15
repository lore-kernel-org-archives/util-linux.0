Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF23C433EF
	for <util-linux@archiver.kernel.org>; Sat, 15 Jan 2022 16:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiAOQ3l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 15 Jan 2022 11:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiAOQ3k (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jan 2022 11:29:40 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB1C061574
        for <util-linux@vger.kernel.org>; Sat, 15 Jan 2022 08:29:40 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id bt14so7479825qvb.13
        for <util-linux@vger.kernel.org>; Sat, 15 Jan 2022 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T45leEQHFmqTlrGiXViZNrbDU/DyCEfxXyvpbjrECyY=;
        b=GEuZ0/UD0hX5W3TvpaU3nmd9pr8393RWUszouP2t1TW79Z0iktUm2QennBRSAfvCa2
         AOQSbrP/uV9/yvSt8sE7VbbfTFw6XWwM7QkI4Wwr+NkvXPZsal9Hxlsg0/S2RDU5L6d7
         CBvXal92vkbN2/gWQcSZQ1RZnRIlRLLpT40cIif0CgEgVZOw9t93I/qaG4p9e0IzvTve
         YzEC+omQDSRah+m3E8ZHSLMzlwLSViLlIVIRVkfT/KyrzZdbGoG9wpJDATiPAfFGZHdC
         tnH3Hdt9f2Hh/NBvs1vMEMlKrdrFTk/415GhpvlFnmAWOmWU2wdS8ZeKl6giev9WjF2s
         xFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T45leEQHFmqTlrGiXViZNrbDU/DyCEfxXyvpbjrECyY=;
        b=7g/MuIXkCVDP5Hz7SrVIjagnBSACCIUFPDYf2U7BjL7Bdl/cv7xUR6mG4BQocQ5YA9
         3vnvxsUaZYWOdp03IMfXcnkvUVmrmP2Ne73iFN87oqRD61tfMzPaVcqFDZ4ifIPFwwKG
         CNF33IVxes0mE//sGthhqXcQdwIbpmpDwwNH2HYD5TYxVj6d2Z5mqyKotGNBQMhmrcG+
         98TprnciHLCmQsZOT8ygxkgBOt6qdRDB10mI/MfW0Kg7SmN3f4hrZ7cGsADcxYb5LTNA
         GhEt8I0emNNz3R0GXccFVt3T85rsIlLrkGPCQs4UjPd8i6yuTpUVkJNGK02g+Oz08lHQ
         XkCw==
X-Gm-Message-State: AOAM530t9U9+wvr2ITzmhga0CGXgk/HpvcRwhBy2o87Wuj+XgHST01ws
        R5MNRatlEPbrnMHW0fCM5Z5zsEz/r+s=
X-Google-Smtp-Source: ABdhPJyrOreBpYs0v12w2EzRj1XYsRkady4uQL66wg3n33cKko6vIjm0J3XGlE2zLubmI/vu4VXngg==
X-Received: by 2002:ad4:5f0d:: with SMTP id fo13mr12347552qvb.90.1642264179635;
        Sat, 15 Jan 2022 08:29:39 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.gmail.com with ESMTPSA id w14sm6090347qta.6.2022.01.15.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 08:29:39 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Daniel Gerber <dg@atufi.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/2] unshare: Fix parsing of id maps
Date:   Sat, 15 Jan 2022 11:29:25 -0500
Message-Id: <20220115162926.546843-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115162926.546843-1-seanga2@gmail.com>
References: <20220115162926.546843-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

For whatever reason, mem2strcpy places the nul-terminator at the end of
the buffer instead of at the end of the string it copies. This makes it
completely useless for our purposes, since one would have to add a
terminator manually to avoid getting garbage. Just use memcpy instead.

Fixes: ff5dc96eb ("unshare: Add options to map blocks of user/group IDs")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reported-by: Daniel Gerber <dg@atufi.org>
---

 sys-utils/unshare.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 443358952..889c561ca 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -387,8 +387,9 @@ static int uint_to_id(const char *name, size_t sz)
 {
 	char buf[UID_BUFSIZ];
 
-	mem2strcpy(buf, name, sz, sizeof(buf));
-	return strtoul_or_err(name, _("could not parse ID"));
+	memcpy(buf, name, min(sz, sizeof(buf) - 1));
+	buf[sz] = '\0';
+	return strtoul_or_err(buf, _("could not parse ID"));
 }
 
 /**
-- 
2.34.1

