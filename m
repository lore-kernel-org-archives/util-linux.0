Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E3C43334
	for <util-linux@archiver.kernel.org>; Wed, 20 Jul 2022 15:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiGTPCZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiGTPCZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 20 Jul 2022 11:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A43C854049
        for <util-linux@vger.kernel.org>; Wed, 20 Jul 2022 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658329343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvXSy0/H0sq6zOuIwNhV/qusQms81qIfJzIXhu6xfgk=;
        b=NMB2NhSBuTg3Q2RhWnT8r7n8oQWuPmXTg8dPvLRJ+WLtolwBxdHW1E4joAKGudcKVkMGb+
        4EydVgs+9w8os9FvZrz7uqQo4w/WB64n0kSgrvQzjWAh0MwCLcrgLs5YpPgCAoXotyU744
        NX2ObiC625+7gBNkiXbWHOySsTkjk/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-dV_lTpMDP36B5KtyAxtvVg-1; Wed, 20 Jul 2022 11:02:16 -0400
X-MC-Unique: dV_lTpMDP36B5KtyAxtvVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B478804184;
        Wed, 20 Jul 2022 15:02:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B1618EA8;
        Wed, 20 Jul 2022 15:02:15 +0000 (UTC)
Date:   Wed, 20 Jul 2022 17:02:13 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: <linux/fs.h> conflicts with <sys/mount.h>
Message-ID: <20220720150213.4ac7iclhkwqhbdog@ws.net.home>
References: <mvm35eyh7jm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvm35eyh7jm.fsf@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jul 18, 2022 at 03:30:53PM +0200, Andreas Schwab wrote:
> With the upcoming glibc 2.36, <linux/fs.h> conflicts with <sys/mount.h>:

It seems we do not need linux/fs.h (if usual sys/mount.h is available).

Fixed in master branch.
https://github.com/util-linux/util-linux/commit/89c7c6ea6ef12722eac31c18b8fa6fbcf429525b

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

