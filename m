Return-Path: <SRS0=mE6B=CX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF3AC433E2
	for <util-linux@archiver.kernel.org>; Mon, 14 Sep 2020 10:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688D320759
	for <util-linux@archiver.kernel.org>; Mon, 14 Sep 2020 10:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnWHtn7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgINKHH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Sep 2020 06:07:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726239AbgINKHH (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Sep 2020 06:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600078026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twAQaGgJGrJ/UwvCgPJEoqhbdgGM1yicybr5ML1Y3n8=;
        b=OnWHtn7y76GvWBi8g5qzJQIVKEf4otYGxqSn+Cq+A/LImr64u95olgnFDTD7Z/Cogeat9q
        VQpUA8tXdznZNAXHX4P55Up54WqETOC+9xpr5pSHonPZdFHSF4tZ/yWuuWD+IjGNhx1P2U
        BISWpOzdgCSUrchBMaeavqWhGKsfwwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-HR4I4YfOMqybWgwF9dVTiA-1; Mon, 14 Sep 2020 06:07:02 -0400
X-MC-Unique: HR4I4YfOMqybWgwF9dVTiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBDE51853DA5;
        Mon, 14 Sep 2020 10:07:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E60F19C4F;
        Mon, 14 Sep 2020 10:06:59 +0000 (UTC)
Date:   Mon, 14 Sep 2020 12:06:56 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Gero Treuner <gero@70t.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: fallocate: fix for --dig-holes at end of files
Message-ID: <20200914100656.37km3eqdj2jjqyej@ws.net.home>
References: <X1qJiQa2MHpJ55IG@innocircle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X1qJiQa2MHpJ55IG@innocircle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Sep 10, 2020 at 10:16:09PM +0200, Gero Treuner wrote:
> I discovered that making a file sparse with "fallocate -d filename"
> fails on the last block of a file, because - usually being partial - the
> system call only zeroes that part instead of deallocating the block. See
> man fallocate(2) - section "Deallocating file space".
> 
> The expected call is punching the whole block beyond eof, which doesn't
> change the file length because of flag FALLOC_FL_KEEP_SIZE.

Good catch. Applied, thanks.

(Please, use Signed-off-by: line in your commit message next time.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

