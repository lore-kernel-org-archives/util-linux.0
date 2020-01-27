Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E025BC2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B8922522
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCcuaJXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgA0QNm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:13:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729470AbgA0QNm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 11:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580141621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xKVcYG/oEb2dY1sWXt8D76DFeTXzPC8IWhZ8MrLi9x4=;
        b=PCcuaJXFGfe0VzfavFOY7if3KpLc+uDINnlM75UCRZrK4q3RFlhqj0tiQza1T8XrFTPJZZ
        Gko4l/fOf2b+rY1zDjc1zgTqDziM3Fb6dd2dIE5eQ4l7zTJq6fQn7umdi9IzzhIFudH3kv
        c9bmaSkgu8ZhOtthnXoxYWEWceq8rYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-ixCugTfKOZmspXZnzow07g-1; Mon, 27 Jan 2020 11:13:22 -0500
X-MC-Unique: ixCugTfKOZmspXZnzow07g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3197280257F;
        Mon, 27 Jan 2020 16:13:21 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EEDD8E9E6;
        Mon, 27 Jan 2020 16:13:20 +0000 (UTC)
Date:   Mon, 27 Jan 2020 17:13:17 +0100
From:   Karel Zak <kzak@redhat.com>
To:     J William Piggott <elseifthen@gmx.com>
Cc:     Carlos Santos <unixmania@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200127161317.wwyupvqbighx3rqx@ws.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200125105126.xaopgydc7dlrpztt@x2.net.home>
 <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YAK.7.76.2001261131130.3053@zhn.tzk.pbz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jan 26, 2020 at 11:59:59AM -0500, J William Piggott wrote:
> You do realize that I had to heavily modify that file to remove its
> gnulib dependencies (because you said no to gnulib). If I recall

I know, this is why we keep it in the tree (and thanks for all the
work!).

> correctly I had newer and older versions to chose from and picked that
> one due to it having the most bugs fixed while still being practical to
> strip its gnulib dependence.
> 
> The reasons for making the change were:
>  * remove hwclock's dependence on date(1)
>  * remove an insecure call to date(1)
>  * I thought there would be to many complaints if the accepted input
>    date formats were changed
> 
> As to the last bullet point; personally I think having the --date option
> accept every date syntax know to history is nonsense. 

Yes, I agree it's probably overkill.

> Or you could just use the existing utillinux date parser.

This is what I have implemented for --disable-hwclock-gplv3 to have
anything ASAP for the next 2.35.1 update... Maybe we can make it the
default for the next release v2.36 and later remove the gnulib code at
all.

> The question is, do you want to deal with any pushback for
> changing the long established accepted --date formats?

IMHO the existing utillinux date parser is good enough, but I have no
clue how people use --date.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

