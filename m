Return-Path: <SRS0=EzkW=RO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA4C43381
	for <util-linux@archiver.kernel.org>; Mon, 11 Mar 2019 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520AE2087C
	for <util-linux@archiver.kernel.org>; Mon, 11 Mar 2019 21:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfCKVQb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:16:31 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:46318 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCKVQb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Mar 2019 17:16:31 -0400
X-Greylist: delayed 1163 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 17:16:31 EDT
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id x2BKv5Pp080826
        for <util-linux@vger.kernel.org>; Mon, 11 Mar 2019 13:57:07 -0700
Message-ID: <5C86CBA1.40802@tlinx.org>
Date:   Mon, 11 Mar 2019 13:57:05 -0700
From:   L A Walsh <lkml@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     util-linux@vger.kernel.org
Subject: does util-linux have a 'report sector size' util?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Trying to track down why my 4K drives no longer display 4K
in sysfs (/sys) and don't seem to show individual disk
drive information.  When I first got the drives, linux displayed
the correct physical disk size, but when I look now, I only
see 512. 

I just checked with MegaCLI, and it can still display all
the data (harddisk manuf. in each bah, and physical sector size).

So I'm wonder if util-linux has something in its blk library
about this?


