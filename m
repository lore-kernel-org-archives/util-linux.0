Return-Path: <SRS0=4DiG=AM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC5C433E0
	for <util-linux@archiver.kernel.org>; Wed,  1 Jul 2020 11:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EC12067D
	for <util-linux@archiver.kernel.org>; Wed,  1 Jul 2020 11:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iART+Hqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgGAL7M (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:59:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42157 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730133AbgGAL7L (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Jul 2020 07:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593604751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jPLT0zs6QOmEgucO/jgseGQ3RglqDAxI9zK/y10tYkY=;
        b=iART+HqjkO/g9O70t/AMhDjeKBxF0ZRtgvcspdw4y0UTFj2RDtW8yAN+lxz7TeKYILIo+8
        sJjxCsVzepqzP/VETOOotM4chQYux7oVoRNd5goeq3VD8886QXo7pVu9fbLhUtTlOYI0yf
        CFloJpAs9DN/bJL8RF6garepFzQPYKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-jwqyC-tkMA6G53TvEz4EQA-1; Wed, 01 Jul 2020 07:58:57 -0400
X-MC-Unique: jwqyC-tkMA6G53TvEz4EQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AA0C879511;
        Wed,  1 Jul 2020 11:58:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 409EB5F730;
        Wed,  1 Jul 2020 11:58:55 +0000 (UTC)
Date:   Wed, 1 Jul 2020 13:58:52 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH RFC] blkzone: add capacity field to zone report
Message-ID: <20200701115852.sfetl45viqqvtyii@ws.net.home>
References: <20200626121225.428611-1-shinichiro.kawasaki@wdc.com>
 <20200629111159.rrpml3hnpmldczap@ws.net.home>
 <20200701113244.ye7vl3hzph6xc6ey@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701113244.ye7vl3hzph6xc6ey@shindev.dhcp.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jul 01, 2020 at 11:32:45AM +0000, Shinichiro Kawasaki wrote:
> On Jun 29, 2020 / 13:11, Karel Zak wrote:
> > On Fri, Jun 26, 2020 at 09:12:25PM +0900, Shin'ichiro Kawasaki wrote:
> > >  configure.ac        |  4 ++++
> > >  sys-utils/blkzone.8 |  1 +
> > >  sys-utils/blkzone.c | 20 ++++++++++++++++++--
> > >  3 files changed, 23 insertions(+), 2 deletions(-)
> > 
> >  Applied to the "next" branch (for v2.36 is too late). Thanks!
> 
> Hi Karel, thank you for picking it up.
> 
> The kernel side patch was applied to nvme-5.9. With this status, the commit
> message of the blkzone RFC patch is rather weird. I will revise the commit
> message and resend. Could you replace the patch in the next branch?

Sure, no problem to replace it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

