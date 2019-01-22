Return-Path: <SRS0=jsub=P6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A9DC282C3
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 10:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C04720870
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 10:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfAVK5s (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:57:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAVK5s (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Jan 2019 05:57:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FCE18B104;
        Tue, 22 Jan 2019 10:57:48 +0000 (UTC)
Received: from ws.net.home (ovpn-117-196.ams2.redhat.com [10.36.117.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB0435C20D;
        Tue, 22 Jan 2019 10:57:47 +0000 (UTC)
Date:   Tue, 22 Jan 2019 11:57:45 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jeffrey Ferreira <jeffpferreira@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] losetup: set blocksize before partition scan
Message-ID: <20190122105745.sooe63gdchnp5uwd@ws.net.home>
References: <20190110215515.GA28589@jeffrey-Ubuntu-iMac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110215515.GA28589@jeffrey-Ubuntu-iMac>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 22 Jan 2019 10:57:48 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 10, 2019 at 01:55:19PM -0800, Jeffrey Ferreira wrote:
> When creating a loop device the user may use the --partscan option to
> request that the kernel scan for partitions. To correctly scan for
> partitions the kernel must first have the correct blocksize.

Really good catch. Thanks!

I have implemented it in a little different way to follow internal API
from lib/loopdev.c.

> Also, update an error message to add --partscan to the list of options
> only allowed during loop device setup.

Merged this part.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
