Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DB3C433EF
	for <util-linux@archiver.kernel.org>; Tue, 22 Feb 2022 01:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiBVBtJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Feb 2022 20:49:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBVBtJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 21 Feb 2022 20:49:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BA525586
        for <util-linux@vger.kernel.org>; Mon, 21 Feb 2022 17:48:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 67EE61F393;
        Tue, 22 Feb 2022 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645494523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En2TBAlGgb/oSoRRgI4o1tkTdOXhcmlDAL7t0H1tNz0=;
        b=2j+JCE7NPlNtKLo8gVdok+ivNaa+to0I7vFDSeWhcYnsESRq8Sx925gR7QuZjFxkoS6rl/
        Ym4Chl8toOIcTzDDpiHI6/z8fft1ylxMW1NKyvsfm1nFIIJYcn6F+W0CZzeMe4+ra3XVc5
        BQtFJ0x4OtEdpdua+Gkbb+zUbanlFyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645494523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En2TBAlGgb/oSoRRgI4o1tkTdOXhcmlDAL7t0H1tNz0=;
        b=kQi8PSWvRkAzTtZyExWDtwRWyyFjSEyJc8lqNym5dDTeuORc8/02bhRtnuFJXC68d1S5K7
        tn+cKWD1LSvAEfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39EA913BA7;
        Tue, 22 Feb 2022 01:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZNk+CftAFGKuQQAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Tue, 22 Feb 2022 01:48:43 +0000
Message-ID: <e8fabaa8-7e2f-6959-8017-174da966820d@suse.cz>
Date:   Tue, 22 Feb 2022 02:48:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC] uuid_generate_time_safe() without uuidd should always
 return -1
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <1a366a68-8f04-44d7-2a26-6cbe2989d2d4@suse.cz>
 <20220221120625.w5h7b7v54wdzgafy@ws.net.home>
From:   Stanislav Brabec <sbrabec@suse.cz>
Organization: SUSE Linux, s. r. o.
In-Reply-To: <20220221120625.w5h7b7v54wdzgafy@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel Zak wrote:
> On Fri, Feb 18, 2022 at 04:56:39PM +0100, Stanislav Brabec wrote:

> Maybe we need decomposition of complex uuid_generate_time_generic()
> into small one-purpose functions and then mix these functions
> in uuid_generate_time_safe() and uuid_generate_time().
> 
> What about to create small local functions with always only one
> purpose and without any fallback:
> 

It could make the code a bit more readable for sure.

>   uuid_generate_time_async()         -- random bytes + gettimeofday() or -1
>   uuid_generate_time_sync_by_file()  -- LIBUUID_CLOCK_FILE based or -1
>   uuid_generate_time_sync_by_uuidd() -- connect() uuidd or -1
> 
> public API uuid_generate_time():
> 
>      uuid_generate_time_sync_by_uuidd() or
>      uuid_generate_time_sync_by_file() or
>      uuid_generate_time_async()
>      
> public API uuid_generate_time_safe():
> 
>      uuid_generate_time_sync_by_uuidd() (=return 0) or
>      uuid_generate_time_sync_by_file()  (=return 1) or
>      -1

It looks good.

> and uuidd will always call uuid_generate_time_sync_by_file() and
> nothing else.

Well, good idea. We could make a breaking change there: If the uuid_generate_time_sync_by_file() fail, the whole uuidd will fail, not trying any fallback.

It causes an ugly mis-behavior: Just now, any soft error that happens in the uuidd does not cause the UUIDs being recognized as unsafe.

Example:
chown root:root /var/lib/libuuid/clock.txt
service uuidd restart # It cannot access /var/lib/libuuid/clock.txt any more.
uuid_generate_time_safe()
will now return 0, but UUID is apparently unsafe.

as long as it succeeds.

  
> Yes, it's more work, but it will make code more readable, easy to
> maintain and easy to extend in future.

I agree. It was really hard to understand what is actually happening there, and why uuidd does not go into recursion.

>> Add a new return code of uuid_generate_time_safe().
>>
>> == RETURN VALUE
>>
>> The newly created UUID is returned in the memory location pointed to by
>> _out_. *uuid_generate_time_safe*() returns zero if the UUID has been
>> generated in a safe manner, 1 if the UUID has been generated in a manner
>> that is safe for a single UID, -1 otherwise.
> 
> Make sense ;-)

Do you think that we could make such API change (3 return values instead 2)?

I think that most implementations compare with zero, so it should be OK.

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
