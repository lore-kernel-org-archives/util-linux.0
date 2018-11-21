Return-Path: <SRS0=M2R7=OA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349E7C43441
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 18:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DB921479
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 18:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DB921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datacom.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeKVEgV convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:36:21 -0500
Received: from mx.datacom.ind.br ([177.66.5.10]:39238 "EHLO
        mail.datacom.com.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730780AbeKVEgV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 21 Nov 2018 23:36:21 -0500
Received: from mail.datacom.com.br (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTPS id 765A41BA3B91
        for <util-linux@vger.kernel.org>; Wed, 21 Nov 2018 16:01:35 -0200 (-02)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTP id 658BA1BA3BD8
        for <util-linux@vger.kernel.org>; Wed, 21 Nov 2018 16:01:35 -0200 (-02)
Received: from mail.datacom.com.br ([127.0.0.1])
        by localhost (mail.datacom.com.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cVra56FIespY for <util-linux@vger.kernel.org>;
        Wed, 21 Nov 2018 16:01:35 -0200 (-02)
Received: from mail.datacom.com.br (mail.datacom.com.br [172.25.4.13])
        by mail.datacom.com.br (Postfix) with ESMTP id 2EA6F1BA3BD3
        for <util-linux@vger.kernel.org>; Wed, 21 Nov 2018 16:01:35 -0200 (-02)
Date:   Wed, 21 Nov 2018 16:01:34 -0200 (BRST)
From:   Carlos Santos <casantos@datacom.com.br>
To:     util-linux <util-linux@vger.kernel.org>
Message-ID: <228628908.3067721.1542823294457.JavaMail.zimbra@datacom.com.br>
Subject: Build failure for SPARC after commit 1db8bf937
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.31.206.21]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF63 (Linux)/8.8.10_GA_3041)
Thread-Index: JumiEb4HqlZbzhY39VnV0OAk36Ds1w==
Thread-Topic: Build failure for SPARC after commit 1db8bf937
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is still a call to the now-defunct set_arch function in
sys-utils/setarch.c:

313 #if defined(__sparc64__) || defined(__sparc__)
314         if (strcmp(arch, "sparc32bash") == 0) {
315             if (set_arch(arch, 0L, 0))
316                 err(EXIT_FAILURE, _("Failed to set personality to %s"), arch);
317             execl("/bin/bash", "", NULL);
318             errexec("/bin/bash");
319         }
320 #endif

The full build log is available at

    http://autobuild.buildroot.net/results/44d0538332499cea691a381048562a09cda23624/build-end.log

-- 
Carlos Santos (Casantos) - DATACOM, P&D
Rua América, 1000 - Eldorado do Sul, RS, Brasil - 92990-000
casantos@datacom.com.br          +55 51 3933.3000 ext. 3627
http://www.datacom.com.br
