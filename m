Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CFC433F5
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiBAOOk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:14:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239111AbiBAOOi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 09:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643724877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9v+PDCD/VgisWWPLUokYrWAdJMbWk/uK+lq0hJUJT0Q=;
        b=ao3n2fnTqaYYjCFOTvPbrOlKsuI2PHxLLfoOpDJOpB2h64b+ZbRlegtxw1E3TvJS/0kfQq
        m0U1uNJTXzrv50uxAfLxluNYoMl/6C+n2benH9u7iYAsFlrF+N8DEeBvOg26r+vN9lEZzV
        BmC0lDgqvFhotAGmjR9Z1Rl5eiVGkY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-OyGqSLGTNr-IkhtGStH23Q-1; Tue, 01 Feb 2022 09:14:34 -0500
X-MC-Unique: OyGqSLGTNr-IkhtGStH23Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7D81091DA0;
        Tue,  1 Feb 2022 14:14:33 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB95010A48BC;
        Tue,  1 Feb 2022 14:14:32 +0000 (UTC)
Date:   Tue, 1 Feb 2022 15:14:30 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@aquilenet.fr>,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220201141430.sscfssbebyg3kzjq@ws.net.home>
References: <20220131151432.mfk62bwskotc6w64@ws.net.home>
 <20220131182030.ci3q6puznrwt6vst@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131182030.ci3q6puznrwt6vst@begin>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 31, 2022 at 07:20:30PM +0100, Samuel Thibault wrote:
> Hello,
> 
> Karel Zak, le lun. 31 janv. 2022 16:14:32 +0100, a ecrit:
> > The util-linux release v2.38-rc1 is available at
> >      
> >   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
> 
> Thanks, here are a few non-Linux portability fixes

Applied with minor changes, thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

