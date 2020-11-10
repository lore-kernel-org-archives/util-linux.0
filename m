Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B025C388F7
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E78420731
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 08:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHDZofJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKJIhX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgKJIhX (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Nov 2020 03:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604997442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZ6ug1bXC3A/FPxLF8oGWCArBf0ILbfQR/tvjf2AW8o=;
        b=bHDZofJPPy228KsvC1btHdqF7CS4LHHsKn8RemonRB6akGGbQf0SHFkDyph2MbFfXKdYbU
        NY1xtITlH6qA7W3H1E3w2I6be1LQbrzKqZmwSGgGaVPiL0SEyg2mfkn0WrjjGEbJZsuyVl
        b+MpbBDwIiO7urf7fWzs5rJMZ4UZiKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-W-gBvMwVP-aekJWSl-OABQ-1; Tue, 10 Nov 2020 03:37:17 -0500
X-MC-Unique: W-gBvMwVP-aekJWSl-OABQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 520761006C9A;
        Tue, 10 Nov 2020 08:37:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0625E6EF76;
        Tue, 10 Nov 2020 08:37:14 +0000 (UTC)
Date:   Tue, 10 Nov 2020 09:37:12 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     util-linux@vger.kernel.org, Jeffrey Bastian <jbastian@redhat.com>,
        msys.mizuma@gmail.com, m.mizuma@jp.fujitsu.com
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201110083712.kfisfq4yv5yadx4w@ws.net.home>
References: <201fdf4b-5238-6e39-8883-f1ba0dbca4a5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201fdf4b-5238-6e39-8883-f1ba0dbca4a5@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 09, 2020 at 11:19:08PM -0600, Jeremy Linton wrote:
> I don't agree with this, I think the hard coded table should be the first
> authority on the manufacture/part number lists. That is because SMBIOS isn't
> available on a fairly large number of arm systems, and on systems where it
> does exist, it suffers from the same kinds of problems that exist on many
> !arm machines. Its not particularly a reliable source of information.
> 
> So, maybe if you have a situation where the SMBIOS information is more
> correct than the hardcoded tables, maybe its a good idea to create a new
> line?
> 
> 
> Aka:
> 
> Vendor Id: ARM
> Model Name: Cortex-A57
> BIOS Name: JoeSmithsCore

I like this idea. 

Note that for majority of our users know, use and expect names like
Cortex-A57, but I have doubts about "JoeSmithsCore" :-)

> In the vast majority of cases I imagine the strings should match. The
> problematic cases are LTS os's running on newer hardware. For that i'm
> somewhat of the opinion the Model Name should remain "unknown" rather than
> being silently updated. That is to avoid cases where the output from newer
> lscpu's changes during an upgrade.
> 
> PS, Having this hardcoded table isn't optimal, but for now I think we are
> stuck with it. Hopefully at some point we can work out a reliable way to
> source the info. In the meantime, it looks like I need to submit some table
> updates, since there are some newer arm models...

Yes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

