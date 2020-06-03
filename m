Return-Path: <SRS0=KLef=7Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621CC433E0
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 15:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F766206E6
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 15:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ2YvB3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgFCPQb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:16:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726148AbgFCPQa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 3 Jun 2020 11:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591197390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGnSeQ+tzTuUnihZwsgVPls3RB0oQfP16vBFEct1vlE=;
        b=hZ2YvB3IAD/YGSx5AmzFBT5boTkwfHnGaaIQRDLAt5MmUGrSTQYhYAdt5T708eaOlUPSDD
        DFB1xqMBN5wLx0k2MgTjWua7L2Z3gMEgS5AsI//2s3ysc1Ch12W9JVFRi6RzoZuoqQVK38
        AETd6EnmMEYPP0TLOJsR7Iy/MOlHWLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278--PWHj0JVPsqkj6Vs77HYrw-1; Wed, 03 Jun 2020 11:16:27 -0400
X-MC-Unique: -PWHj0JVPsqkj6Vs77HYrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 635A9107ACCA;
        Wed,  3 Jun 2020 15:16:26 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 716E910013D7;
        Wed,  3 Jun 2020 15:16:25 +0000 (UTC)
Date:   Wed, 3 Jun 2020 17:16:22 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
Subject: Re: [PATCH] blockdev: Don't fail on missing start sector
Message-ID: <20200603151622.bypdu5k5r22cuq6z@ws.net.home>
References: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 01, 2020 at 01:35:44AM +0200, Stanislav Brabec wrote:
> It causes "blockdev --report" error:
> blockdev: /dev/dm-9: failed to read partition start from sysfs: No such
> file or directory

Stanislav, can you re-send the patch by git-send-email or create PR on
git-hub? Please. It seems the patch is broken by your/my email client (or
so) :-(

Thanks!

 Applying: blockdev: Don't fail on missing start sector
 error: corrupt patch at line 10

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

