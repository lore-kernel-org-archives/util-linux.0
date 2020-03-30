Return-Path: <SRS0=/M4+=5P=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D8C43331
	for <util-linux@archiver.kernel.org>; Mon, 30 Mar 2020 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ED82072E
	for <util-linux@archiver.kernel.org>; Mon, 30 Mar 2020 19:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdaTM8Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgC3TSO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Mar 2020 15:18:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38247 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbgC3TSO (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 30 Mar 2020 15:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585595893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KE9/sZJbWUrNW/Ul4rppwPfkzSHtPUrEZArXJou3UCQ=;
        b=NdaTM8HwRG8KTIfMjpp154wt/sKkx8ZT2OdQR7+7jQJsJhNJ9Jx/y+I7uBLAR3KkYy/cY5
        PdAYo6VwrVQo2KwZexrVhTKhK70w60qYUWUFMi7RofuXRlOE8i9/vraWzYKaPT2eBlxKLg
        lSKZMks+Crbf09xhPIiIkR43B/G+RME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-N-OT_LrWM_qO9r_d1mj26w-1; Mon, 30 Mar 2020 15:18:07 -0400
X-MC-Unique: N-OT_LrWM_qO9r_d1mj26w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13056800D50;
        Mon, 30 Mar 2020 19:18:06 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A8B45C1BB;
        Mon, 30 Mar 2020 19:18:04 +0000 (UTC)
Date:   Mon, 30 Mar 2020 21:18:02 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Lajoie <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] cal: use a const char*
Message-ID: <20200330191802.z75crl5p7ih2qoab@ws.net.home>
References: <20200328223341.11463-1-orel@melix.net>
 <CAA0A08WSHwGSNqD00YJgmfCVM=-iLHJgV-T1JThRasxcgKjkfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAA0A08WSHwGSNqD00YJgmfCVM=-iLHJgV-T1JThRasxcgKjkfA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Mar 28, 2020 at 11:40:20PM +0100, Aur=E9lien Lajoie wrote:
> I am starting to share some cleaning before submitting the feature.
>=20
> What do you prefer for the feature itself ?
> A Pull-request on github or patch using the mailing list?

It's up to you ;-)

> I have no idea about how many commits I will create.
> I can squash them once it is ready and submit on the mailing list.

OK.
    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

