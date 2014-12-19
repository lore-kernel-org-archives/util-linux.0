Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Fri, 19 Dec 2014 09:24:04 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] mkfs.cramfs: fix unsigned integer overflow
 [AddressSanitizer]
In-Reply-To: <20141208113706.GD19904@x2.net.home>
Message-ID: <alpine.LNX.2.03.1412190920440.8955@iki.fi>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <1417355862-16935-8-git-send-email-kerolasa@iki.fi> <20141208113706.GD19904@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Mon, 8 Dec 2014, Karel Zak wrote:

> On Sun, Nov 30, 2014 at 01:57:39PM +0000, Sami Kerola wrote:
>> --- a/disk-utils/mkfs.cramfs.c
>> +++ b/disk-utils/mkfs.cramfs.c
>> @@ -619,7 +619,10 @@ do_compress(char *base, unsigned int offset, unsigned char const *name,
>>  	/* TODO: Arguably, original_size in these 2 lines should be
>>  	   st_blocks * 512.  But if you say that, then perhaps
>>  	   administrative data should also be included in both. */
>> -	change = new_size - original_size;
>> +	if (new_size <= original_size)
>> +		change = new_size - original_size;
>> +	else
>> +		change = new_size;
>
> Is it correct?
>
>>  	if (verbose)
>>  		printf(_("%6.2f%% (%+ld bytes)\t%s\n"),
>>  		       (change * 100) / (double) original_size, change, name);
>
> The verbose message reports difference between old and new size (in
> {+,-} bytes) Your patch use complete new_size if this number is bigger
> that original_size.

I think the size should be bigger. The following is added to the commit 
message.

-- snip
The original_size should be in 512 bytes blocks but it isn't while the 
new_size is using 512 bytes blocks.  When original_size size is smaller 
then 512 the new_size grows rather than shrinks, what one usually would 
expect after data compression.  See also TODO comment near the change.
-- snip

Karel, if in doubt drop this patch and I'll try come up with something by 
the time of asan3 series (not any time soon, first we need travis to 
update clang).

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
