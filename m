Return-Path: <SRS0=1h7d=4G=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5412FC34026
	for <util-linux@archiver.kernel.org>; Tue, 18 Feb 2020 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCC82176D
	for <util-linux@archiver.kernel.org>; Tue, 18 Feb 2020 12:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqrULGcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBRMq2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:46:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49065 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbgBRMq2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Feb 2020 07:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582029987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrK5lMt3JmT3jOl9StDbtMfPcHmBnSINxVG+9VLf+xU=;
        b=eqrULGclPxqxf/3tw3qY6t3II6++3Wqm30miglLzbD/IqIeDGKox0l+pBT9wYYnyMRQgiP
        W0k3PUVf1PwvBzf38/ooIVtiJISC3eI9cAVSYQVnps8bWsJth8lQIBFq3FeCEVVJ5oXkZg
        q21KpA9+Vw0NyK0bCG8/rSDvcNel218=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-SuXVlCBWNEOLbe1LXVw2jA-1; Tue, 18 Feb 2020 07:46:19 -0500
X-MC-Unique: SuXVlCBWNEOLbe1LXVw2jA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6842D100550E;
        Tue, 18 Feb 2020 12:46:18 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A061490761;
        Tue, 18 Feb 2020 12:46:17 +0000 (UTC)
Date:   Tue, 18 Feb 2020 13:46:14 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?Sm/Do28=?= Miguel <jmcf125@bitmessage.ch>
Cc:     util-linux@vger.kernel.org
Subject: Re: Suggestion for new multi-mount option
Message-ID: <20200218124614.mjcbfjqefa4d3b6l@ws.net.home>
References: <20180818202140.GE4715@jmcf125-Acer-GNU-Linux.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180818202140.GE4715@jmcf125-Acer-GNU-Linux.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Aug 18, 2018 at 09:21:40PM +0100, Jo=E3o Miguel wrote:
> I think it would be useful for it to be doable with =ABmount=BB as:
>=20
>    mount --relative-root /dev/something /mnt/somewhere
>=20
> Or at least:
>=20
>    mount /dev/something /mnt/somewhere
>    mount -a --fstab /mnt/somewhere/etc/fstab --relative /mnt/somewhere

Note that this is implemented in v2.35, where we have --target-prefix
and options like --all are able to follow this prefix. It's also
possible to use -o for --all to overwrite fstab mountoptions.

    Karel
>=20

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

