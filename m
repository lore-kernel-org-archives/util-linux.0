Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B7C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6462E20575
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JB2LXhnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEFNgF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:36:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26216 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728433AbgEFNgE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588772163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Om/hj6Lt7zDQkgaRNGGWKot9JTylgTMjfA7xjuOARkQ=;
        b=JB2LXhnKb7DPwc0McD0lIqUgk0EuipXRXFclHkjNcj9OF3+XjtvzK1YwvnFu69ouM53L2J
        onjWoyRlFjArbOfwpb5BIFXahG1pe3WpJEN+lbGwdcdSeRVZKIbU4wmc6b6afyTUaBFww3
        HyXfhBNXcc8hv3cMZoahoy0ercPXfCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-CrNH8tImNmG4LYkFsz-XEw-1; Wed, 06 May 2020 09:36:00 -0400
X-MC-Unique: CrNH8tImNmG4LYkFsz-XEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 901AC107ACF6;
        Wed,  6 May 2020 13:35:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4F1562952;
        Wed,  6 May 2020 13:35:58 +0000 (UTC)
Date:   Wed, 6 May 2020 15:35:55 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Lajoie <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: cal: column mode
Message-ID: <20200506133555.wbrul6yy24ycpfk3@ws.net.home>
References: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
 <20200414113827.xp2etrdev2oom4qc@ws.net.home>
 <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 14, 2020 at 10:18:11PM +0200, Aur=E9lien Lajoie wrote:
> On Tue, Apr 14, 2020 at 1:38 PM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 10:41:34PM +0200, Aur=E9lien Lajoie wrote:
> > > As I have announced few days ago, I have started to work on ncal li=
ke for cal.
> > > I have push a first working version on my github:
> > > https://github.com/utix/util-linux/commits/cal_column

Aur=E9lien, what is the current status of this your patch? I'd like to
make v2.36 release at the of the May :-)

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

