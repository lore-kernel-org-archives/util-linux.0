Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B2C77B75
	for <util-linux@archiver.kernel.org>; Mon, 22 May 2023 14:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjEVOJ4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 May 2023 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjEVOJm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 May 2023 10:09:42 -0400
Received: from yamato.tf-network.de (yamato.tf-network.de [93.186.202.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23E8F
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 07:09:35 -0700 (PDT)
Received: from amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221])
        by yamato.tf-network.de (Postfix) with ESMTP id 4QPzpk0KvJz3xVc
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 16:09:34 +0200 (CEST)
X-Virus-Scanned: amavis at amavis3.tf-network.de
Received: from smtp.tf-network.de ([93.186.202.221])
 by amavis3.tf-network.de ([IPv6:2001:4ba0:ffa0:1b::d1:221]) (amavis, port 10024)
 with LMTP id sdFQ1vXSfyjo for <util-linux@vger.kernel.org>;
 Mon, 22 May 2023 16:09:32 +0200 (CEST)
Received: from [IPV6:2a0a:a546:d16:0:95f9:3d7b:dbe1:214c] (2a0a-a546-d16-0-95f9-3d7b-dbe1-214c.ipv6dyn.netcologne.de [IPv6:2a0a:a546:d16:0:95f9:3d7b:dbe1:214c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by securesmtp.tf-network.de (Postfix) with ESMTPSA id 4QPzph6QW5z3wfg
        for <util-linux@vger.kernel.org>; Mon, 22 May 2023 16:09:32 +0200 (CEST)
Message-ID: <d9b49d0a-c7eb-e110-ca71-e621df4a52cf@whissi.de>
Date:   Mon, 22 May 2023 16:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: util-linux 2.39 doesn't work with <linux-5.12: mount(2) system
 call failed: Function not implemented
To:     util-linux@vger.kernel.org
References: <af9fcbe9-15fc-0ce2-1fa6-2239f740a1c9@whissi.de>
 <09636701-1136-4174-a453-5076ef0328f6@t-8ch.de>
 <03db6ada-02ee-48a1-a2dd-47335e70a681@whissi.de>
 <e2c624df-575b-4c66-a8b8-a5fc80a44b08@t-8ch.de>
 <089b028f-7ccb-5389-4ba0-06830f27e738@whissi.de>
 <a774f583-f985-4849-9b75-4fed59a47209@t-8ch.de>
Content-Language: en-US
From:   Thomas Deutschmann <whissi@whissi.de>
In-Reply-To: <a774f583-f985-4849-9b75-4fed59a47209@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

On 2023-05-22 09:43, Thomas Weißschuh wrote:
> I was finally able to reproduce the issue.
> 
> Could you test https://github.com/util-linux/util-linux/pull/2248 again?

This fixes the issue for me, thank you!

Just one comment regarding the design of the fix:

Due to the introduction of mount_setattr_is_supported(), util-linux will 
now "waste" one syscall on every mount -- even on a modern system -- right?

A more "natural" approach like calling new API first but when this will 
fail with ENOSYS then fallback to old API (so we would only spend an 
additional call on old systems which is fine because we assume that 
their number will decrease over time) cannot be implemented due to the 
way how the hook system works, right?

But maybe this "wasted" call isn't much to think about. I was just 
wondering when I saw a call like

   mount_setattr(-1, NULL, 0, NULL, 0)

even on modern systems.


-- 
Regards,
Thomas
