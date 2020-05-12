Return-Path: <SRS0=qlqL=62=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9EC54E4B
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 08:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7313220714
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 08:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVoqnh0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgELIyJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 May 2020 04:54:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41152 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgELIyI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 May 2020 04:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589273647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DeKKZhesIOZE4JGl1CsS0Av7Bod6YNsn3CSHM/g6/ts=;
        b=bVoqnh0Rcumh8X50qmUZMB4aAjanLVFj5BQ5cWUlsaY9YVuXJ6tK+J5ZbzYAHj77WAVSO/
        WeRUxqtLhj0jJv79WPbBBkUC5Uds/SA72WzHlXxK+J1CYCDwRpKPyrc+YSA9xReJ6IttST
        mhx1QqlZNNLCnYnzUnAJ/7Z4r3ty8Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-WyuTGEcWMmCJ12dUt0bHKw-1; Tue, 12 May 2020 04:54:03 -0400
X-MC-Unique: WyuTGEcWMmCJ12dUt0bHKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD99835B44;
        Tue, 12 May 2020 08:54:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F252E16B;
        Tue, 12 May 2020 08:54:01 +0000 (UTC)
Date:   Tue, 12 May 2020 10:53:58 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Sami Kerola <kerolasa@iki.fi>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] more(1) use libmagic and make page up/down and arrow
 keys work
Message-ID: <20200512085358.yjfl7ryg4bq3tpx4@ws.net.home>
References: <20200506191923.5272-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506191923.5272-1-kerolasa@iki.fi>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 06, 2020 at 08:19:21PM +0100, Sami Kerola wrote:
> Here are two changes to more(1) that where requested in earlier github
> pull[1] request to get review in maillist, so here we go.

Applied, thanks.

> First one of the changes will link more(1) with libmagic so that various
> binary formats can be detected with effect the pager will not mess up
> termial.

It seems we do not have devel package for libmagic in Fedora.

> Second change is perhaps a little bit more exciting.  It will add page-up,
> page-down, arrow-up, and arrow-down movements to more(1).  This pager has
> known now to scroll back and forth since long time ago, but most of the
> people do not seem to know key bindings so lets help users by assigning the
> most obvious buttons the way one might expect them to work. 

This is nice feature, maybe also add arrow keys to move one line
up/down.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

