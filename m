Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F6C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBD620575
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3S11o7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEFN3j (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:29:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728081AbgEFN3j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588771778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEyY60MOIcBSDzMzbfL4VdjCr384hrSWqdoxFGe6Uew=;
        b=N3S11o7qle5KdXuP8FeRr8QgSFomEkbr5DArkRIRccnmxtbTPLSMtfxsIQtBCEjKWisP1n
        fVTz68QTboRcvMmuSIeoOq6Ctq5Y5k9anSbVSSMVTPp0Smx0gDykp6HEJxRfeD5VNZdpEa
        QneNjxqIzy+H3nQmtDpVgrJFTUf11+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-vr6jzbxLNUuDMp61aj6z9Q-1; Wed, 06 May 2020 09:29:36 -0400
X-MC-Unique: vr6jzbxLNUuDMp61aj6z9Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1AB08015CF;
        Wed,  6 May 2020 13:29:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 293BD605F7;
        Wed,  6 May 2020 13:29:34 +0000 (UTC)
Date:   Wed, 6 May 2020 15:29:32 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add dax capability detection in topology
 probing
Message-ID: <20200506132932.xpyk3z6jqho6gysk@ws.net.home>
References: <20200505143145.9852-2-ailiop@suse.com>
 <20200506130847.d2u66a2lsrp4pfah@ws.net.home>
 <20200506132141.GZ1329@technoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506132141.GZ1329@technoir>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 06, 2020 at 03:21:41PM +0200, Anthony Iliopoulos wrote:
> On Wed, May 06, 2020 at 03:08:47PM +0200, Karel Zak wrote:
> > On Tue, May 05, 2020 at 04:31:45PM +0200, Anthony Iliopoulos wrote:
> > > The dax (direct access) blockdev capability is exposed via sysfs, add it
> > > to the list of topology values to be obtained while probing.
> > > 
> > > Expose blkid_topology_get_dax() symbol that programs can link against
> > > for querying the capability.
> > 
> > Do we have any use-case for this change? 
> > 
> > We maintain blkid_topology_* mostly for mkfs-like programs portability 
> > (years ago we had only ioctls, etc..). You can see that libblkid export
> > only small subset topology stuff, so why we need DAX there? ;-)
> 
> The use-case is indeed mkfs. I am planning to submit a patch to xfsprogs

Yes, hch is the reason why we have topology API in libblkid :-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

