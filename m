Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E74C433F5
	for <util-linux@archiver.kernel.org>; Sun,  6 Feb 2022 06:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiBFGMT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 6 Feb 2022 01:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBFGMS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 6 Feb 2022 01:12:18 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D4C06173B
        for <util-linux@vger.kernel.org>; Sat,  5 Feb 2022 22:12:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cn6so214725edb.5
        for <util-linux@vger.kernel.org>; Sat, 05 Feb 2022 22:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8p+sC5ac7/JhL4+BjkNuLHiymibR0F6zRKGISCrCodY=;
        b=gRMRkAfWWv0P3/S6jwF2UN3rUWeeAO+l/tnHWzuSh4OHKDu20X5Cnj0pHFE6e8GAIu
         zfbYTrAMS2L2jNhwyPbamlnjc1kuaO5mbGaQoqnQHjZUiRQGwxN7uc0CKpjnzFdmtq8E
         ZZq8Jjf/sV8evi55/7nxq9mqDmtWCxoP4SS0LNVtf3uQUqtOinTmUG8A5ctMq8LCsY23
         jvKJ3Kr7/6xwLq7LBWYG33TTDzUrKDeYpgQEkseaFrtDXDNGylQGLqRF5TOzfzLMjZnh
         1VnYegvsXKS0SuOjyEW+WZeHsrzcjWYYgd+BlsuTtjrFN69r9lhCMHNIiiRoeAcBglCH
         6w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8p+sC5ac7/JhL4+BjkNuLHiymibR0F6zRKGISCrCodY=;
        b=NtLhEnbcvgEN91l8h6sh4oMZ8ItuwnryqMUYpvGz2MI0fD10qftFUf0aJSVf1N3Ha1
         v2BpJzYmL9ZP9E4w7GpehyimabKnF17ifKvXS/8RswKIrvglE7McoKIleoDlA1xMQvn1
         ulEA3rXiqLxBTZHe3ngRaz/ozCW5eRoyJMMXG7ZwuslgdQfWRBfoKRlmOicRT2zYoOSx
         1vC51n6JQopK8oVlUQxLa6+DiCf6Ly20xfNMWgig2nSVg4ToNx2iIMKqtL1gKoRLR/EV
         5WC3vCrbYBox5n5EtiRdpCu+751xFZZEu77L60cci2houiTpKfMH/6OHvpD21/A7t/nl
         Nc4A==
X-Gm-Message-State: AOAM531J+6bMkusPUueNeQ/sEv79fcvzRhV5v0bd9hbKi3p5skzxl5/e
        P07DPnfrczdEVam5lOhisF+GVDNh0W4=
X-Google-Smtp-Source: ABdhPJxy7elK1eeBHKFyiovCKessKSrwe8n2+SAby+YCthPVooGT4s18AKUTQe8V3BYdqR0VIl4TIQ==
X-Received: by 2002:aa7:d4d9:: with SMTP id t25mr7453618edr.431.1644127935875;
        Sat, 05 Feb 2022 22:12:15 -0800 (PST)
Received: from localhost.localdomain (178.115.71.30.wireless.dyn.drei.com. [178.115.71.30])
        by smtp.gmail.com with ESMTPSA id bv2sm2264420ejb.154.2022.02.05.22.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 22:12:15 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 3/4] kill.1.adoc: clarify syntax of -SIG argument in synopsis
Date:   Sun,  6 Feb 2022 07:11:57 +0100
Message-Id: <20220206061158.752262-3-aclopte@gmail.com>
X-Mailer: git-send-email 2.35.1.301.gcdacdcff8b.dirty
In-Reply-To: <20220206061158.752262-1-aclopte@gmail.com>
References: <20220206061158.752262-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

kill.1.adoc has this synopsis line

	*kill*  [-signal|*-s* _signal_]

For "-signal", the leading "-" should be typed literally, and the
"signal" suffix should be replaced by a signal name/number.
This means that according to GNU man(1), the "-" should render in
bold font whereas the "signal" placeholder should use italic (which
terminals often render with underscores).

Make it so. Use two askerisks because one is not enough for sub-word
markup [*].

[*] https://docs.asciidoctor.org/asciidoc/latest/text/#unconstrained

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 misc-utils/kill.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/kill.1.adoc b/misc-utils/kill.1.adoc
index afdf345fd..4a6996a38 100644
--- a/misc-utils/kill.1.adoc
+++ b/misc-utils/kill.1.adoc
@@ -17,7 +17,7 @@ kill - terminate a process
 
 == SYNOPSIS
 
-*kill*  [-signal|*-s* _signal_|*-p*]  [*-q* _value_] [*-a*] [*--timeout* _milliseconds_ _signal_] [*--*] _pid_|_name_...
+*kill*  [**-**_signal_|*-s* _signal_|*-p*]  [*-q* _value_] [*-a*] [*--timeout* _milliseconds_ _signal_] [*--*] _pid_|_name_...
 
 *kill* *-l* [_number_] | *-L*
 
-- 
2.35.1.301.gcdacdcff8b.dirty

