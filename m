Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADFAC433F5
	for <util-linux@archiver.kernel.org>; Mon,  7 Feb 2022 18:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiBGST4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Feb 2022 13:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbiBGSO6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Feb 2022 13:14:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9198C0401DC
        for <util-linux@vger.kernel.org>; Mon,  7 Feb 2022 10:14:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 737BD11B3
        for <util-linux@vger.kernel.org>; Mon,  7 Feb 2022 10:14:56 -0800 (PST)
Received: from debian (unknown [10.57.3.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9777D3F718
        for <util-linux@vger.kernel.org>; Mon,  7 Feb 2022 10:14:55 -0800 (PST)
Date:   Mon, 7 Feb 2022 19:14:50 +0100
From:   Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (MBR) recognize EBBR protective partitions
Message-ID: <YgFhmowzGeXjfDEH@debian>
References: <20211203155908.6906-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211203155908.6906-1-vincent.stehle@arm.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

Is there any concern with this patch[1] adding support for EBBR protective
partitions to fdisk, please?

I have verified that it does still apply to the master branch of util-linux.
Do not hesitate to let me know if changes need to be made.

If that can be of any help, a similar change[2] has now been accepted in
busybox.

Best regards,

--
Vincent Stehlé
System Architect - Arm

[1]: https://marc.info/?l=util-linux-ng&m=163854721714647&w=2
[2]: https://git.busybox.net/busybox/commit/?id=a93668cc4277b14eaff07fcfdef9693c990ec824
