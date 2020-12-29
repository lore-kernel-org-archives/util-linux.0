Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D054C433E0
	for <util-linux@archiver.kernel.org>; Tue, 29 Dec 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8ED822209
	for <util-linux@archiver.kernel.org>; Tue, 29 Dec 2020 19:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2TTB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 29 Dec 2020 14:19:01 -0500
Received: from mail.namespace.at ([213.208.148.235]:36246 "EHLO
        mail.namespace.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2TTB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 29 Dec 2020 14:19:01 -0500
Date:   Tue, 29 Dec 2020 20:18:14 +0100
From:   Chris Hofstaedtler <zeha@debian.org>
To:     util-linux@vger.kernel.org
Subject: fsck silently exits when fstype-specific fsck is not found
Message-ID: <20201229191814.ltehybec7ql67xm5@zeha.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

I just noticed that fsck, when given a single device name, silently
exits when it cannot find an appropriate fsck.%s program.

Example:
  (/dev/sda1 is an EFI System Partition, so type=vfat)
  # fsck -V /dev/sda1
  fsck from util-linux 2.36.1
  # echo $?
  0

Note that it also does not warn about fsck.vfat not being found or
anything really.

This appears because fsck.c has a "really_wanted" list of fstypes;
anything not in there gets the mentioned behaviour.

I find this to be very surprising. What are the reasons for this?

I could try changing this code path, but I'm not sure if this is
expected in the first place?

Thanks,
Chris

