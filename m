Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C05BC433E0
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 22:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF14823128
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 22:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAOW4r (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbhAOW4r (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Jan 2021 17:56:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFA7C061757
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2021 14:56:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q18so10830235wrn.1
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2021 14:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkFwd1wPI/8A5zaH+NRfYnzxzC1rli2VZmR7hCAVdnc=;
        b=AtyBMhTbQoFlU60XdbxbbJGGL+uYtvu2LWunMxUICZaTiNeRWpjUjHJ9AWg5kpRA0w
         4MSRmVa3Dm3DsOopCj0z23SmHt7liGBaxQEiULn2rtO81zDnDlFAYHqre05Uumj5HjAQ
         m+u2N177Oer31H7S1tUT1XhbqlepnOmmtSYwQhBxqPBoH/k39lHnlUGIHKF5zvg38wbr
         fu1zSPgSdjvZxP4qxxwZKkVvnBB1AK/TuacVcxnsnAExk7ncw35fjPGB/0yaC42Z8lnZ
         p7TZj9dRrxNS3ANcy5MMKVSmpawUzp6oZaW2b3kxmWox72gETldvIjFB4MiUOq+b13sE
         B08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkFwd1wPI/8A5zaH+NRfYnzxzC1rli2VZmR7hCAVdnc=;
        b=G1pBg2UVRvfZINZadv7cf2VmZNqP9brorF6VfdITdQ0blwcQRp7/hhZL9OKsWuCGUx
         lDGvUrDXuuxq8GmQT19kakJ9qba5ol6zYtY7SYtvjTkfvatsj/2WSTvcAhGyCtOiJivM
         MMl0hO5JtgXAgw746Z2hrFP14T3dL0h6B84EF/myaU4EmgB00mQomOrLP20BcEbmS5Gl
         SSEcBL+VkqNMoX6qzi2hrTkjsCvNibZXF71YNPjv49hJA9IMOIrFFl/lizMuwcEDXQ/I
         0B/3dqu/W8zFcDFNWxC0dCVngH0S6xGfl5QPKrwsWnYA4/7KJi3XE2iEC1A3sBh+rpVW
         RAdA==
X-Gm-Message-State: AOAM530foG7D91IKHbSo2Y1Ln6NAgMT9hsFKFfdEmudIb5Gf+lxIas8j
        cFJozs4ccH+00Q5fgHCeCHC7TQRVKZrzGQ==
X-Google-Smtp-Source: ABdhPJzoj0mVjLa/1m39RR0NonnyAPtua8P2Lh/1FFJC65oCxdwFq+2yhvO4upR831pa9EVWHia6gw==
X-Received: by 2002:adf:ded1:: with SMTP id i17mr15001813wrn.190.1610751365418;
        Fri, 15 Jan 2021 14:56:05 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id z63sm14499188wme.8.2021.01.15.14.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:56:04 -0800 (PST)
Subject: Re: fsck needs /dev in path to check an ext4 partition
To:     Theodore Ts'o <tytso@mit.edu>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     util-linux@vger.kernel.org
References: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
 <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
 <YAIQXILhhLfRupPY@mit.edu>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <772c9034-01c7-fae5-2420-07526f5fabbe@jguk.org>
Date:   Fri, 15 Jan 2021 22:56:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAIQXILhhLfRupPY@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



On 15/01/2021 21:59, Theodore Ts'o wrote:
> On Fri, Jan 15, 2021 at 09:15:02PM +0100, John Paul Adrian Glaubitz wrote:
>> Hello Jonny!
>>
>> On 1/15/21 9:06 PM, Jonny Grant wrote:
>>> Apologies I am not using 2.36.1 yet. I'm on latest Ubuntu LTS, but it's using 2.34
>>>
>>> I noticed fsck only works if I write as "/dev/sdb1" not just "sdb1" I was in /dev/ as
>>> root, so it shouldn't need long path?
>>>
>>> These work as expected when called from /dev/ as user root
>>>
>>> # fsck.ext4 sdb1  
>>> # fsck.ext4 /dev/sdb1  
>>>
>>> This does not work:
>>> # fsck sdb1
>>
>> That's because it must be:
>>
>> # fsck.ext4 ./sdb1
>>
>> Filenames are expanded by your shell in this case, not by the fsck utilities.
> 
> That's not what is going on --- and it has nothign to do with PATH
> searching.  The way fsck parses its arguments is that it has to
> distinguish between:
> 
> * device names ("/dev/sdb1")
> * label or UUID specifiers (e.g., "LABEL=backup")
> * options to be interpreted by fsck (e.g., "-N")
> * options to be interpreted by the fsck.XXX driver (e.g., "-f")
> * arguments to fsck.XXX's options (e.g.,"discard" in  "-E discard")
> 
> The generic fsck driver doesn't know that for fsck.ext4 (aka e2fsck)
> that -E takes an argument.  So when you run something like "fsck -E
> discard /dev/sdb1", fsck can't distinguish between the file "discard"
> in your current working directory, and passing in multiple devices
> which are designed to be running in parallel, e.g.: "fsck -p /dev/sda3
> /dev/sdb1".
> 
> The bottom line is if you want to pass a pathname to a device, it must
> not be a relative pathname.
> 
> It also means that if you need to pass in an argument to a pathname, e.g.:
> 
> 	/sbin/e2fsck -j /dev/VG/ext-journal /dev/VG/filesystem
> 
> you can't just do something like:
> 
> 	/sbin/fsck -j /dev/VG/ext-journal /dev/VG/filesystem
> 
> since /dev/VG/ext-journal won't be interpreted as an argument to the
> -j option.   You could do something like:
> 
> 	/sbin/fsck /dev/VG/filesystem -- -j /dev/VG/ext-journal
> 
> But honestly, you're probably better just explicitly specifying the
> file system driver specifier (e.g., /sbin/fsck.ext4 or /sbin/e2fsck)
> instead of using the fsck front-end.
> 
> The original use of fsck was so we could run multiple fsck processes
> in parallel.  With distributions which use systemd, the only real
> value which fsck adds is that it will automatically figure out the
> file system type.  But if you're manually running fsck, most of the
> time you know the file system type --- and if you are using filesystem
> type specific option, you really do know the file system type ahead of
> time, so you might as well skip using the fsck front-end.


Thank you for the reply Ted.

I'll stick to using fsck.ext4 directly I think, and the /dev/sdb1 to keep it simple.

Cheers, Jonny
