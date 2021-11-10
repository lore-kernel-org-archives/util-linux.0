Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE7C433EF
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E44B61159
	for <util-linux@archiver.kernel.org>; Wed, 10 Nov 2021 09:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhKJKBj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Nov 2021 05:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhKJKBi (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Nov 2021 05:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636538331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clsLGw7H2pKiHQr4CFDSo7NGgBXXDTCgYHIRjUiTbiw=;
        b=WfLOC0bu8OnQuPRJNYQGVvMs1j2DmEvTZwHgo0vP4neUEL85TzKgU8GqyKKM42N8DBzbA+
        wIkIQLQOQP4Phx3HT3FnZjPcIt/6KhPTWm7yAF14K0cT/5t5r0y6B1V+8USbHCodSYGZ3r
        0i9a4RK3eZq3NR2/7d9HRwjo1/1ndAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-7ofRp5dnO-GQSNLHc9cLjQ-1; Wed, 10 Nov 2021 04:58:48 -0500
X-MC-Unique: 7ofRp5dnO-GQSNLHc9cLjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41C11101AFA7;
        Wed, 10 Nov 2021 09:58:47 +0000 (UTC)
Received: from ws.net.home (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 910C160854;
        Wed, 10 Nov 2021 09:58:46 +0000 (UTC)
Date:   Wed, 10 Nov 2021 10:58:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] irqtop: add -c/--cpus option
Message-ID: <20211110095843.lfg6c7zxhrst42xb@ws.net.home>
References: <20211110031642.141240-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110031642.141240-1-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 10, 2021 at 11:16:42AM +0800, zhenwei pi wrote:
> Since a23aecc1bf("irqtop: add per-cpu stats"), irqtop always shows
> per-cpu stats. Test on a modern AMD server with 2 socket(256 CPU),
> irqtop shows like following:

Thanks! This was on my TODO list too.

> +	/* print cpus table or not by -c option */
> +	do {
> +		int x, y;
> +
> +		if (ctl->cpus == irqtop_cpus_table_disable)
> +			break;
> +
> +		scols_print_table_to_string(cpus, &data);
> +		if (ctl->cpus == irqtop_cpus_table_auto) {
> +			/* detect window size */
> +			getmaxyx(ctl->win, y, x);
> +			y = y;	/* avoid build warning*/
> +			p = strchr(data, '\n');
> +			if (p) {
> +				/* line is too long */
> +				if ((p - data) > x) {
> +					free(data);
> +					break;
> +				}
> +			}
> +		}

libsmartcols provides scols_table_enable_nowrap(), this function 
forces the library trim the output. It seems more elegant.

I have applied your patch with some changes
https://github.com/util-linux/util-linux/commit/17f7caa45105f0cbf8bf9b562468fba2c5d4a549

(and https://github.com/util-linux/util-linux/commit/d1732bba383a95786b5ec7bc1f4a173b644fe871
 as I forgot update bash-completion in the first commit)

Thanks again!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

