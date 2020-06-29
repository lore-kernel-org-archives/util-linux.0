Return-Path: <SRS0=yzEn=AK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA19C433DF
	for <util-linux@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84652206E9
	for <util-linux@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIpT7CUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgF2TN3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:13:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731361AbgF2TN1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 29 Jun 2020 15:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8bujLqoounULKL/qbDrPxDDB/lbO/iTEYEDhUxha9E=;
        b=gIpT7CUszrElXJ3MEIPaNlabm/UXwHI6tNO4HoMuhg6Hjo0g4iTZGjUIUtT2PYncv6Z0HD
        P3A7R8Ix9obcqiRhN2ASZFXBJc2gWe3hjYwqHLLGhKES8ja7uPvOZaLPAmLTkwX2WBNiOx
        8V0HYBk7dw4XOhLtDX25L8CEFq/ZDxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-teLAg-qqNv2qsJ0KZiOOOQ-1; Mon, 29 Jun 2020 07:12:04 -0400
X-MC-Unique: teLAg-qqNv2qsJ0KZiOOOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A04C107ACCA;
        Mon, 29 Jun 2020 11:12:03 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.195.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64C8D5C1D4;
        Mon, 29 Jun 2020 11:12:02 +0000 (UTC)
Date:   Mon, 29 Jun 2020 13:11:59 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     util-linux@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH RFC] blkzone: add capacity field to zone report
Message-ID: <20200629111159.rrpml3hnpmldczap@ws.net.home>
References: <20200626121225.428611-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626121225.428611-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 26, 2020 at 09:12:25PM +0900, Shin'ichiro Kawasaki wrote:
>  configure.ac        |  4 ++++
>  sys-utils/blkzone.8 |  1 +
>  sys-utils/blkzone.c | 20 ++++++++++++++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)

 Applied to the "next" branch (for v2.36 is too late). Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

