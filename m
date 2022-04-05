Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B10C433FE
	for <util-linux@archiver.kernel.org>; Tue,  5 Apr 2022 11:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiDELKM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350936AbiDEKA2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Apr 2022 06:00:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE36B0A7
        for <util-linux@vger.kernel.org>; Tue,  5 Apr 2022 02:51:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 069191F7AE;
        Tue,  5 Apr 2022 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649152280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27m3uUerfH0PTfjei9wY5v3DeBaO1GFiDL86rcZsWYo=;
        b=pbshNOp5W6nSB4DGVjuygwDlF7MA7G46kZACAC7JO+Y08p7a4QTNOkPFl+8g3saQ2vqdUL
        HUoJ7GnIraa8znWlEJmKMUd4FEUvESIxfkHEEX7CSdXDAOLy5ZgNr/Apo5ByMisWHJS3sK
        BNPYva8xDH+O5gaGvCUpKEDOe3YeTmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649152280;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=27m3uUerfH0PTfjei9wY5v3DeBaO1GFiDL86rcZsWYo=;
        b=uOF0ih5hGQHHcDqfS4YyNezmL+e1+Bgeo43fyE668xcR+vtsdcBlwlvKKmlPltYp/19BDy
        PedUdwSMmV9ufCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E08F313A04;
        Tue,  5 Apr 2022 09:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8y2XNBcRTGJ0QAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 09:51:19 +0000
Message-ID: <0d53d5cb-a22d-c620-1a35-1ab408e0f747@suse.de>
Date:   Tue, 5 Apr 2022 11:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        util-linux@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
 <b997ceac-a391-cc5a-a397-0d68f91736eb@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <b997ceac-a391-cc5a-a397-0d68f91736eb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/5/22 10:34, Sagi Grimberg wrote:
> 
>>>>> It is really annoying to always have to loop through the entire
>>>>> /sys/block directory just to find the namespace path links for
>>>>> a single namespace in libnvme/nvme-cli.
>>>>> So provide links to the namespace paths for efficient lookup.
>>>>
>>>> I think having some form of links would be useful.  Quite a while ago
>>>> Thadeu looked into adding some form of relationship for lsblk and
>>>> friends.  Maybe it would be good to sync up and make sure whatever
>>>> links we are adding would be useful for all users?
>>>>
>>> Care to elaborate?
>>> Using the block device name is the most straightforward way here; we 
>>> don't
>>> have a good enumeration to leverage as the paths are essentially just a
>>> linked list.
>>>
>>> We sure can have a subdirectory 'paths', and stick the links in there.
>>> If that helps with lsblk ...
>>
>> I personally don't care.  But I've added Thadeu and the util-linux list
>> to get everyone on board.
> 
> Why not stick to slaves/ like the device mapper?

Because:

/**
  * bd_link_disk_holder - create symlinks between holding disk and slave 
bdev
  * @bdev: the claimed slave bdev
  * @disk: the holding disk
  *
  * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
  *

Not sure _why_ it's there, but it is there.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
