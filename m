Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC8CC43216
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35671604DC
	for <util-linux@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhHPQw1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:52:27 -0400
Received: from luckmann.name ([213.239.213.133]:50635 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230420AbhHPQw1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 16 Aug 2021 12:52:27 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000BD6036.00000000611A97A9.00000F56; Mon, 16 Aug 2021 18:51:53 +0200
Date:   Mon, 16 Aug 2021 18:51:53 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     util-linux@vger.kernel.org
Cc:     mario.blaettermann@gmail.com
Subject: Issue in man page fdisk.8
Message-ID: <20210816165153.GA3911@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Without further ado, the following was found:

Issue: Are partitions to be marked as "volume" or "volume header"?

"An IRIX/SGI disklabel can describe 16 partitions, the eleventh of which "
"should be an entire `volume\\(aq partition, while the ninth should be "
"labeled `volume header\\(aq. The volume header will also cover the partition "
"table, i.e., it starts at block zero and extends by default over five "
"cylinders. The remaining space in the volume header may be used by header "
"directory entries. No partitions may overlap with the volume header. Also do "
"not change its type or make some filesystem on it, since you will lose the "
"partition table. Use this type of label only when working with Linux on IRIX/"
"SGI machines or IRIX/SGI disks under Linux."
