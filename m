Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A989C433F5
	for <util-linux@archiver.kernel.org>; Thu, 11 Nov 2021 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339F361247
	for <util-linux@archiver.kernel.org>; Thu, 11 Nov 2021 10:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhKKKkk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230256AbhKKKkk (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 11 Nov 2021 05:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636627069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thL7sw7IX2f6mSBabpulOLYIWPUFG6kka4DGT6cjIME=;
        b=M+IJYWV9UCzkSa63UZ1qFrAt/eEytJ7CCdFUW7Sgt9m/fhBlueI/WAjLMGF0urSoFwiJ0n
        kPBYeZpFE2G4VEKbhA9n/82ND+P46JCZbtG8rJvqdmUH63MCVD6i6lSs3AwGI8WE/cg/lw
        kpi9Hie2dVyuEB8GTKPOFozwc3/BU8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-GWg1-oa5PlaJIziianjPTw-1; Thu, 11 Nov 2021 05:37:48 -0500
X-MC-Unique: GWg1-oa5PlaJIziianjPTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C62118125C4;
        Thu, 11 Nov 2021 10:37:47 +0000 (UTC)
Received: from ws.net.home (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7911E67842;
        Thu, 11 Nov 2021 10:37:46 +0000 (UTC)
Date:   Thu, 11 Nov 2021 11:37:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] irqtop: add -c/--cpus option
Message-ID: <20211111103743.caaxd3chyct4uc4f@ws.net.home>
References: <20211110031642.141240-1-pizhenwei@bytedance.com>
 <20211110095843.lfg6c7zxhrst42xb@ws.net.home>
 <20211110195051.66091d14@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110195051.66091d14@gmx.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 10, 2021 at 07:50:51PM +0100, Peter Seiderer wrote:
>  	static const struct option longopts[] = {
> +		{"cpus", required_argument, NULL, 'c'},
>  		{"delay", required_argument, NULL, 'd'},
>  		{"sort", required_argument, NULL, 's'},
>  		{"output", required_argument, NULL, 'o'},
> 
> s/cpus/cpu-stat/ ?

Ah, yes. Fixed, thanks for your review!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

