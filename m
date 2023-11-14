Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A09DC4332F
	for <util-linux@archiver.kernel.org>; Tue, 14 Nov 2023 09:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjKNJTw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Nov 2023 04:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjKNJTw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Nov 2023 04:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5A132
        for <util-linux@vger.kernel.org>; Tue, 14 Nov 2023 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699953588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OSyA+P9AzWDEXpzsUQXnaIco6Axm3suERn5in9raHH8=;
        b=P2SZee7ZmtvQq9si+++GvWvjAmVgGJWB+MkLLT7txXSLm0th7tSlhD0NSQaGU0ACUt3lYp
        Vv+zshJXNXgIuT8pvZVOAIJ0LY50fSuhUg5P/lrOSbqRIzsO8YJpokCdOw2MD+FfVqBS6o
        tXF31nef1M0FRG4wibcbwEyBfnQ3PwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-9WL3ekQkMHu617vhNYyX6Q-1; Tue, 14 Nov 2023 04:19:46 -0500
X-MC-Unique: 9WL3ekQkMHu617vhNYyX6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC246101A52D;
        Tue, 14 Nov 2023 09:19:45 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D4A61C060AE;
        Tue, 14 Nov 2023 09:19:44 +0000 (UTC)
Date:   Tue, 14 Nov 2023 10:19:42 +0100
From:   Karel Zak <kzak@redhat.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Masatake YAMATO <yamato@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: (lsfd::column-xmode) ignore "rwx" mappings
Message-ID: <20231114091942.jsstrsbvy6c5cpcs@ws.net.home>
References: <20231114022122.1292703-1-yamato@redhat.com>
 <172dc068e558d6c2e862f30197bb26af394b1b7b.camel@physik.fu-berlin.de>
 <20231114081630.3jb67afcv7muwg2x@ws.net.home>
 <f999f333bbbcd172d693f9f720192871799f53d9.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f999f333bbbcd172d693f9f720192871799f53d9.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 14, 2023 at 09:39:57AM +0100, John Paul Adrian Glaubitz wrote:
> Karel, what about Thomas' fix on Github?
> 
> > https://github.com/util-linux/util-linux/pull/2581
> 
> Can it be merged from there or shall the patch be posted here?

Merged.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

