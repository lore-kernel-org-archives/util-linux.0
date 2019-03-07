Return-Path: <SRS0=1IjS=RK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75894C43381
	for <util-linux@archiver.kernel.org>; Thu,  7 Mar 2019 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A6820675
	for <util-linux@archiver.kernel.org>; Thu,  7 Mar 2019 13:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCGNok (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:44:40 -0500
Received: from smtp1.cict.fr ([195.220.59.41]:53982 "EHLO smtp1.cict.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfCGNok (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 7 Mar 2019 08:44:40 -0500
X-Greylist: delayed 1106 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Mar 2019 08:44:40 EST
Received: from smtp1.cict.fr (localhost.localdomain [127.0.0.1])
        by smtp1.cict.fr (8.14.5/8.14.4) with ESMTP id x27DQC9s013779
        for <util-linux@vger.kernel.org>; Thu, 7 Mar 2019 14:26:12 +0100
Received: from irsamc.ups-tlse.fr (irsamc.ups-tlse.fr [130.120.228.23])
        by smtp1.cict.fr (8.14.5/8.14.5) with ESMTP id x27DQCfo013776
        for <util-linux@vger.kernel.org>; Thu, 7 Mar 2019 14:26:12 +0100
Received: from [130.120.230.38] (b07-cluster.lcar.ups-tlse.fr [130.120.230.38])
        by irsamc.ups-tlse.fr (Postfix) with ESMTPS id EE8A23614D3
        for <util-linux@vger.kernel.org>; Thu,  7 Mar 2019 14:26:11 +0100 (CET)
To:     util-linux@vger.kernel.org
From:   Pierre Labastie <pierre.labastie@irsamc.ups-tlse.fr>
Subject: Discrepancy between doc and code (harmless)
Message-ID: <338a65b6-b5f7-5a28-5996-5f71d704f5af@irsamc.ups-tlse.fr>
Date:   Thu, 7 Mar 2019 14:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Authentication-Results: irsamc.ups-tlse.fr
X-Virus-Scanned: clamav-milter 0.97.3 at smtp1.cict.fr
X-Virus-Status: Clean
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

It's my first contribution to this mailing list. I am one of the Linux from
scratch developers [1]. I do not know exactly how to proceed for the following
report:

Both hwclock.8 and adjtime_config.5 stipulate that the third number on the
first line of the "adjtime" file is a decimal integer. But the code in
hwclock.c writes and reads it as a double. Since this field is always 0, it
does not matter much, but the doc is not true...

Please, tell me if you'd like to have a patch, but I am not sure I've spotted all
the places in the doc where the information is given.

Regards
Pierre

[1] http://www.linuxfromscratch.org/

