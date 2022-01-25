Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D90C433EF
	for <util-linux@archiver.kernel.org>; Tue, 25 Jan 2022 16:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378109AbiAYQdM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575009AbiAYQbb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Jan 2022 11:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643128290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tcJPqenuNI242ADHc8W65t516GuWoEQqfQprK+GADHk=;
        b=EIDLSxe0yFZx7oWd/mF1JdtWkE7ATguUyGQ5US0Diz8l6aOY1gsRxHHRL5rvkh267u7QWV
        hK95YfzSVSbHNK5tHu/YL0UHNAIxtJFXd2JMq+cp2HU4DSxwhd+tq4MLwrsiGDNS4bZAhm
        9G1/p/KABvh+NXOg34fhUDb7U5DhmX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-j5ILENkVNyWWHJXcC87XBQ-1; Tue, 25 Jan 2022 11:31:28 -0500
X-MC-Unique: j5ILENkVNyWWHJXcC87XBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00F2083DD21;
        Tue, 25 Jan 2022 16:31:28 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42D5A7DE57;
        Tue, 25 Jan 2022 16:31:27 +0000 (UTC)
Date:   Tue, 25 Jan 2022 17:31:24 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] loopdev: Properly translate errors from
 ul_path_read_*()
Message-ID: <20220125163124.be2p7iubnedhc7ua@ws.net.home>
References: <20220120121639.13047-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120121639.13047-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 20, 2022 at 01:16:38PM +0100, Jan Kara wrote:
>  lib/loopdev.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

 Applied (both patches), thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

