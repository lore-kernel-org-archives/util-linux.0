Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A5DC388F7
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86CB20665
	for <util-linux@archiver.kernel.org>; Tue, 10 Nov 2020 20:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwhDQrrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJUu7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:50:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgKJUu7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Nov 2020 15:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605041457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UCQdS6ne7B+z1cPu6F6vtDC5fNTUKRZBXYX7NtnRrwo=;
        b=iwhDQrrwdnJ8paCGDzeAnty7AzYN6QVzIVn7HW5O3tBVWin9DWcys/vz/ztYCu2a1x1baj
        z+0ka/0KXq++9STi01ztST2YpLo4vcY2w3HlSnBAJTgIxjUEzjdtJb7QFda287gWqIp/4i
        oYvXn0jBYVbYBOS2PeaicxUZSnXuH7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-XHH3GuGfPA23scsVm9ot9g-1; Tue, 10 Nov 2020 15:50:55 -0500
X-MC-Unique: XHH3GuGfPA23scsVm9ot9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD17F100F7A3
        for <util-linux@vger.kernel.org>; Tue, 10 Nov 2020 20:50:54 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (ovpn-115-106.rdu2.redhat.com [10.10.115.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F07C1002C2B
        for <util-linux@vger.kernel.org>; Tue, 10 Nov 2020 20:50:54 +0000 (UTC)
Date:   Tue, 10 Nov 2020 14:50:52 -0600
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH v4 2/2] lscpu-arm: Remove hard corded model name of
 Cortex family and X-Gene
Message-ID: <20201110205052.5nnujoloficzbck3@tarantula.users.ipa.redhat.com>
Mail-Followup-To: util-linux@vger.kernel.org
References: <201fdf4b-5238-6e39-8883-f1ba0dbca4a5@arm.com>
 <20201110083712.kfisfq4yv5yadx4w@ws.net.home>
 <20201110185015.dk6xhlzdqrurlh7h@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201110185015.dk6xhlzdqrurlh7h@gabell>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 10, 2020 at 01:50:15PM -0500, Masayoshi Mizuma wrote:
>On Tue, Nov 10, 2020 at 09:37:12AM +0100, Karel Zak wrote:
>> On Mon, Nov 09, 2020 at 11:19:08PM -0600, Jeremy Linton wrote:
>> > I don't agree with this, I think the hard coded table should be the first
>> > authority on the manufacture/part number lists. That is because SMBIOS isn't
>> > available on a fairly large number of arm systems, and on systems where it
>> > does exist, it suffers from the same kinds of problems that exist on many
>> > !arm machines. Its not particularly a reliable source of information.
>> >
>> > So, maybe if you have a situation where the SMBIOS information is more
>> > correct than the hardcoded tables, maybe its a good idea to create a new
>> > line?
>> >
>> >
>> > Aka:
>> >
>> > Vendor Id: ARM
>> > Model Name: Cortex-A57
>> > BIOS Name: JoeSmithsCore
>>
>> I like this idea.
>
>Yeah, it's s great idea!
>SMBIOS Type4 also has Vendor Id (Processor Manufacturer),
>so the following is better?
>
> Vendor Id: ARM
> Model Name: Cortex-A57
> BIOS Vendor Id: Foobar
> BIOS Model Name: JoeSmithsCore
>
>Jeff, does the above idea work for your case? X-Gene(eMAG) will be:
>
> Vendor Id: APM
> Model Name: X-Gene
> BIOS Vendor Id: Ampere(TM)
> BIOS Model Name: eMAG


This is perfect.  I like the idea of showing both instead of preferring
one over the other.

-- 
Jeff Bastian
Kernel QE - Hardware Enablement
Red Hat

