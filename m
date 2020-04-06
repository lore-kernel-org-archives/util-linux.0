Return-Path: <SRS0=wOLd=5W=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738AC2BA19
	for <util-linux@archiver.kernel.org>; Mon,  6 Apr 2020 13:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947820CC7
	for <util-linux@archiver.kernel.org>; Mon,  6 Apr 2020 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9avwTyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgDFNf2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:35:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728452AbgDFNf2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Apr 2020 09:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586180127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K/QbAYUMqfGt4FRFXYQf7iG444X8wMyv2bYNsvGbSUQ=;
        b=b9avwTyRlWRe7ppZEE7tcYW03og9I7yfDBoAXi613CnuQgYnO4+xN4/DfDS/pHrdWerxj7
        XuZKc0dvDfrhUAgGaA6KpO/wAfi6YvARAL2RppHSx679t9wiNY72UoGocMxd0jJoTHP6OY
        TFzwMLwSsbM+zh2dg6t/Irw0GF/9oRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-mUQxYaSTPx2aoSXyN8rcaA-1; Mon, 06 Apr 2020 09:35:23 -0400
X-MC-Unique: mUQxYaSTPx2aoSXyN8rcaA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB771005509;
        Mon,  6 Apr 2020 13:35:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 517EE100034E;
        Mon,  6 Apr 2020 13:35:21 +0000 (UTC)
Date:   Mon, 6 Apr 2020 15:35:18 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>
Subject: Re: [PATCH] libblkid: Add support for zonefs
Message-ID: <20200406133518.hj2dojotqpmpattb@ws.net.home>
References: <20200320045543.2053382-1-damien.lemoal@wdc.com>
 <20200323103305.uhlc3d7i4famwq5p@ws.net.home>
 <CO2PR04MB2343E47B5AFE242DA2307BB0E7C90@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB2343E47B5AFE242DA2307BB0E7C90@CO2PR04MB2343.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 01, 2020 at 04:44:29AM +0000, Damien Le Moal wrote:
> On 2020/03/23 19:33, Karel Zak wrote:
> > On Fri, Mar 20, 2020 at 01:55:43PM +0900, Damien Le Moal wrote:
> >>  libblkid/src/Makemodule.am             |  1 +
> >>  libblkid/src/superblocks/superblocks.c |  3 +-
> >>  libblkid/src/superblocks/superblocks.h |  1 +
> >>  libblkid/src/superblocks/zonefs.c      | 87 ++++++++++++++++++++++++++
> >>  4 files changed, 91 insertions(+), 1 deletion(-)
> >>  create mode 100644 libblkid/src/superblocks/zonefs.c
> > 
> > Applied (with a small change), thanks.
> > 
> >> +struct zonefs_super {
> >> +
> >> +	/* Magic number */
> >> +	__le32		s_magic;
> > 
> > We use standard integer types rather than this kernel-ism ;-) Fixed.
> > 
> > It would be nice to have a test image for zonefs, something small what
> > we can add to tests/ts/blkid/images-fs/ ;-)
> 
> Hi Karel,
> 
> Please find attached the zonefs.img.xz file for a small (4 MB uncompressed)
> image of a zonefs file system. I tested it with the blkid run in
> tests/ts/blkid/low-probe and it works. I am not sure if other tests are run
> against FS images as I have not dig into the test suite (I should !).

No problem ;-)

> If this is OK, please feel free to add the image to tests/ts/blkid/images-fs/.

Done, thanks for the image!
https://github.com/karelzak/util-linux/commit/ea4dcdc788f2736c0f36cc59e79fb421e5bef915

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

