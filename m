Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79591C433DF
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5473720890
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6aIxgpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbgEYMBg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:01:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390282AbgEYMBf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 08:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590408094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j8GAvLfI7rN10KVTNmuGnUMdYBEFL0oURa18Baj5Js8=;
        b=b6aIxgpDbVTiQWIl73W7SFYSZf7cmSq9VhI765Kvhq6uhrjpbMhKLVAHTnOojVRq0Mnd54
        RpqFbnytoCPNclSyeGgv/waztQRI0Quc8V5A8j0yhtwSWffiYjXMvBP8P3RaxZMdJ+xFM3
        GMbAazlGXS8IvpTrcpR/fDGiooF1v90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-raXdTgyHOwuFNFQB50MlfA-1; Mon, 25 May 2020 08:01:30 -0400
X-MC-Unique: raXdTgyHOwuFNFQB50MlfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8227460;
        Mon, 25 May 2020 12:01:29 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05C065D9C5;
        Mon, 25 May 2020 12:01:28 +0000 (UTC)
Date:   Mon, 25 May 2020 14:01:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Thorsten Kukuk <kukuk@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: Add support for libeconf
Message-ID: <20200525120126.dyr2led4gicrb27q@ws.net.home>
References: <20200522160338.GA7156@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522160338.GA7156@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 22, 2020 at 06:03:38PM +0200, Thorsten Kukuk wrote:
> /etc/login.defs and /etc/default are read with this patch through
> libeconf. As there are at minimum 3 projects using /etc/login.defs
> and two (shadow and Linux-PAM) the two biggest consumers accepted
> this change already quite some time ago, it would be nice if 
> util-linux would also accept and merge the patch to not behave
> different than the rest. 

Merged.

If another tools (and we share login.defs with them) already use it
then it's good argument to support this feature in utitl-linux too.

I did small changes to the patch to integrate it with our build system
in better way.

What about support $vendordir as variable for pkg-config? Something
like: 

    pkg-config --variable=vendordir libeconf

after that we can use it in ./configure to avoid "--with-vendordir
<dir>". We already use the same for bash-completion or systemd 
specific dirs.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

