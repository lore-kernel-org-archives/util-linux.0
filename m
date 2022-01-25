Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26076C433EF
	for <util-linux@archiver.kernel.org>; Tue, 25 Jan 2022 10:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379547AbiAYKzS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379549AbiAYKxK (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Jan 2022 05:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643107988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bUfJZe9TYRIuV2tn2o/ms6IbqcuqRRt05GHqoG68aKg=;
        b=UrgnbUW4aUx+2lrmR+OjvCWFpVpzw2A79Vq6iSgvmUSBzuIcvzs5LE6fZkot4w1alQGl+B
        309h5jaE/pdFPc1J4uQEqEHygcguLMKSul3+lUXcGhWoTLZX0QppgkCNMBWKoFaA4aA6+z
        03fjxOJpacYN+zeZlSZ23qBzNxc0ulo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-wM0Xeaf6PoClQaI2KdSUtA-1; Tue, 25 Jan 2022 05:53:05 -0500
X-MC-Unique: wM0Xeaf6PoClQaI2KdSUtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0B58100CC84;
        Tue, 25 Jan 2022 10:53:03 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A1457D706;
        Tue, 25 Jan 2022 10:53:02 +0000 (UTC)
Date:   Tue, 25 Jan 2022 11:53:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Ali Abdallah <ali.abdallah@suse.com>
Subject: Re: [PATCH] Whitelist libuuid clock file
Message-ID: <20220125105300.f3npvhr5emhvzevu@ws.net.home>
References: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 25, 2022 at 11:17:27AM +0100, Stanislav Brabec wrote:
> diff --git a/misc-utils/uuidd.service.in b/misc-utils/uuidd.service.in
> index 065b4a194..e64ca59b5 100644
> --- a/misc-utils/uuidd.service.in
> +++ b/misc-utils/uuidd.service.in
> @@ -8,6 +8,7 @@ ExecStart=@usrsbin_execdir@/uuidd --socket-activation
>  Restart=no
>  User=uuidd
>  Group=uuidd
> +ProtectSystem=strict
>  ProtectHome=yes
>  PrivateDevices=yes
>  PrivateNetwork=yes
> @@ -17,6 +18,7 @@ ProtectKernelModules=yes
>  ProtectControlGroups=yes
>  RestrictAddressFamilies=AF_UNIX
>  MemoryDenyWriteExecute=yes
> +ReadWritePaths=/var/lib/libuuid/

OK, seems better than my solution ;-) Thanks!

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

