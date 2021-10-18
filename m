Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD444C433FE
	for <util-linux@archiver.kernel.org>; Mon, 18 Oct 2021 11:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1461212
	for <util-linux@archiver.kernel.org>; Mon, 18 Oct 2021 11:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhJRLSE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Oct 2021 07:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhJRLSC (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Oct 2021 07:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634555751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yx/gxJx55CZXhbNak+xqjBFZm0M5s1xQUDEaacIOE8c=;
        b=gwZM7UU1xj/ltw11WLILYa+lBfZPiiGdsTG9jII0qluFt4na291Jcwy8vCh143TQimQUmu
        0mnTlNXN8liW6OUYbQdky49lHm7eGZ9jT/HF4+9lBnzm/9tK+Pm3YyB0WnTswJ8xlXUHN+
        tq8OXPjTU1yx+iNmHW+5SF/dDFz7GLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-QKzj31-SPNqK4UeUNbFmzQ-1; Mon, 18 Oct 2021 07:15:47 -0400
X-MC-Unique: QKzj31-SPNqK4UeUNbFmzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A362B806668;
        Mon, 18 Oct 2021 11:15:46 +0000 (UTC)
Received: from ws.net.home (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 060785F4F5;
        Mon, 18 Oct 2021 11:15:45 +0000 (UTC)
Date:   Mon, 18 Oct 2021 13:15:43 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blockdev: remove accidental non-breaking spaces
Message-ID: <20211018111543.m5rv6osgjepmerf2@ws.net.home>
References: <20211018074001.4098046-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018074001.4098046-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Oct 18, 2021 at 07:40:01AM +0000, Chris Hofstaedtler wrote:
>  disk-utils/blockdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

