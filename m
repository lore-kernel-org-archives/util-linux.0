Return-Path: <SRS0=aW19=7R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F6FC433DF
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 09:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58785207D3
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 09:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMbyrQrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFDJay (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:30:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56548 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbgFDJax (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 Jun 2020 05:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591263052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEOyrDNzn9GsFRagpvF8PaQVVmk8F1cvA3IrUtwyZ2c=;
        b=YMbyrQrPFbwWv1VwCO2wtUSM+RrC1Yy94UprudtjFAw7xmCA/SsNJQ4/9zppbOtN/blHvJ
        5/QmMSGhkxi9HBLjW8HvFgCXBDAI6tdeoczp1rbUbZ1KmTX5LftCpU/uBvV9kWfXDaIRuf
        REqGmFteRCkb4+KMQxL3wlWmmkADbZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-j5rBytRaMcqTxTzbc4_e1g-1; Thu, 04 Jun 2020 05:30:48 -0400
X-MC-Unique: j5rBytRaMcqTxTzbc4_e1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32FF8107ACCD;
        Thu,  4 Jun 2020 09:30:47 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 488B45C297;
        Thu,  4 Jun 2020 09:30:45 +0000 (UTC)
Date:   Thu, 4 Jun 2020 11:30:43 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     util-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH util-linux] dmesg: adjust timestamps according to
 suspended time
Message-ID: <20200604093043.55a4zzo2hewhcwru@ws.net.home>
References: <159103929487.199093.15757669576783156290.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159103929487.199093.15757669576783156290.stgit@buzz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 01, 2020 at 10:21:34PM +0300, Konstantin Khlebnikov wrote:
> Timestamps in kernel log comes from monotonic clocksource which does not
> tick when system suspended. Suspended time easily sums into hours and days
> rendering human readable timestamps in dmesg useless.
> 
> Adjusting timestamps accouring to current delta between boottime and
> monotonic clocksources produces accurate timestamps for messages printed
> since last resume. Which are supposed to be most interesting.

It's definitely better than the current broken timestamps, but the real
and final solution is to have exact information about system suspends.

It would be enough to maintain in kernel memory a simple log with
   <bootime> <monotonic> <state_change>
and export this info by /proc/suspendlog, after that we can all 
re-count /dev/kmsg timestamps to something useful.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

