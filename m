Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C64C04AA7
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EBD2084E
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 16:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVI3QuOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfEMQEx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 12:04:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44964 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbfEMQEx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 May 2019 12:04:53 -0400
Received: by mail-ot1-f65.google.com with SMTP id g18so12023565otj.11
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f7tXtr5+q2lkwFNW9YXOJ3pGMtAU1IthzbY20cD0NWg=;
        b=iVI3QuOvN+4WK+P8dbCq+ocGpYifTPafL+3g64rzHZK0hw5tjp4LuA9hn2JFzvyJFl
         JMiEpiPLcQpPgUjg6/JB0azzpsbgqJNKsHTClr7gg0BqfU1aWmI0HAOo2jroBm7sxz1N
         RbUj5cRuKWXkeYtHOtftmR4CbSi8JWoa0Jidhm6yosGBmYbyjrd64TgY2/ZWVm+Fsph4
         tt3tgrt/fMzyDD8COKAPSNmwEGGfy2eG/veP1+ssbGaQ+US94eR0ilCHhwbJ+Kz/FFGE
         MyROVxfYjB/SiCXBC/Mw+QIIBARjLOppBv+G8NWKiaueb7FSuljf+DBLcTC54VVddZP5
         CMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f7tXtr5+q2lkwFNW9YXOJ3pGMtAU1IthzbY20cD0NWg=;
        b=fbqfrwFjK4Qja5TjZxWOrJNHsr/hIwL3YFHeeqJ+RPluliwSWAhdiSWOF+bJg2QhTq
         GKmRApdb8F3vjJCTr6/f2U5YDLej3p0CyZrsyPB9Y6nk4n9D9UF7EhjJw4LCfogOmxhw
         5EPkv0BAqGSoIK5bkbvUnslybZavTVhKYx7skWz9LpkqoenqQ1zicetARGisNmp/c13S
         uusu+KF1qKR/EqsoaJyktXpypJ70/JT0pja+wTZ4XiZn7py5dp0mvSvA7VHvSa1wLUoN
         0vd50tQL4FGlCFLy2ZSocMLYYNKenwwK/SuKIa3F4lNeAZ4kpQsZskowLYxgpAbEV1UT
         qh3w==
X-Gm-Message-State: APjAAAXo+9bt2WuItzgkkcxqq1Dzea+ob00NtPSF3aVi2aH8uUWkAlPF
        1gL5SGS0i+7fDREtNT8LB/x4PEh+
X-Google-Smtp-Source: APXvYqzpsClqhecAJ6ga5el4g4Fh/HC6jt6z/PaQO5kuofIlwRdj/Utt7+OFHY1u0gawkJoAQynyuA==
X-Received: by 2002:a9d:3f05:: with SMTP id m5mr17859712otc.59.1557763492394;
        Mon, 13 May 2019 09:04:52 -0700 (PDT)
Received: from [192.168.0.84] (cpe-70-123-227-116.satx.res.rr.com. [70.123.227.116])
        by smtp.gmail.com with ESMTPSA id q9sm3802912otf.1.2019.05.13.09.04.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 09:04:51 -0700 (PDT)
Subject: Re: Using the upcoming fsinfo()
To:     Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>
Cc:     util-linux@vger.kernel.org
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
 <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <75f27b68-52ff-7f6b-b031-0637ba04df2f@gmail.com>
Date:   Mon, 13 May 2019 11:04:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/13/19 4:08 AM, Karel Zak wrote:
> On Mon, May 13, 2019 at 01:33:22PM +0800, Ian Kent wrote:
>> Some of you may know that David Howells is working on getting
>> a new system call fsinfo() merged into the Linux kernel.
>>
>> This system call will provide access to information about mounted
>> mounts without having to read and parse file based mount tables
>> such as /proc/self/mountinfo, etc.
>>
>> Essentially all mounts have an id and one can get the id of a
>> mount by it's path and then use that to obtain a large range
>> of information about it.
>>
>> The information can include a list of mounts within the mount
>> which can be used to traverse a tree of mounts or the id used
>> to lookup information on an individual mount without the need
>> to traverse a file based mount table.
>>
>> I'd like to update libmount to use the fsinfo() system call
>> because I believe using file based methods to get mount
>> information introduces significant overhead that can be
>> avoided.
>>
>> Because the fsinfo() system call provides a very different way
>> to get information
>> about mounts, and having looked at the current
>> code, I'm wondering what will be
>> the best way to go about it.
>>
>> Any suggestions about the way this could best be done, given
>> that the existing methods must still work, will be very much
>> appreciated.
> 
> It would be nice to start with some low-level things to read info
> about a target (mountpoint) into libmnt_fs, something like:
> 
>      int mnt_fsinfo_fill_fs(chat char *tgt, struct libmnt_fs *fs)
> 
> and fill create a complete mount table by fsinfo():
> 
>      int mnt_fsinfo_fill_table(struct libmnt_table *tab)
> 
> ... probably add fsinfo.c to code to keep it all together.
> 
> So, after then we can use these functions in our code.
> 
> The nice place where is ugly overhead with the current mountinfo is
> context_umount.c code, see lookup_umount_fs() and
> mnt_context_find_umount_fs(). In this code we have mountpoint and we
> need more information about it (due to redirection to umount.<type>
> helpers, userspace mount options, etc.). It sounds like ideal to use
> mnt_fsinfo_fill_fs() if possible.
> 
> The most visible change will be to use mnt_fsinfo_fill_table() with in
> mnt_table_parse_file() if the file name is "/proc/self/mountinfo".
> This will be huge improvement as we use this function in systemd on
> each mount table change...
> 
> The question is how easily will be to replace mountinfo with fsinfo().

I may be stating the obvious, but this proposal does not appear to 
simplify anything because it is kernel version dependent.  From what I 
understand, the new and old methods will both need to be supported for 
quite some time.

I'm not suggesting that the changes not be made, but I suggest going slow.

   -- Bruce
