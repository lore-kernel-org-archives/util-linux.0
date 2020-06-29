Return-Path: <SRS0=yzEn=AK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB4BC433E0
	for <util-linux@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACD3206E9
	for <util-linux@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHNL18+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgF2TIq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730877AbgF2TIV (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 29 Jun 2020 15:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVKstE8h8NO9lqm7uT12SmsO8/U+31erhv1DCIObxcY=;
        b=EHNL18+BqwqwGhs9QJBEnVh1hcdPVCqWsLRarZS1ZQlAebWx/0rYG9pLTYiq9LX3iedGgg
        G/yiaO6OelGrqnl7siweOeS8h0otnJE9bkMB4NyNCXe9YgW1SRilbQpAhOe8VaKuYogsPS
        zHAXjlIB60ZL9nNRdT9poGG4c7gGyMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-A5L7otroMVOD2uMU2HmMCQ-1; Mon, 29 Jun 2020 06:02:48 -0400
X-MC-Unique: A5L7otroMVOD2uMU2HmMCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EECEADB38;
        Mon, 29 Jun 2020 10:02:46 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.195.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D710126512;
        Mon, 29 Jun 2020 10:02:45 +0000 (UTC)
Date:   Mon, 29 Jun 2020 12:02:42 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Damien Goutte-Gattat <dgouttegattat@incenp.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] chfn: Make readline prompt for each field on a separate
 line
Message-ID: <20200629100242.luuaj3quee2d5kds@ws.net.home>
References: <20200627185813.17837-1-dgouttegattat@incenp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627185813.17837-1-dgouttegattat@incenp.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jun 27, 2020 at 07:58:13PM +0100, Damien Goutte-Gattat wrote:
>   $ chfn
>   Changing finger information for user.
>   Password:
>   Name []: Office []: Office Phone []: Home Phone []:

Good catch. Applied, thanks!

> --- a/login-utils/chfn.c
> +++ b/login-utils/chfn.c
> @@ -235,12 +235,13 @@ static char *ask_new_field(struct chfn_control *ctl, const char *question,
>  	if (!def_val)
>  		def_val = "";
>  	while (true) {
> -		printf("%s [%s]: ", question, def_val);
> +		printf("%s [%s]:", question, def_val);
>  		__fpurge(stdin);
>  #ifdef HAVE_LIBREADLINE
>  		rl_bind_key('\t', rl_insert);
> -		if ((buf = readline(NULL)) == NULL)
> +		if ((buf = readline(" ")) == NULL)
>  #else
> +		putchar('\n');

I have replaced '\n with ' ', otherwise for non-readline version it
it prints extra line.

I have also applied your change also to chsh.
https://github.com/karelzak/util-linux/commit/49848aa53ae3a599277e8ceb50feda565f140b45


    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

