Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D19C433F5
	for <util-linux@archiver.kernel.org>; Fri, 14 Jan 2022 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiANOme (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Jan 2022 09:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiANOme (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2022 09:42:34 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BE9C061574
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2022 06:42:34 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id bt14so4430258qvb.13
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2022 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WSARwmcZceKku/T3adv01VOWQU3hkbDMLrLfIR8R/XU=;
        b=jGn5AkCfukg9vuuIsNxXdTXqVqTam0zklrHVnwGzkncox8UAwYY4QgLHGZej2R1pUx
         /JvWnqrTVfm3Gw2ZlbbEs33x8EZ8lEZcUI3dpiztnEZwLoTuDobBpn8/8RcZVBnuzIQ/
         Zg7+/KBWTLLTOugZCu8am9hZ9dMtx6HZd7c8NInaP4NmRvKFbm4MQCW11c1JA8CCFza7
         Tn3W7cxtojkZCdaUXqRAzDinnQVzW440mG3/dKkKX2fv3CR70VJiGg3VcXMTPku3ziWL
         /giTQVYUW3RkNeangW0+lVQrGn436FSBXAvHUEfUnEA2KO7k2MmTm0CwvKJd9oOaxJa8
         sQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WSARwmcZceKku/T3adv01VOWQU3hkbDMLrLfIR8R/XU=;
        b=HTsVW51+wMMJAbXAojmkKyRxrSWSJtgffzu7ACfufy/XEG99GizDGVR7KCCfPqGxvo
         TNJJALQIzzO27hhh7bHtkbJcGITqNfLGc+AzloCE8vH2Yd2Yc/sj5jeEzpm99IS+fZ8r
         SSOXNnqYL1GazX9G+HYJcWqyY+W3c07QncSRdOkiN1TPyTDlGgYMn+vf8xesZsPbe86V
         lwdcGBImPqw5NGmIAvInCTuFbNOyxfi4WxjZP9cRDjSOFGtMvKLZ03EqZxT2+4VqIeJa
         2pwEpToaixpHoVMhAtS+xn9C0stYQPJxqNxA0LqBRDI70UEyYsrldNFlCKvFygklhfhD
         ZlVA==
X-Gm-Message-State: AOAM532ztnQtWIeQNvpjqPZY3zfn0eXPmVl4lbctuQEjJ8Gj6N+tkze9
        Kmo0Bngi1/I/R8m9yP3o9WjJc+8ydGU=
X-Google-Smtp-Source: ABdhPJzjWZBrDNbMqtIn3u71DocqwpGN90k3cwrNIq4kh9lMr83putfGKmeJyE0TTjGK1yD/JH2tsg==
X-Received: by 2002:a05:6214:224e:: with SMTP id c14mr1288989qvc.11.1642171353185;
        Fri, 14 Jan 2022 06:42:33 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.googlemail.com with ESMTPSA id v14sm4029914qta.43.2022.01.14.06.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 06:42:32 -0800 (PST)
Subject: Re: [PATCH v2 0/6] unshare: Add support for mapping ranges of
 user/group IDs
To:     Daniel Gerber <dg@atufi.org>
Cc:     dottedmag@dottedmag.net, id@mbekkema.name, jpeach@apache.org,
        kzak@redhat.com, util-linux@vger.kernel.org
References: <874k664nlq.fsf@atufi.org>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <73850170-db69-7d64-ca9e-6e41dfa4eab9@gmail.com>
Date:   Fri, 14 Jan 2022 09:42:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <874k664nlq.fsf@atufi.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 1/14/22 5:29 AM, Daniel Gerber wrote:
> Hi,
> 
> Thanks for this feature. I've been trying it out... (This is with lib-musl-x86_64.)
> 
> Automatic mapping works:
> 
> $ unshare --map-users=auto cat /proc/self/uid_map
>           0     100000      65536
> 
> But parsing id ranges does not:
> 
> $ unshare --map-users=100000,0,65536 cat /proc/self/uid_map
> unshare: could not parse ID: '100000,0,65536'
> 
> Fix:
> ---
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index 443358952..52bd9702a 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -388,7 +388,7 @@ static int uint_to_id(const char *name, size_t sz)
>   	char buf[UID_BUFSIZ];
> 
>   	mem2strcpy(buf, name, sz, sizeof(buf));
> -	return strtoul_or_err(name, _("could not parse ID"));
> +	return strtoul_or_err(buf, _("could not parse ID"));
>   }
> 
>   /**
> ---
> Then, the value passed to newuidmap is still incorrect:
> 
> $ unshare --map-users=100000,0,65536 cat /proc/self/uid_map
> newuidmap: uid range [0-655360) -> [100000-755360) not allowed
> 
> $ unshare --map-users=100000,0,0065536 cat /proc/self/uid_map
>           0     100000      65536
> 
> The count value gets zero-padded to the right at some place I've not pinned down.

It's stack garbage. Try

diff --git i/sys-utils/unshare.c w/sys-utils/unshare.c
index 3cdd90329..5ac7af3de 100644
--- i/sys-utils/unshare.c
+++ w/sys-utils/unshare.c
@@ -385,10 +385,10 @@ struct map_range {
   */
  static int uint_to_id(const char *name, size_t sz)
  {
-       char buf[UID_BUFSIZ];
+       char buf[UID_BUFSIZ] = {0};
  
-       mem2strcpy(buf, name, sz, sizeof(buf));
-       return strtoul_or_err(name, _("could not parse ID"));
+       memcpy(buf, name, min(sz, sizeof(buf) - 1));
+       return strtoul_or_err(buf, _("could not parse ID"));
  }
  
  /**
--

(actually, I have no idea what mem2strcpy is for if it doesn't put the nul-terminator at the end of sz)

> Also, I would suggest adopting the same argument order as in /proc/<pid>/uid_map and newuidmap -- inner,outer,count.

I think this is a rather silly order. Since this is a mapping, the "natural" order is

outer -> inner

and only from the new namespace's PoV is it

inner -> outer

It certainly helped me remember things once I reversed the order...

> This doc string has it reversed:

As noted above, this is intended.

> ---
> /**
>   * struct map_range - A range of IDs to map
>   * @outer: First ID inside the namespace
>   * @inner: First ID outside the namespace
> ---
> 
> And this one has inconsistent terminology:
> ---
>   * get_map_range() - Parse a mapping range from a string
>   * @s: A string of the format upper,lower,count
>   *
>   * Parse a string of the form upper,lower,count into a new mapping range.
> ---

And here you can see that I've been reading too much of shadow's man pages :)

--Sean
