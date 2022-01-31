Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E88FC433F5
	for <util-linux@archiver.kernel.org>; Mon, 31 Jan 2022 22:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiAaWfV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:35:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40402 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiAaWfV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jan 2022 17:35:21 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4395021118;
        Mon, 31 Jan 2022 22:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643668520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnEMLlUufvNedtiHvS8s8SClqfNhu/MvtWPFG5+MWvA=;
        b=eWA37jTPv6dy1esb3iqY970SWMezttcY5ECgJtN2gpG1cgxUNvjzqFvQ+hO5TCC/I2MXLt
        xUnhc0a4IbbzfzaOv0syj9CITZwn7NV6MghKHgn+yKt5UhJOrXKRmTzzlXH9UXJ4SQwpP2
        2koKLIMQvuwSVE2v7FmUQjz/SHtyef4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643668520;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnEMLlUufvNedtiHvS8s8SClqfNhu/MvtWPFG5+MWvA=;
        b=d29daOdI9HnkfQFQwNsEW0ijisgQ5HPcCtOdwf6erAS4yfCiuDDMgJ1detQc9UwCSsks7p
        Rn/0FlJIUPkllOCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21D5413CC7;
        Mon, 31 Jan 2022 22:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RmraBShk+GGHFgAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Mon, 31 Jan 2022 22:35:20 +0000
Message-ID: <55ff6182-f447-dd80-67f0-7e230c28712c@suse.cz>
Date:   Mon, 31 Jan 2022 23:35:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] fstrim: Add fstab option x-fstrim.notrim
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <823c644a-9eec-4832-0f52-e5e9419aad95@suse.cz>
 <20220131095517.ngxxlu3vb74orljy@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20220131095517.ngxxlu3vb74orljy@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

My original patch contains 2 adoc chunks: one for -A, second for 
--listed-in. X-fstrim.notrim works for both. Was the omitting of the 
chunk for --listed-in intentional?

(Maybe it could be mentioned in a better way, so only one mention will 
be enough.)

Karel Zak wrote:
> On Mon, Jan 31, 2022 at 01:21:30AM +0100, Stanislav Brabec wrote:
>> Sometimes it makes sense to skip fstrim for selected file mounts, but
>> still be able to use fstrim.service.
>>
>> Add a possibility to specify "x-fstrim.notrim" in fstab.
> Good idea, but I've merged it with small change.
>

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

