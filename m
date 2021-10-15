Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F85C433F5
	for <util-linux@archiver.kernel.org>; Fri, 15 Oct 2021 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B460FF2
	for <util-linux@archiver.kernel.org>; Fri, 15 Oct 2021 14:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhJOOPT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:15:19 -0400
Received: from devianza.investici.org ([198.167.222.108]:27909 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhJOOPT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Oct 2021 10:15:19 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Oct 2021 10:15:18 EDT
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4HW7K96VzBz6vGx
        for <util-linux@vger.kernel.org>; Fri, 15 Oct 2021 14:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
        s=stigmate; t=1634306605;
        bh=sKInpRH6V0NW99yK82mS41S3lNQmrgmei7+697Hyc9k=;
        h=From:To:Subject:Date:From;
        b=LFPR14vDThrw4Bog/f8P4F4/E21D/48qGtXLvck6Sy/wBhRQQLokcaz4pSsntPmrt
         KXJ9L6Q3IfhpSHYyRuhrYk5H1AIfUn1P0IMkin4wdP2Y3TxyJHVh4rsukVcvLZnQtN
         IReGSoI4gk4ocikvZz3UVsNhwjFYBw3vmqh4afks=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: andrea.monaco@autistici.org) by localhost (Postfix) with ESMTPSA id 4HW7K95274z6v9Z
        for <util-linux@vger.kernel.org>; Fri, 15 Oct 2021 14:03:25 +0000 (UTC)
From:   Andrea Monaco <andrea.monaco@autistici.org>
To:     util-linux@vger.kernel.org
Subject: mount: misleading and generic error when trying to mount bad image
Date:   Fri, 15 Oct 2021 16:03:19 +0200
Message-ID: <87mtnamllk.fsf@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Hello,


whenever I try to mount a badly formatted image, like with

  # mount -o loop test.img /mnt/test

I get the error

  mount: /mnt/test: wrong fs type, bad option, bad superblock on
  /dev/loop0, missing codepage or helper program, or other error.


This message seems too vague to me.  Also, the error is about test.img
rather than /mnt/test, so why prefix the message with the mount point?

If you agree with my point, maybe I can work on improving those.



Let me know,

Andrea Monaco
