Return-Path: <SRS0=aW19=7R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E1DC433DF
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F0F6206C3
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNO9WfoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgFDKVZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:21:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23777 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgFDKVV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 Jun 2020 06:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591266080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSUt/M2frPtSsqZnHp0XYXCk18yFWUkSIdMBdFgZ1wg=;
        b=NNO9WfoCFvLPZfQd46Q+iR0TpeJvuTQaARghA0NNondMMSvOPZHd+H2TkibrRu1lOyWC5T
        LXScGpVmgqVKM7VMp1hZMt18Ys4Wpew7w0+dxyzht83phyN4o/MIl6ZGvER1HHFDEd/jec
        OnVOPWB4v0oVqvEB/uyoZbZEQirEQqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-YLGD09sgMU-beIe59zbfHg-1; Thu, 04 Jun 2020 06:21:16 -0400
X-MC-Unique: YLGD09sgMU-beIe59zbfHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07FAF800C78;
        Thu,  4 Jun 2020 10:21:15 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 075E02DE71;
        Thu,  4 Jun 2020 10:21:13 +0000 (UTC)
Date:   Thu, 4 Jun 2020 12:21:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     util-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH util-linux] dmesg: adjust timestamps according to
 suspended time
Message-ID: <20200604102111.vst3goseqfxz5fa4@ws.net.home>
References: <159103929487.199093.15757669576783156290.stgit@buzz>
 <20200604093043.55a4zzo2hewhcwru@ws.net.home>
 <c1ec31ea-494b-5d3e-3c0c-c3d8bb1a6c9c@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ec31ea-494b-5d3e-3c0c-c3d8bb1a6c9c@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 04, 2020 at 12:43:52PM +0300, Konstantin Khlebnikov wrote:
> On 04/06/2020 12.30, Karel Zak wrote:
> > On Mon, Jun 01, 2020 at 10:21:34PM +0300, Konstantin Khlebnikov wrote:
> > > Timestamps in kernel log comes from monotonic clocksource which does not
> > > tick when system suspended. Suspended time easily sums into hours and days
> > > rendering human readable timestamps in dmesg useless.
> > > 
> > > Adjusting timestamps accouring to current delta between boottime and
> > > monotonic clocksources produces accurate timestamps for messages printed
> > > since last resume. Which are supposed to be most interesting.
> > 
> > It's definitely better than the current broken timestamps, but the real
> > and final solution is to have exact information about system suspends.
> > 
> > It would be enough to maintain in kernel memory a simple log with
> >     <bootime> <monotonic> <state_change>
> > and export this info by /proc/suspendlog, after that we can all
> > re-count /dev/kmsg timestamps to something useful.
> 
> Boottime or real time could be simply printed into kernel log at
> suspend and resume. So demsg could detect current offset while reading.

 Yes, but not sure if this is the most robust way (dmesg --clear will
 remove this info) and I guess the suspendlog can be useful
 independently on kmsg.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

