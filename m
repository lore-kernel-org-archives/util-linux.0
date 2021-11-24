Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B600C433EF
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 02:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhKXCNj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbhKXCNi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 Nov 2021 21:13:38 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440C7C061574
        for <util-linux@vger.kernel.org>; Tue, 23 Nov 2021 18:10:29 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id m17so661245qvx.8
        for <util-linux@vger.kernel.org>; Tue, 23 Nov 2021 18:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rmSB4xP+3q7010TW+M6AZLaYkEF99DgyA6Cbr21+8g4=;
        b=hb4q9tK2Dr/5hyRwgv5gJf+67wbcshkr6/6hF6DzELwFbvpvphweKXlhy2xNAtOSPF
         lNNBABG2rx5z5b/08DueOEKeQ1mpNuPdX1uJ4JQrilT4CqsdQ3PhD1d6RJKRRImDcOQy
         NAKv1wfhuwc4BDemU9lwqyIZwavh/LiPq5ylJ1HZYtkyzHAHo0c6v2E4Skcyhq7gNa25
         BoccQfdF6+tF+qPk3+mcbuAVs6DP+Tmpi5gHhdxcIFMtuxG5IotBVPsDSje60W2xlhJb
         EqDOqsxBg9EJCS9DL9ziEA5sxeE7G5W6Rj5xykwCiAQDONrZVFAMMES07aAhS82/FDoA
         K1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rmSB4xP+3q7010TW+M6AZLaYkEF99DgyA6Cbr21+8g4=;
        b=QtAcJK9BP8IzTL6bPtc7ektIGPLaN7V150Q7sE6GRoHI+5ke4UqJgXJDNf+melUq/c
         Is2uMH27iWfpVEvBCs6qD9NvOOdDYpydIlKywqFPH8FQA7pRoiTMIzSXpoz2ROaS0Nox
         wSbIvcpzJve11wmX1mDfFQORiPvLPZIErcgdxYtW2xTRDcKU4CLt0xWI3nd6nRu/vVZI
         JL5VdbhZGq/Nw9nDCobN+nVYHpohwT82VeqfT7KOk0ehf5npDf6Tzz+KIN7OWxXe/pF1
         ROi4iAiVu2T7OhZnQx+Gkpcgfs0tJWY8LpRe0z4/UJbgc+t24VcEL6f4gj5YtA/jgKn1
         7Fqg==
X-Gm-Message-State: AOAM533W6IzpnCZLmqazZlVRYeqMWgGTEruoFvzQgoephwQaN6Jtzkc/
        Cm3+LWWI+OIbDXOvgJkL7rqVnXRacBY=
X-Google-Smtp-Source: ABdhPJwexP1DYFVN02Tqzd5EDu/162Hugy095AHTUmWQkuZKbWbHcCmhsNT9IBs3eAKTFcKi8fvEMQ==
X-Received: by 2002:a0c:f942:: with SMTP id i2mr2380692qvo.51.1637719828462;
        Tue, 23 Nov 2021 18:10:28 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.googlemail.com with ESMTPSA id x16sm4760263qko.15.2021.11.23.18.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 18:10:28 -0800 (PST)
Subject: Re: [PATCH 3/5] unshare: Add options to map blocks of user/group IDs
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>
References: <20211117021038.823851-1-seanga2@gmail.com>
 <20211117021038.823851-4-seanga2@gmail.com>
 <20211123143315.24wzvurbtgnuklnu@ws.net.home>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <73aeddbe-e167-f246-2dfd-930408ac38ee@gmail.com>
Date:   Tue, 23 Nov 2021 21:10:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20211123143315.24wzvurbtgnuklnu@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/23/21 9:33 AM, Karel Zak wrote:
> 
>   Hi Sean,
> 
> the patches looks pretty good, some notes:
> 
> 
> On Tue, Nov 16, 2021 at 09:10:36PM -0500, Sean Anderson wrote:
>> +static int uint_to_id(const char *cname, size_t sz)
>> +{
>> +	char old, *name = (char *)cname;
> 
> I'm not sure with this, it uses "const char" for good reason. It's
> usually better to not touch process argv[].

*shrug* no one else is using it :)

>> +	unsigned long ret;
>> +
>> +	/* Add a NUL-terminator */
>> +	old = name[sz];
>> +	name[sz] = '\0';
>> +	ret = strtoul_or_err(name, _("could not parse ID"));
>> +	if (ret > UINT_MAX)
>> +		errx(EXIT_FAILURE, "id %lu is too big", ret);
>> +	/* And put back the old value to preserve const-ness */
>> +	name[sz] = old;
>> +	return ret;
>> +}
> 
> I think we can keep it simple and robust:
> 
> #define UID_BUFSIZ  sizeof(stringify_value(ULONG_MAX))

That's a nice trick

> static int uint_to_id(const char *cname, size_t sz)
> {
>      char buf[UID_BUFSIZ];
>      unsigned long id;
> 
>      mem2strcpy(buf, cname, sz, sizeof(buf));
>      id = strtoul_or_err(buf, _("could not parse ID"));
>      return id;
> }

Ok, this looks good.

