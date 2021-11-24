Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07502C433EF
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 02:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhKXCOy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhKXCOw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Nov 2021 21:14:52 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDDC061574
        for <util-linux@vger.kernel.org>; Tue, 23 Nov 2021 18:11:43 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so1174704qtx.10
        for <util-linux@vger.kernel.org>; Tue, 23 Nov 2021 18:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KwKR3eDwVBQtxGQgDS2ik2CTD+iXeYBHl9XIWSXd6Qs=;
        b=UrgxJ8pcdDnwGRrGsjtzuLgKWGsIFswpxME5IDKUiayX4zY2oQBiDrnEIlMCEX+51L
         S29ep+hKFR89zsPYQDb55AqbJ8QPTIghKXMHa0eEpWnTt2tc3bvuf/MT/RZr3Arvno4t
         Ahw6+9XDn+4gU1XbhgGrewcvAqxBCuAV8dHJSnp/UU7TpearSDPTuhwbkC9kA9kPEBnp
         mo6n3i1tmGIwWJt+N7bkDEvdxwiMI7kyCukcW1HmEByQD0YxwG2+i301i+XzPELttQIJ
         b+sV3+TrUdxaY36wM7Mecbb2uQdy3f0RA6UHipYKABRWYU8DfiZVb2Aj6s2EdJByihPH
         tniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KwKR3eDwVBQtxGQgDS2ik2CTD+iXeYBHl9XIWSXd6Qs=;
        b=ZxkBWrUQKp7eKNPQeswoDKpsyRt4FWELHIng1sPv2cX2JxoJlySm3JfNZYileE0Rb9
         QNhN8M7Ct7kJuVu/vI5vYpf0Elhx3rgQe9CEHHNbvTd4+wpGlZ8F0SA43zhrx1dRfnZP
         QEHBniig79hbXx+WPm82c3WyahrHSbvjvJFphdu3RwmCLakCO7086Q0a3hAYW4z3sryE
         gFTxf8KB+pQ0UYGAtWnRMuKBLlZw+YszsAzmIxa7CDv3tHqmAhvJaUY0Bt/ZRSf/EV33
         XfVhUstLsOJEnnQ214WBQnDuItoWfl6E/7Gqq16VmczJdMjAJR7HOsDLPvDEeoc31eMn
         7szg==
X-Gm-Message-State: AOAM532DOhB/q35pWWkkHPLVxtcHXVfNMURtISfaw5hANELAbqK3b2g5
        7CdNphyZq3Ovi2hcvxneUaQ=
X-Google-Smtp-Source: ABdhPJwBoUCmzYm9gxzV+iV8I5CwUijJDLIXB11Nk0tmqY5f3wZeThQWclyuyKZIC1W25acS6m8C2A==
X-Received: by 2002:a05:622a:1a03:: with SMTP id f3mr2641509qtb.141.1637719903247;
        Tue, 23 Nov 2021 18:11:43 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.googlemail.com with ESMTPSA id x17sm7208883qta.66.2021.11.23.18.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 18:11:42 -0800 (PST)
Subject: Re: [PATCH 4/5] unshare: Add option to automatically create user and
 group maps
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>
References: <20211117021038.823851-1-seanga2@gmail.com>
 <20211117021038.823851-5-seanga2@gmail.com>
 <20211123144023.qkhf3xyv4pzihjxc@ws.net.home>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <4b6d2f66-8eb6-8547-fe06-b80c9f9d8e81@gmail.com>
Date:   Tue, 23 Nov 2021 21:11:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20211123144023.qkhf3xyv4pzihjxc@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/23/21 9:40 AM, Karel Zak wrote:
> On Tue, Nov 16, 2021 at 09:10:37PM -0500, Sean Anderson wrote:
>> This option is designed to handle the "garden path" user/group ID
>> mapping:
>>
>> - The user has one big map in /etc/sub[u,g]id
>> - The user wants to map as many user and group IDs as they can,
>>    especially the first 1000 users and groups.
>>
>> The "auto" map is designed to handle this. We find the first map
>> matching the current user, and then map the whole thing to the ID range
>> starting at ID 0.
> 
> ...
> 
>>    * map_ids() - Create a new uid/gid map
>>    * @idmapper: Either newuidmap or newgidmap
>> @@ -571,6 +637,7 @@ static void __attribute__((__noreturn__)) usage(void)
>>   	fputs(_(" --map-group=<gid>|<name>  map current group to gid (implies --user)\n"), out);
>>   	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
>>   	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
>> +	fputs(_(" --map-auto                map users and groups automatically (implies --user)\n"), out);
>>   	fputs(_(" --map-users=<outeruid>,<inneruid>,<count>\n"
>>   		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
>>   	fputs(_(" --map-groups=<outergid>,<innergid>,<count>\n"
> 
> 
> What about to support "auto" as a placeholder too:
> 
>    --map-users=auto
>    --map-groups=auto
> 
> in this case you can select what you want to map (UID/GID)
> automatically.

That sounds good.

>> +		case OPT_MAPAUTO:
>> +			unshare_flags |= CLONE_NEWUSER;
>> +			usermap = read_subid_range("/etc/subuid", real_euid);
>> +			groupmap = read_subid_range("/etc/subgid", real_egid);
>> +			break;
> 
> Please, add _PATH_SUBUID and _PATH_SUBGID to include/pathnames.h. We
> usually do not use paths in the code.

OK. I did not know about that. Will add.

--Sean

