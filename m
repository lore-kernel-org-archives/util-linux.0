Return-Path: <SRS0=6A97=2C=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B392C43603
	for <util-linux@archiver.kernel.org>; Thu, 12 Dec 2019 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B4E20663
	for <util-linux@archiver.kernel.org>; Thu, 12 Dec 2019 11:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTRUzqrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfLLLXM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:23:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728725AbfLLLXM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 12 Dec 2019 06:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576149791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P8VeSwUMDEx8lrdmwi3TDgreg2dhme+e2MKc+N1vfZw=;
        b=OTRUzqrZDGmOUi12L8mMcEuoEv2OsQ16H5waBifEYAVpflu0HLn4bwgy7UL+2Uw5C15R5d
        3LRlx7o8sh4NffYimVcsp1AcujF63oiQNAbMvUFl1fu5cMbKDhuLeLSt6mjm4zy2KZC12G
        Vn083/K4/L1dk6eUmPRLxZtJrsG3VRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-DyohIXDxOO-LDkXfHaYkYg-1; Thu, 12 Dec 2019 06:23:09 -0500
X-MC-Unique: DyohIXDxOO-LDkXfHaYkYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD83F1005510;
        Thu, 12 Dec 2019 11:23:08 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2031910013A1;
        Thu, 12 Dec 2019 11:23:07 +0000 (UTC)
Date:   Thu, 12 Dec 2019 12:23:05 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: return proper value if compiled without ISSUEDIR
 support
Message-ID: <20191212112305.nlfd3gghp4jeq4nv@10.255.255.10>
References: <bc1cb34e4f685a1e3eddcfbde6d1f4a0fc30453d.1576071846.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc1cb34e4f685a1e3eddcfbde6d1f4a0fc30453d.1576071846.git.ps@pks.im>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Dec 11, 2019 at 02:44:22PM +0100, Patrick Steinhardt wrote:
>  term-utils/agetty.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