>> +/**
>> + * map_ids() - Create a new uid/gid map
>> + * @idmapper: Either newuidmap or newgidmap
>> + * @ppid: Pid to set the map for
>> + * @outer: ID outside the namespace for a single map.
>> + * @inner: ID inside the namespace for a single map. May be -1 to only use @map.
>> + * @map: A range of IDs to map
>> + *
>> + * This creates a new uid/gid map for @ppid using @idmapper. The ID @outer in
>> + * the parent (our) namespace is mapped to the ID @inner in the child (@ppid's)
>> + * namespace. In addition, the range of IDs beginning at @map->outer is mapped
>> + * to the range of IDs beginning at @map->inner. The tricky bit is that we
>> + * cannot let these mappings overlap. We accomplish this by removing a "hole"
>> + * from @map, if @outer or @inner overlap it. This may result in one less than
>> + * @map->count IDs being mapped from @map. The unmapped IDs are always the
>> + * topmost IDs of the mapping (either in the parent or the child namespace).
>> + *
>> + * Most of the time, this function will be called with @map->outer as some
>> + * large ID, @map->inner as 0, and @map->count as a large number (at least
>> + * 1000, but less than @map->outer). Typically, there will be no conflict with
>> + * @outer. However, @inner may split the mapping for e.g. --map-current-user.
>> + *
>> + * This function always exec()s or errors out and does not return.
>> + */
>> +static void __attribute__((__noreturn__))
>> +map_ids(const char *idmapper, int ppid, unsigned int outer, unsigned int inner,
>> +	struct map_range *map)
>> +{
>> +	/* idmapper + pid + 4 * map + NULL */
>> +	char *argv[15];
>> +	/* argv - idmapper - "1" - NULL */
>> +	char args[12][16];
> 
> May be we can minimize magic constants and use some readable macro here, what about:
> 
> args[12][UID_BUFSIZ]

Sure.

>> +	int i = 0, j = 0;
>> +	struct map_range lo, mid, hi;
>> +	unsigned int inner_offset, outer_offset;
>> +
>> +	/* Some helper macros to reduce bookkeeping */
>> +#define push_str(s) do { \
>> +	argv[i++] = s; \
>> +} while (0)
>> +#define push_ul(x) do { \
>> +	snprintf(args[j], 16, "%u", x); \
> 
> snprintf(args[j], UID_BUFSIZ, "%u", x);
> 
>> +	push_str(args[j++]); \
>> +} while (0)
> 
> ...
> 
>> +/**
>> + * map_ids_from_child() - Set up a new uid/gid map
>> + * @child: The PID of the child process
>> + * @fd: The eventfd to send our PID over
>> + * @mapuser: The user to map the current user to (or -1)
>> + * @usermap: The range of UIDs to map (or %NULL)
>> + * @mapgroup: The group to map the current group to (or -1)
>> + * @groupmap: The range of GIDs to map (or %NULL)
>> + *
>> + * Fork (to pid @child) and wait for a message on @fd. Upon recieving this
>> + * message, use newuidmap and newgidmap to set the uid/gid map for our parent's
>> + * PID.
>> + */
>> +static void map_ids_from_child(pid_t *child, int *fd, uid_t mapuser,
>> +			       struct map_range *usermap, gid_t mapgroup,
>> +			       struct map_range *groupmap)
>> +{
>> +	pid_t pid = 0;
>> +	pid_t ppid = getpid();
>> +	uint64_t ch;
>> +
>> +	*fd = eventfd(0, 0);
>> +	if (*fd < 0)
>> +		err(EXIT_FAILURE, _("eventfd failed"));
>> +
>> +	*child = fork();
>> +	if (*child < 0)
>> +		err(EXIT_FAILURE, _("fork failed"));
>> +	if (*child)
>> +		return;
>> +
>> +	/* wait for the our parent to call unshare() */
>> +	if (read_all(*fd, (char *)&ch, sizeof(ch)) != sizeof(ch) ||
>> +	    ch != PIPE_SYNC_BYTE)
>> +		err(EXIT_FAILURE, _("failed to read eventfd"));
>> +	close(*fd);
>> +
>> +	/* Avoid forking more than we need to */
>> +	if (usermap && groupmap) {
>> +		pid = fork();
>> +		if (pid < 0)
>> +			err(EXIT_FAILURE, _("fork failed"));
>> +		if (pid)
>> +			waitchild(pid);
>> +	}
> 
> I like the idea with eventfd(). What about to use it also in
> bind_ns_files_from_child()? Now we use pipe() here.
> 
> It seems we can consolidate the code and add small functions
> like
> 
>   sync_with_parent()
>   sync_with_child()
> 
> to hide SYNC_BYTE read(), write() and waitchild().

OK. I will look into converting the pipe user as well.

>   ...
> 
>> @@ -413,13 +652,16 @@ int main(int argc, char *argv[])
>>   	int c, forkit = 0;
>>   	uid_t mapuser = -1;
>>   	gid_t mapgroup = -1;
>> +	struct map_range *usermap = NULL;
>> +	struct map_range *groupmap = NULL;
>>   	int kill_child_signo = 0; /* 0 means --kill-child was not used */
>>   	const char *procmnt = NULL;
>>   	const char *newroot = NULL;
>>   	const char *newdir = NULL;
>> -	pid_t pid_bind = 0;
>> +	pid_t pid_bind = 0, pid_idmap = 0;
>>   	pid_t pid = 0;
>>   	int fds[2];
>> +	int efd;
> 
> int fd_idmap, fd_bind;
> 
> 
>   Karel
> 

Thanks for the review.

--Sean
