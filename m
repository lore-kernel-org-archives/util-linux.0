Return-Path: <SRS0=Em1C=T6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3121C28CC0
	for <util-linux@archiver.kernel.org>; Thu, 30 May 2019 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3CE258E6
	for <util-linux@archiver.kernel.org>; Thu, 30 May 2019 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE3Mfk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 30 May 2019 08:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3Mfk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 30 May 2019 08:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A8DF307D84D;
        Thu, 30 May 2019 12:35:35 +0000 (UTC)
Received: from ws (unknown [10.40.205.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 011B92FC46;
        Thu, 30 May 2019 12:35:32 +0000 (UTC)
Date:   Thu, 30 May 2019 14:35:30 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Frederic Crozat <fcrozat@suse.com>
Subject: Re: [PATCH] raw: Add raw.service
Message-ID: <20190530123530.q2ngscgnmgi3s327@ws>
References: <f4c8feb9-2bdc-8a40-7bc1-d24fcd94d0a7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4c8feb9-2bdc-8a40-7bc1-d24fcd94d0a7@suse.cz>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 30 May 2019 12:35:40 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 30, 2019 at 12:30:16AM +0200, Stanislav Brabec wrote:
> Add raw.service that allows to initialize raw devices on boot.

And why not udev?

For RHEL we install /usr/lib/udev/rules.d/60-raw.rules, the file
contains only example

        #
        # Enter raw device bindings here.
        #
        # An example would be:
        #   ACTION=="add", KERNEL=="sda", RUN+="/usr/bin/raw /dev/raw/raw1 %N"
        # to bind /dev/raw/raw1 to /dev/sda, or
        #   ACTION=="add", ENV{MAJOR}=="8", ENV{MINOR}=="1", RUN+="/usr/bin/raw /dev/raw/raw2 %M %m"
        # to bind /dev/raw/raw2 to the device with major 8, minor 1.

and users can add theirs devices to the file.

I have talked (on IRC) about it with systemd guys and suggestion is to
do devices initialization in udev when the device is discovered rather
than later in systemd.

I'm also not sure if introduce an extra config file in service is a
good idea.

Maybe all we need is to add any info about udev configuration to
raw(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
