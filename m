Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38919C433F5
	for <util-linux@archiver.kernel.org>; Tue,  5 Apr 2022 05:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiDEFsn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiDEFsk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Apr 2022 01:48:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3066A5E15F
        for <util-linux@vger.kernel.org>; Mon,  4 Apr 2022 22:46:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B39A1F37E;
        Tue,  5 Apr 2022 05:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649137601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIubfwrceQcv8oTjm12olDHY+Ob8MNaMCr62aIwPn1c=;
        b=1ypckcO5XwZwZcrx3+OZOgUW8jDu4UZPQYM3JmL99BwQtbGv9fD1zRKMU4aYV7DCjB5Imn
        DwCTZLM6VIngdmgz2FxjCoKMYlLqlJI8200e3UzQW/jgZnsqQoYNA9yPpOwbBvYaaKJixM
        gZ3zJosh83qrk15tJoxgwEoYGkcAqIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649137601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JIubfwrceQcv8oTjm12olDHY+Ob8MNaMCr62aIwPn1c=;
        b=2G/os9q+3cSWHM3wMLRzxs1TQwiDxX9XrhZuZ4VkK18OlICBt4HK5nm78tFQjIv+J+Weop
        QU5+Z2n4tFi3mgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1456E13216;
        Tue,  5 Apr 2022 05:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jiMgA8HXS2IdSAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 05:46:41 +0000
Message-ID: <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
Date:   Tue, 5 Apr 2022 07:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, util-linux@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405054205.GA23466@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/5/22 07:42, Christoph Hellwig wrote:
> On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
>> It is really annoying to always have to loop through the entire
>> /sys/block directory just to find the namespace path links for
>> a single namespace in libnvme/nvme-cli.
>> So provide links to the namespace paths for efficient lookup.
> 
> I think having some form of links would be useful.  Quite a while ago
> Thadeu looked into adding some form of relationship for lsblk and
> friends.  Maybe it would be good to sync up and make sure whatever
> links we are adding would be useful for all users?
> 
Care to elaborate?
Using the block device name is the most straightforward way here; we 
don't have a good enumeration to leverage as the paths are essentially 
just a linked list.

We sure can have a subdirectory 'paths', and stick the links in there.
If that helps with lsblk ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
