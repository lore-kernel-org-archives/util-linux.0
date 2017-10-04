Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.eastlink.ca ([24.224.136.13]:54453 "EHLO
        mta02.eastlink.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdJDJ33 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 4 Oct 2017 05:29:29 -0400
Received: from emgw02.eastlink.ca ([71.7.199.174])
 by mta02.eastlink.ca (Oracle Communications Messaging Server 7.0.5.37.0 64bit
 (built Jan 25 2016)) with ESMTP id <0OXA0055AJN4Q4B1@mta02.eastlink.ca> for
 util-linux@vger.kernel.org; Wed, 04 Oct 2017 05:59:28 -0300 (ADT)
Date: Wed, 04 Oct 2017 05:59:26 -0300
To: Karel Zak <kzak@redhat.com>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: fdisk request for functionality (or info)
Message-id: <20171004085926.GI18363@cordes.ca>
References: <59D3C162.4050005@gmail.com>
 <20171004082728.if274peupxjljbxd@ws.net.home>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <20171004082728.if274peupxjljbxd@ws.net.home>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 04, 2017 at 10:27:28AM +0200, Karel Zak wrote:
> The tricky thing is that fdisks by default see GPT partition, so you
> have to force the tools to ignore GPT and use PMBR.

 Would it be possible to add a more user-friendly way to present this
to the user?

Maybe a special command to toggle the PMBR bootable flag while looking
at the GPT?  That would make the complexity / existence of the PMBR more
discoverable for users, because it would show up in the built-in help
command output while looking at the GPT.  Toggling bootable is just
about the only useful thing you can do with the PMBR on a GPT disk,
and by far the most common, so "hiding" that functionality / status when
looking at the bootability of GPT isn't ideal.

>  3) use sfdisk:
> 
>       sfdisk --label-nested dos --activate /dev/sda 1

That's pretty non-obvious.  I don't think many people would come up
with that on their own if they aren't partitioning / sfdisk experts.
Of course it makes a good recipe, so hopefully people will find it
with google.

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC
