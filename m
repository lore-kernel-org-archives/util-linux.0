Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22F8C433F5
	for <util-linux@archiver.kernel.org>; Mon,  2 May 2022 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385390AbiEBNq4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 2 May 2022 09:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385284AbiEBNqt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 2 May 2022 09:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E15E21208F
        for <util-linux@vger.kernel.org>; Mon,  2 May 2022 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651498999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKvJA110XXiMyDPRYYrbzlGeAnNeaURMbEik5cHpG9o=;
        b=an9UVU/oScOQqRmGMjhUtBUOuVURobkmKoflczvq5tFlpjC07zH6O9BHUQ4m3UWBrn6DKI
        UoZPBOhbzpJLsdVxW2Hecys5aJdzIvuFff1H1KT3mY2OkO6RKYNM6fTj2Ft2+GYuYfF+pz
        VZmsFys7xPLhzWVEkgjoivzlxa0oyIc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620--nhpiBfpMwmH77ZWlHNDBA-1; Mon, 02 May 2022 09:43:18 -0400
X-MC-Unique: -nhpiBfpMwmH77ZWlHNDBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E8263806701;
        Mon,  2 May 2022 13:43:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6EBC14DFB81;
        Mon,  2 May 2022 13:43:17 +0000 (UTC)
Date:   Mon, 2 May 2022 15:43:15 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Jeff Chua <jeff.chua.linux@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux agetty login prompt bug?
Message-ID: <20220502134315.w5g72jq2jlmqi6gr@ws.net.home>
References: <CAAJw_Zu6DoimkrNJb1n1fKgq0MvqXM3ryF_ANR7O7nsZBMALig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJw_Zu6DoimkrNJb1n1fKgq0MvqXM3ryF_ANR7O7nsZBMALig@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 02, 2022 at 08:42:22PM +0800, Jeff Chua wrote:
> Login prompt seems to be truncated. The length should be taken from
> LOGIN_PROMPT instead of LOGIN_PROCESS.
> 
> --- utilx/term-utils/agetty.c     2022-03-30 23:14:12.055417041 +0800
> +++ utilx/term-utils/agetty.c 2022-05-02 20:31:43.177845547 +0800
> 
> @@ -2149,7 +2149,7 @@
>         if (!op->autolog) {
>                 /* Always show login prompt. */
>                 write_all(STDOUT_FILENO, LOGIN_PROMPT,
> -                               sizeof(LOGIN_PROCESS) - 1);
> +                               sizeof(LOGIN_PROMPT) - 1);
>         }
>  }

Ah, vim text completion could be dangerous :-)

Thanks for your report! Fixed.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

