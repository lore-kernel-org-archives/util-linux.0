Return-Path: hare@suse.de
Message-ID: <5329FC1B.9050706@suse.de>
Date: Wed, 19 Mar 2014 21:20:43 +0100
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] blkid: stop scanning on I/O error
References: <1395237056-26595-1-git-send-email-hare@suse.de> <1395237056-26595-2-git-send-email-hare@suse.de> <20140319173819.GA31824@x2.net.home>
In-Reply-To: <20140319173819.GA31824@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 03/19/2014 06:38 PM, Karel Zak wrote:
> On Wed, Mar 19, 2014 at 02:50:55PM +0100, Hannes Reinecke wrote:
>> @@ -794,6 +801,8 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
>>   		off = (mag->kboff + (mag->sboff >> 10)) << 10;
>>   		buf = blkid_probe_get_buffer(pr, off, 1024);
>>
>> +		if (!buf && errno)
>> +			return -1;
>
>              return -errno;
>
Hmm. Okay; but then I'll need to audit the callers.

>>   		if (buf && !memcmp(mag->magic,
>>   				buf + (mag->sboff & 0x3ff), mag->len)) {
>>   			DBG(LOWPROBE, blkid_debug("\tmagic sboff=%u, kboff=%ld",
>> diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
>> index c6394c4..35cfd50 100644
>> --- a/libblkid/src/superblocks/superblocks.c
>> +++ b/libblkid/src/superblocks/superblocks.c
>> @@ -379,15 +379,22 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
>>
>>   		DBG(LOWPROBE, blkid_debug("[%zd] %s:", i, id->name));
>>
>> -		if (blkid_probe_get_idmag(pr, id, &off, &mag))
>> +		rc = blkid_probe_get_idmag(pr, id, &off, &mag);
>> +		if (rc < 0)
>> +			break;
>> +		if (rc > 0)
>>   			continue;
>>
>>   		/* final check by probing function */
>>   		if (id->probefunc) {
>>   			DBG(LOWPROBE, blkid_debug("\tcall probefunc()"));
>> -			if (id->probefunc(pr, mag) != 0) {
>> +			rc = id->probefunc(pr, mag);
>> +			if (rc != 0) {
>>   				blkid_probe_chain_reset_vals(pr, chn);
>> -				continue;
>> +				if (rc < 0)
>> +					break;
>> +				else
>> +					continue;
>>   			}
>>   		}
>
> The function superblocks_probe() has to return 'rc' (now after the
> loop break it returns 1), otherwise the errors will be invisible for
> superblocks_safeprobe().
>
Okay, fixed.

> The errors has to be propagated to top level function (probe.c
> blkid_do_probe(), blkid_do_safeprobe(), etc).
>
That's already taken care of; the current code allows for this.

Cheers,

Hannes
