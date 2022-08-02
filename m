Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010DC00140
	for <util-linux@archiver.kernel.org>; Tue,  2 Aug 2022 10:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbiHBKOb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Aug 2022 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiHBKOb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Aug 2022 06:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E3CD4C623
        for <util-linux@vger.kernel.org>; Tue,  2 Aug 2022 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659435269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=467QACarcHZeNIUOysWcyfLlnJAZxt78jfOq61aVTVc=;
        b=ZzWLxciYGUkhhtxzRuHQ+/Tr6dfkoJXUzbX5zPCPj3RWzcHBFpLk5cbCLBc6xN1ovzbA0Y
        fcq3xahX+UXCfLgwJQgv4C2/vL0PhMot2v97ueLysdPXIBQjuO0qbdwcLNdPE53Qr7uKhX
        CA+LlHzs6AE4xx0KlvUWgHUM/v8xjjw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-L7BhCGMOPv28_mXb0FM0zA-1; Tue, 02 Aug 2022 06:14:26 -0400
X-MC-Unique: L7BhCGMOPv28_mXb0FM0zA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F37DC806003;
        Tue,  2 Aug 2022 10:14:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78488492C3B;
        Tue,  2 Aug 2022 10:14:25 +0000 (UTC)
Date:   Tue, 2 Aug 2022 12:14:23 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: uuidd user / DynamicUser?
Message-ID: <20220802101423.t7uwcfa5cbfs3og7@ws.net.home>
References: <20220730145024.gndtik3c24ivlukt@zeha.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730145024.gndtik3c24ivlukt@zeha.at>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jul 30, 2022 at 04:50:24PM +0200, Chris Hofstaedtler wrote:
> Hi,
> 
> Debian sets up a uuidd user, for uuidd to run as. We also set the
> home directory for this user to /run/uuidd, which is on a tmpfs, so
> not ideal.
>
> I was wondering what other distributions do for the home directory?

RHEL/Fedora spec file:

getent group uuidd >/dev/null || groupadd -r uuidd
getent passwd uuidd >/dev/null || \
useradd -r -g uuidd -d /var/lib/libuuid -s /sbin/nologin \
    -c "UUID generator helper daemon" uuidd

So it uses /var/lib/libuuid as a home directory.

> Also, is anyone using DynamicUser for uuidd.service?

For Fedora and the next RHEL we plan to use 
https://www.freedesktop.org/software/systemd/man/systemd-sysusers.html

It means explicitly define uuidd user in sysusers.d. 

I'm not sure if our users will be happy with DynamicUser as uuidd is
critical for then and stability with minimal variability is expected
in setup and runtime.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

