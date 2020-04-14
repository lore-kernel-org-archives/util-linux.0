Return-Path: <SRS0=eIzx=56=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBFC2BBC7
	for <util-linux@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF0D20768
	for <util-linux@archiver.kernel.org>; Tue, 14 Apr 2020 11:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S17xYFfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439425AbgDNLik (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:38:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24771 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439405AbgDNLii (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Apr 2020 07:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586864317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rrcb/Q3vIredl9ajM+2kHpZ555c7lpKYtfS0KYSaDyE=;
        b=S17xYFfRNnEI2idcxZY4FKQheRp9tSlM91XdP5RNu1HZJFR7kdsRh4Zk8IVVL5X9ua9p1t
        QjCTV0XzAMASwD18WvtxvZGFsxn6bT/ANtRz6ktJ6RzzjsFhc2EghNqDaJgTaMEorpleSR
        n2yugb4LrXmyGDFvcd3fZfdFcav+VqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-r4tTAguqOVWz777AKkoOlA-1; Tue, 14 Apr 2020 07:38:32 -0400
X-MC-Unique: r4tTAguqOVWz777AKkoOlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E7621005509;
        Tue, 14 Apr 2020 11:38:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A912A18A85;
        Tue, 14 Apr 2020 11:38:30 +0000 (UTC)
Date:   Tue, 14 Apr 2020 13:38:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Lajoie <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: cal: column mode
Message-ID: <20200414113827.xp2etrdev2oom4qc@ws.net.home>
References: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 13, 2020 at 10:41:34PM +0200, Aur=E9lien Lajoie wrote:
> As I have announced few days ago, I have started to work on ncal like f=
or cal.
> I have push a first working version on my github:
> https://github.com/utix/util-linux/commits/cal_column

Is the option --column the best name? We use "column" pretty often to
address output in columns or number of columns, etc.=20

What about --vertical?
=20
> I will now add some tests, and improve my code.

Cool.

> Does anyone know which locale can have some width issue ?

 LC_ALL=3Dja_JP.utf8 cal

or another with multibyte letters.

> I have tried to keep the same structure of the code between the column
> mode and the row mode.
> It is impossible to keep line width lower than 80.

Do you mean source code line? ... 80 is not a strict rule, keep it
readable.

> I can try to split the big function `cal_output_months` this will make
> it more readable, but will introduce a lot of change for no feature.
> Any advice on this ?

Your cal_col_output_months() does not look like any huge monster.

I have added one comment to your commits/cal_column at github.

    Karel


--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

