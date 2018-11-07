Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A443C0044C
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 13:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B322081D
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eworm.de header.i=@eworm.de header.b="wa73huBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B322081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eworm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeKGWfn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:35:43 -0500
Received: from mx.mylinuxtime.de ([195.201.174.144]:45016 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGWfn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2018 17:35:43 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 17:35:42 EST
Received: from leda.eworm.de (unknown [87.190.244.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 65091103CC4;
        Wed,  7 Nov 2018 13:55:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 65091103CC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1541595338; bh=Fs6p0aZHOjeuS6inwd8tNM8SmufDHdGKFnmacRphTBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wa73huBETe8yB1w0cTeVSgj7f73o/Tk5KVTwZdQrYlnd6Nc0URD/0642FMJzNu7Va
         RHNw/PsKygnfOufaLu1nCyEDy/62YVxEWqMuKXAK0oSC6sm1M+/QfeoAg0qZeERNGq
         enQ2CzZIwo4uSizepc1mL3oOvUjEjhRnqKtdRbYM=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id CFF02107D49; Wed,  7 Nov 2018 13:55:07 +0100 (CET)
From:   Christian Hesse <list@eworm.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] agetty: fix output of escaped characters
Date:   Wed,  7 Nov 2018 13:55:06 +0100
Message-Id: <20181107125506.8432-1-list@eworm.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107134217.2fe72a87@leda>
References: <20181107134217.2fe72a87@leda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=smtp-only@eworm.de smtp.mailfrom=eworm@leda.eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: se3rateaeqesun1p3mbxi4ohyouy6hf1
X-Rspamd-Queue-Id: 65091103CC4
X-Spamd-Result: default: False [-0.86 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         REPLY(-1.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-3.00)[-0.999,0];
         FORGED_SENDER(0.30)[list@eworm.de,eworm@leda.eworm.de];
         RCVD_TLS_LAST(0.00)[];
         ASN(0.00)[asn:3320, ipnet:87.128.0.0/10, country:DE];
         FROM_NEQ_ENVFROM(0.00)[list@eworm.de,eworm@leda.eworm.de];
         BAYES_HAM(-2.07)[95.45%];
         RCVD_COUNT_TWO(0.00)[2]
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 term-utils/agetty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 05a269abb..b9f08728e 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2755,7 +2755,7 @@ static void output_special_char(struct issue *ie,
 		break;
 	}
 	default:
-		putchar(c);
+		putc(c, ie->output);
 		break;
 	}
 }
