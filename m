Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A791C433EF
	for <util-linux@archiver.kernel.org>; Mon,  4 Oct 2021 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69506139F
	for <util-linux@archiver.kernel.org>; Mon,  4 Oct 2021 10:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhJDKUy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229478AbhJDKUx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 4 Oct 2021 06:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633342744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=feC/5bkXrZlmSuw7OSaDz6A+nHEDE9OjcKWzDXkxIGE=;
        b=W0YruMB+eFeVNESwyqfY+rAkGxoqcNZm/YMzxQT1NkYPHNGQgZ8vE3IjEcWmZ2rS24ykAs
        PndGgAB69g8b0pru08BedoalUv7EXsfnBQX5ZPhL9GR4yWPXe7z2QI7u40fUW3kseKTevE
        jW+a4pdDoTDEBynthxmY8+QJHQLBeEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-9jwEh8wVN9OwqlK7qTJUqQ-1; Mon, 04 Oct 2021 06:19:03 -0400
X-MC-Unique: 9jwEh8wVN9OwqlK7qTJUqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2497510199A0;
        Mon,  4 Oct 2021 10:19:02 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B59B60BF4;
        Mon,  4 Oct 2021 10:19:01 +0000 (UTC)
Date:   Mon, 4 Oct 2021 12:18:58 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     util-linux@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mount.8.adoc: note that mandatory locking is fully
 deprecated in Linux 5.15
Message-ID: <20211004101858.klmvpyk4pdtlohfp@ws.net.home>
References: <20211001122553.18345-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001122553.18345-1-jlayton@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Oct 01, 2021 at 08:25:53AM -0400, Jeff Layton wrote:
>  sys-utils/mount.8.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

