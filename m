Return-Path: <SRS0=MRkD=Z4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AEC43603
	for <util-linux@archiver.kernel.org>; Fri,  6 Dec 2019 11:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCED921823
	for <util-linux@archiver.kernel.org>; Fri,  6 Dec 2019 11:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlRTteYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLFLl6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:41:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbfLFLl6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 Dec 2019 06:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575632517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAapXgEXKQ0mT4IoRC5QkSetYfPDYYx6jSOS2pmKzNg=;
        b=KlRTteYazLv4tjyyqzQIXi7AaEycgr7WKnGWCP155+AsZ9TryHltjcJjxxyqdoqhG09UST
        jx+eCT/z6wOCuh5LKIaOZIoZJrkYhqHe5sKMfCHenmabVtyMMQG6rzt9hYMP5IMQMgiAyH
        ho1XSO/prlZ6TRFS+DhcO7umXEsl9QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-XVjrw6WgM4iEIg2oafWq6w-1; Fri, 06 Dec 2019 06:41:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC93107ACFA;
        Fri,  6 Dec 2019 11:41:54 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A4660BF4;
        Fri,  6 Dec 2019 11:41:53 +0000 (UTC)
Date:   Fri, 6 Dec 2019 12:41:51 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jouke Witteveen <j.witteveen@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] su: silence a useless warning
Message-ID: <20191206114151.7b366ln34usvdpgo@10.255.255.10>
References: <20191206100603.GA948@Mindship-03>
MIME-Version: 1.0
In-Reply-To: <20191206100603.GA948@Mindship-03>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XVjrw6WgM4iEIg2oafWq6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Dec 06, 2019 at 11:06:03AM +0100, Jouke Witteveen wrote:
>  login-utils/su-common.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

