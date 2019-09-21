Return-Path: <SRS0=z6SK=XQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62CC4360D
	for <util-linux@archiver.kernel.org>; Sat, 21 Sep 2019 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC0E2184C
	for <util-linux@archiver.kernel.org>; Sat, 21 Sep 2019 18:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fifth.space header.i=@fifth.space header.b="FySLnYcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfIUS5F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:57:05 -0400
Received: from fifth.space ([45.32.148.28]:47532 "EHLO fifth.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfIUS5E (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 21 Sep 2019 14:57:04 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2019 14:57:04 EDT
Received: from fifth.space (localhost [127.0.0.1])
        by fifth.space (OpenSMTPD) with ESMTP id 10a6afda
        for <util-linux@vger.kernel.org>;
        Sat, 21 Sep 2019 20:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=fifth.space; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=dkim; bh=RNaPlYvmSNSJ+Jax/9/aTkqEugg=; b=FySLnYcfwI1rtWoeZHnR
        5tqdm7Ho13TaGWM3hmXZoheEnFmtXu+U09NdaMQDhA91kNjpxJv5W8HT31o+J9bR
        qY300TjAtc2YcOkq5SiLb4M9fgVYQNoOx4kVMfea8QBoM62+Px/MWNEsmvgWI6Hm
        p526GCxPmHWrkq5qtEVnygOuC89OsO7zS93fqMLy0JQzzoRcYyvOqVBlcgHC3ML2
        dqsB/T7dO5V6OHQdpzNPpUAhMowXwT0+VBeHnEPOOjtbu+iVFKoy260GsbRARedO
        VaRbPRn2qVMlqHt8HRDs63diq5y9+fhduk7fI9MOYKKZWyUC+qO6BYncEo31pu2D
        lg==
DomainKey-Signature: a=rsa-sha1; c=nofws; d=fifth.space; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=dkim; b=IE1tB1VIdvQ0qq8G16VZEB7Cm+PNfuvvvbq4NDxTjLeNDB
        yE06+OJxVY3ksRNf1B5IOCXM1zq1Mb3Gb+Rt4I5TGWc7dNEIqKHjCID42ilflH8a
        qnRMExqxNp3PgU15pV1eBwcOhKbB5hozW4FoKHLKANcG3NqH3/hfQNRj01HgpzG2
        5hhdO8/tcxWBYAy9mv7KASRGN8iey6TuInyMA296m3+ZMcKf8QFfxFjekcEUYRE/
        4m3o23tClyknqV5Ksg3JKWDD5ilAk5SiZdU5S5YbvUYXH1GN0YPNccMtaY643fo3
        piWNPp0alp9UTeB7MRMYK5ZuoNdsJUboS5Tii3LQ==
Received: from localhost (fifth.space [local])
        by fifth.space (OpenSMTPD) with ESMTPA id 0ec81133
        for <util-linux@vger.kernel.org>;
        Sat, 21 Sep 2019 20:50:23 +0200 (CEST)
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Subject: [PATCH 0/2] Fix chsh when called as root
Date:   Sat, 21 Sep 2019 20:50:19 +0200
Message-Id: <20190921185021.10568-1-quinq@fifth.space>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello,

Because chsh was using getpwuid/getpwnam, there was an issue with
subsequent call to readline with tilde expansion which would also call
the same function and overwrite the getpwuid/getpwnam internal storage
struct passwd, replacing passed username results.


