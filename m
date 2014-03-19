Return-Path: hare@suse.de
Message-ID: <532A04B6.9050706@suse.de>
Date: Wed, 19 Mar 2014 21:57:26 +0100
From: Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] blkid: convert superblocks to new calling convention
References: <1395237056-26595-1-git-send-email-hare@suse.de> <1395237056-26595-3-git-send-email-hare@suse.de> <20140319175541.GB31824@x2.net.home>
In-Reply-To: <20140319175541.GB31824@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

On 03/19/2014 06:55 PM, Karel Zak wrote:
> On Wed, Mar 19, 2014 at 02:50:56PM +0100, Hannes Reinecke wrote:
>> --- a/libblkid/src/partitions/bsd.c
>> +++ b/libblkid/src/partitions/bsd.c
>> @@ -42,14 +42,18 @@ static int probe_bsd_pt(blkid_probe pr, const struct blkid_idmag *mag)
>>   		return 0;
>>
>>   	data = blkid_probe_get_sector(pr, BLKID_MAG_SECTOR(mag));
>> -	if (!data)
>> -		goto nothing;
>> +	if (!data) {
>> +		if (errno)
>> +			goto err;
>> +		else
>> +			goto nothing;
>> +	}
>
>   It would be nice to return the error code (-errno) from the function.
>
>   Maybe you can use something like:
>
>            int rc = 1;   /* default is nothing */
>
>            data = blkid_probe_get_sector(pr, BLKID_MAG_SECTOR(mag));
>            if (!data) {
>                rc = error ? -errno : 1;
>                goto done;
>            }
>
>            ...
>            rc = 0;   /* success, all probing stuff pass */
>
>          done:
>            return rc;
>
>
>   to reduce number of the code lines and number of goto labels and to return the
>   proper return code.
>
>
>>   	ls = blkid_probe_get_partlist(pr);
>>   	if (!ls)
>> -		goto err;
>> +		goto nothing;
>
>   hmm.. it usually means malloc() error, I have doubts we want to
>   ignore such errors, it would be probably better to return -ENOMEM
>   in this case.
>
>       if (!ls) {
>          rc = -ENOMEM;
>          goto done;
>       }
>
>   If you do the cleanup then do it for all errors, not for I/O only ;-)
>
Errm.

Before I attempt this the codebase needs some in-depth cleanup.
Main problem here is the inconsistent usage of -1, 0, and 1.
The ->probefunc functions use 0 to signal 'not found',

partitions_probe uses the inverse, namely '0' signals found.

And so on and so forth.

Plus there are even some vestiges of an attempted error code
handling; BLKID_ERR_* are used occasionally.

It would be good if one could agree on a common strategy here,
and audit the code base to adhere to this.
Once that is done we can work on returning correct error codes.

But without that prior step it's virtually impossible.

I would vote for reversing the return values of 'partitions_probe', and 
auditing the code further up. Hope is that this will be less coding.
Alternatively we could inverse the probefunc() callbacks, seeing that 
this patch touches them anyway.

What do you prefer?

Cheers,

Hannes


>> +		if (!data) {
>> +			if (errno)
>> +				goto err;
>> +			else
>> +				goto leave;	/* malformed partition? */
>> +		}
>
>    BTW, "else" after "goto" is probably unnecessary, just
>
>      if (foo)
>          goto y;
>      goto x;
>
>    Karel
>
