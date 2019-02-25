Return-Path: <SRS0=Hpyb=RA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3E1C43381
	for <util-linux@archiver.kernel.org>; Mon, 25 Feb 2019 13:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E9D20842
	for <util-linux@archiver.kernel.org>; Mon, 25 Feb 2019 13:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfBYNLX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:11:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYNLW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 Feb 2019 08:11:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFE65307DAA3;
        Mon, 25 Feb 2019 13:11:22 +0000 (UTC)
Received: from ws.net.home (ovpn-204-99.brq.redhat.com [10.40.204.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08DAB5D71A;
        Mon, 25 Feb 2019 13:11:21 +0000 (UTC)
Date:   Mon, 25 Feb 2019 14:11:17 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?5Yaw5p+v?= <ziming_cool@126.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Bug report for libfdisk
Message-ID: <20190225131117.4wthqysvjhek7tqy@ws.net.home>
References: <2a76c584.126b.169188b95a6.Coremail.ziming_cool@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a76c584.126b.169188b95a6.Coremail.ziming_cool@126.com>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 25 Feb 2019 13:11:22 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Feb 23, 2019 at 12:09:54PM +0800, 冰柯 wrote:
> 	} else {
> 		/* primary partitions */
> 		if (fdisk_use_cylinders(cxt) || !cxt->total_sectors)
> 			limit = cxt->geom.heads * cxt->geom.sectors * cxt->geom.cylinders - 1;
> 		else
> 			limit = cxt->total_sectors - 1;      /* HERE */
> 
> 		if (limit > UINT_MAX)
> 			limit = UINT_MAX;
> 	}

Fixed. Now the code follows situation on the device rather than total
sectors and first LBA.

Thanks for your report!

    Karel
                                                                           Icy.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
