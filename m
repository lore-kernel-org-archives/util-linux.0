Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C5C433E0
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9022081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTZaIBZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgESMwX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgESMwX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:52:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA8C08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:52:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so15771030wrt.9
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TwGFFUwhfyFdnPwC2Nag66sT81UlD1wQvLPaooz6d4E=;
        b=KTZaIBZydWe+yUHy1mVoVyjgPNKXbPzdzOle6JV4k/SwasvWgY3yY0x5gclazS0Hvx
         LYZB7U16ZZohd0Mq6wU3eJ9KIt19QypUnYSq0o+V3Avoh+z5asUG/pbQj8/SorQu3jZf
         HUDAsO8exa3RgXxst9yRGRQt2GGoTLntzmTKTbHwXki/RuhA83v7SzYe7GqEQ5tMeujR
         /s+cA2ezoI5ZSOA3ni9n+O5Wbwp8pQJ6RPij9K+RyvAUQta06rbEpOXX7NMefAvwPtV0
         BT6YB1W9wAKxn6C8jRxar0RUrg8oGYyRUYQ1E5x0TKxA88nsnjjKwpZ4CFVuqEjYhoGl
         KYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TwGFFUwhfyFdnPwC2Nag66sT81UlD1wQvLPaooz6d4E=;
        b=cMYxkDMFiC2fiym89G1hgQodqDhS3c+qqzDJeNKH11p4Slw+MgVOmmp5zPbSsw8u0E
         ePQjXxu2dqRe66Mf63DG6QpaGXvE2x0kSb/9uGFVyhdL+MfruQvDwIvPJFgNtMiGa4n2
         1z/fZx2O7qL/5Z+JkpHTXsrnmjDOrIqYbWLrqLnJLUECMc3qTDqsVjT5qwoGe1Q0yNbw
         0oeKTYF7ph8Qe52cYG2bHbhMtZ8iJ91BoY9JMeezOQAjWiJR4TkewbWghgrNZsrxyOmt
         I09NjZAtoddexa+vZz4Ky9/fDHnNfizJ/LjIwm4mGduAqjtO0FR/FZ/wXe4cFERNh57m
         XZRg==
X-Gm-Message-State: AOAM532eFWz/XIJlF7h2pse0lbEQ3p5j6mw3PsMfioSN/je1T/i9yAFK
        xO5TnaGqbEtkQ8HAUSsOLL/IWfzUa/E=
X-Google-Smtp-Source: ABdhPJzF/HA6CHKFuYwpvl5gfAft+gloL+JqxfU8JRrUDCS9RRvFCIffzCtWp7Sl+CLn2yYiF9J+iA==
X-Received: by 2002:a5d:4ccd:: with SMTP id c13mr26197008wrt.415.1589892741382;
        Tue, 19 May 2020 05:52:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id m65sm3999613wmm.17.2020.05.19.05.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:52:20 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 3/7] Manual pages: Standardize on CONFORMING TO as section
 title
Message-ID: <2eb70c8e-d7a0-af14-9de8-808967fd1cf6@gmail.com>
Date:   Tue, 19 May 2020 14:52:20 +0200
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

There is quite some value (in terms of readability and user
expectations) if consistent names are used for the sections
within manual pages. This patch is one of a series to bring
about this consistency.

Currently we have STANDARDS (3) or CONFORMING TO (6).
Let's standardize on the latter (which is also what is
suggested in man-pages(7)).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 misc-utils/logger.1  | 2 +-
 text-utils/col.1     | 2 +-
 text-utils/hexdump.1 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 731695aed..b2f2133ae 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -355,7 +355,7 @@ For the priority order and intended purposes of these facilities and levels, see
 .BR journalctl (1),
 .BR syslog (3),
 .BR systemd.journal-fields (7)
-.SH STANDARDS
+.SH CONFORMING TO
 The
 .B logger
 command is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
diff --git a/text-utils/col.1 b/text-utils/col.1
index f0b50b69c..2a9c4dce5 100644
--- a/text-utils/col.1
+++ b/text-utils/col.1
@@ -141,7 +141,7 @@ will display a warning message.
 .BR expand (1),
 .BR nroff (1),
 .BR tbl (1)
-.SH STANDARDS
+.SH CONFORMING TO
 The
 .B col
 utility conforms to the Single UNIX Specification, Version 2.  The
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 66ff157f7..4af4ffe0e 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -369,7 +369,7 @@ Implicit coloring can be disabled by an empty file \fI/etc/terminal-colors.d/hex
 See
 .BR terminal-colors.d (5)
 for more details about colorization configuration.
-.SH STANDARDS
+.SH CONFORMING TO
 The
 .B hexdump
 utility is expected to be IEEE Std 1003.2 ("POSIX.2") compatible.
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
