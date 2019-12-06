Return-Path: <SRS0=MRkD=Z4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F2C43603
	for <util-linux@archiver.kernel.org>; Fri,  6 Dec 2019 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F8721835
	for <util-linux@archiver.kernel.org>; Fri,  6 Dec 2019 11:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXLegDA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLFLww (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:52:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49085 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbfLFLww (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 Dec 2019 06:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575633171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNTpqlCBM/QiI+8hGiGegT+eh1OEPJE+LzeaNKwAQvs=;
        b=IXLegDA4my12kXZhIjugRHOhb8QsYgc9tg1G7BvsQc0KWdNgng+UOQrAfw7fMs19BFPMcP
        WWiI/Vjjb6tpe3q0nBLHxFleefS4aTqFjkwYMoOlZJohcOv/D+5fxv9rWn3mNRmfkocdi6
        suJQ85eB9PbkGmuooY0XBW51g4+goic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-FeI4rhNJM36rF5kpccdXtw-1; Fri, 06 Dec 2019 06:52:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 611342F60;
        Fri,  6 Dec 2019 11:52:47 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EDBB5D6A3;
        Fri,  6 Dec 2019 11:52:46 +0000 (UTC)
Date:   Fri, 6 Dec 2019 12:52:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     pierre@irsamc.ups-tlse.fr
Cc:     util-linux@vger.kernel.org
Subject: Re: Subject: [PATCH] Fix adjtime documentation
Message-ID: <20191206115243.u5wfoprmefxqcpvw@10.255.255.10>
References: <8c9af50033cf8d287a8df373d4cade93@irsamc.ups-tlse.fr>
MIME-Version: 1.0
In-Reply-To: <8c9af50033cf8d287a8df373d4cade93@irsamc.ups-tlse.fr>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FeI4rhNJM36rF5kpccdXtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Dec 04, 2019 at 03:37:06PM +0100, pierre@irsamc.ups-tlse.fr wrote:
>  sys-utils/adjtime_config.5 | 2 +-
>  sys-utils/hwclock.8.in     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

