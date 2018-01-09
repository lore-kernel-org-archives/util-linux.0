Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeAIVNT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 9 Jan 2018 16:13:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68C63356E1
        for <util-linux@vger.kernel.org>; Tue,  9 Jan 2018 21:13:19 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [PATCH RFC 1/1] libblkid: Add support for stratis
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20180105171539.5948-1-tasleson@redhat.com>
 <20180105171539.5948-2-tasleson@redhat.com>
 <20180108111614.wd2eueagamfbcsil@ws.net.home>
From: Tony Asleson <tasleson@redhat.com>
Message-ID: <88adc164-c17d-a798-d9bc-23b8649dd5f4@redhat.com>
Date: Tue, 9 Jan 2018 15:13:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180108111614.wd2eueagamfbcsil@ws.net.home>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thank you for the suggestions, v2 patch posted which incorporates them.

Regards,
Tony

On 01/08/2018 05:16 AM, Karel Zak wrote:
> On Fri, Jan 05, 2018 at 11:15:39AM -0600, Tony Asleson wrote:
>> +static int stratis_valid_sb(blkid_probe pr, uint8_t *p)
>> +{
>> +	const struct stratis_sb *stratis = (const struct stratis_sb *)p;
>> +	uint32_t crc = 0;
>> +
>> +	// generate CRC from byte position 4 for length 508 == 512 byte sector
>> +	crc = crc32c(~0L, p + sizeof(stratis->crc32),
>> +			BS - sizeof(stratis->crc32));
>> +	crc ^= ~0L;
>> +
>> +	return blkid_probe_verify_csum(pr, crc, le32_to_cpu(stratis->crc32));
> 
> Not sure that blkid_probe_verify_csum() is a good idea for your
> use-case. 
> 
> The function ignores (returns 1) bad checksums if BLKID_SUBLKS_BADCSUM
> flag is enabled. I guess you want to use second (backup) superblock 
> if the primary one is broken. It would be better to use
> 
>     return crc == le32_to_cpu(stratis->crc32);
> 
> and do not use blkid_probe_verify_csum() at all.
> 
>> +static int probe_stratis(blkid_probe pr,
>> +		const struct blkid_idmag *mag __attribute__((__unused__)))
>> +{
>> +	const struct stratis_sb *stratis = NULL;
>> +	uint8_t *buf = blkid_probe_get_buffer(pr, 0, SB_AREA_SIZE);
>> +
>> +	if (!buf)
>> +		return errno ? -errno : 1;
>> +
>> +	if (stratis_valid_sb(pr, buf + FIRST_COPY_OFFSET)) {
>> +		stratis = (const struct stratis_sb *)(buf + FIRST_COPY_OFFSET);
>> +	} else {
>> +		if (!stratis_valid_sb(pr, buf + SECOND_COPY_OFFSET))
>> +			return 1;
>> +
>> +		stratis = (const struct stratis_sb *)
>> +				(buf + SECOND_COPY_OFFSET);
>> +	}
>> +
>> +	blkid_probe_strncpy_uuid(pr, (unsigned char *)stratis->dev_uuid,
>> +					sizeof(stratis->dev_uuid));
>> +	blkid_probe_set_value(pr, "POOL_UUID",
>> +				(unsigned char *)stratis->pool_uuid,
>> +				sizeof(stratis->pool_uuid));
>> +
>> +	blkid_probe_sprintf_value(pr, "SECTORS", "%" PRIu64, stratis->sectors);
> 
> Hmm... SECTORS sounds pretty generic. Don't forget it will be
> stored in udevd db. Would be possible to use any prefix?
> 
> For example:
> 
>     POOL_SECTORS
> 
>> +	blkid_probe_sprintf_value(pr, "INITIALIZATION_TIME", "%" PRIu64,
>> +					stratis->initialization_time);
> 
>     POOL_INITTIME
> 
> Karel
> 
> 
> 

