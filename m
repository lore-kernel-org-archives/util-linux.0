Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81830C47082
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684CE61246
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 16:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhFHQ5E (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:57:04 -0400
Received: from mx1.riseup.net ([198.252.153.129]:46806 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232982AbhFHQ5E (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 8 Jun 2021 12:57:04 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 12:57:04 EDT
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Fzx5y6FhhzDqr4
        for <util-linux@vger.kernel.org>; Tue,  8 Jun 2021 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1623170950; bh=2VRTgpfx2a1vvqWoSAuPVARUa5J4cBFuRM+fuxxhw70=;
        h=To:From:Subject:Date:From;
        b=VjHZ/O6jHkEs5UNcea+R7qQ8qr5KdE/mYltt3FtcjyJSrReINlu8AM9uY6ukWAk7V
         67wpFiRm50ekxGpO79FdiMEXYyzknrYHimFVfX3kEDMIONBpHVm5lxXIsVTyv/uZ17
         Z9+3OkVos5zk4v/Yk9kfrxKXYm8C5UbKDWSXNFnM=
X-Riseup-User-ID: 18F5F8F55864C915FDE7CD25D97DEB60DF99EF257AEDE55110445601E14C92D3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Fzx5y30Fqz5w2G
        for <util-linux@vger.kernel.org>; Tue,  8 Jun 2021 09:49:10 -0700 (PDT)
To:     util-linux@vger.kernel.org
From:   Porrumentzio <porrumentzio@riseup.net>
Subject: Translating chsh
Message-ID: <fd0b3838-845f-91fe-3983-507dea56ec8f@riseup.net>
Date:   Tue, 8 Jun 2021 18:49:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi, I want to translate chsh, which I suppose is in util-linux package.
How are the translation managed? Where should I send the edited files?

The PO(T)s are only in /po and /po-man, from the root of
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/
<https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/>,
right?

