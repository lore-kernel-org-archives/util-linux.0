Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9634A1E0E14
	for <util-linux@vger.kernel.org>; Tue, 16 Dec 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890523; cv=none; b=WPsQ/KqVMbOex3MB6UNbLwJBLIkdykcT/ZqidpUgqXkn0bgWU6MSn3cDZubMFzfzQqMuwQVaOUbJC/JRkYxgAb8yOq81ci391BOdoidQB8rOlrC7e/MGV576GIA/DzDx945vmnAdni2UQTKpkrpW6XXlW/2VLNds1rGz/fATVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890523; c=relaxed/simple;
	bh=N2JZPmoUAbRzbQESfhV4rP4T5KHTGMATbXCvMhZC5Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbMilSbdsjBrz07MPRTOckKW/LcdavubeEE7ou03kYJmFBUmL6AJmelYGIcQXQfwk1eIFBIUUn08GY1FOK1MXmgEx8I8ojGsfqmT2W23xvl/UgMUOzWvt7aBo7BfZ/ppdZhdkQw2dBd+8BV6uC5GjKHE6TwrFw8eLFOplINwnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=gy4gd6oL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="gy4gd6oL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1765890519; bh=N2JZPmoUAbRzbQESfhV4rP4T5KHTGMATbXCvMhZC5Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gy4gd6oLt+oljOMXpUF4YFOuCVY9epagsXKk1ELzjhrr2KuDiiX9Ci3cnd+ejcE5W
	 PJMpA+dg3ZOl7rPD6cOzNqpEdO4CpjgbE1cljSwz0rTUoySFy1wHKb+t6lrJNjYpwg
	 mGlYxhDsr/rn/O0sHnwunx+smkl9D7JuXj6Y5kXs=
Date: Tue, 16 Dec 2025 14:08:36 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
Message-ID: <5a20c5ee-b56c-472e-94a2-c7223c281b3e@t-8ch.de>
References: <20251213200410.31256-1-kiranrangoon0@gmail.com>
 <20251214010108.29535-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251214010108.29535-1-kiranrangoon0@gmail.com>

On 2025-12-13 20:01:08-0500, Kiran Rangoon wrote:
> gregorian_to_unix now returns -1 and sets errno=EOVERFLOW
> for timestamps before the Unix epoch. uuid_time_v1 and uuid_time_v6
> now use signed arithmetic to prevent unsigned wraparound.
> 
> This fixes uuidparse displaying far-future dates for historical UUIDs.
> 
> The regression test has been updated to show actual result instead of hardcoded wrong
> date.

Thanks!

> 
> Example output:
>     $ ./build/uuidparse bf2eb110-d788-1003-aa59-ce1e9e293641
> Before:
>     60041-08-13 16:41:36,271592-04:00
> After:
>     1969-12-31 19:00:00,000000-05:00
> 
> Handling negative timestamps gracefully would require broader changes,
> so I’ve kept this patch focused on preventing pre-1970 wraparound.

IMO we should to this properly. Is this something you want to work on?

> Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
> ---
>  libuuid/src/uuid_time.c       | 15 +++++++++++----
>  tests/expected/uuid/uuidparse |  2 +-
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
> index c7516152b..f0d2c8f36 100644
> --- a/libuuid/src/uuid_time.c
> +++ b/libuuid/src/uuid_time.c
> @@ -60,15 +60,22 @@
>  /* prototype to make compiler happy */
>  time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
>  
> -static uint64_t gregorian_to_unix(uint64_t ts)
> +static int64_t gregorian_to_unix(uint64_t ts)
>  {
> -	return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
> +    const uint64_t offset = 0x01B21DD213814000ULL;
> +
> +    if (ts < offset) {
> +        errno = EOVERFLOW;
> +        return -1;

The callers do not check for errors. Instead this gets converted to the
epoch only by chance.

> +    }
> +
> +    return ts - offset;
>  }
>  
>  static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
>  {
>  	uint32_t high;
> -	uint64_t clock_reg;
> +	int64_t clock_reg;
>  
>  	high = uuid->time_mid | ((uuid->time_hi_and_version & 0xFFF) << 16);
>  	clock_reg = uuid->time_low | ((uint64_t) high << 32);
> @@ -80,7 +87,7 @@ static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
>  
>  static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
>  {
> -	uint64_t clock_reg;
> +	int64_t clock_reg;
>  
>  	clock_reg = uuid->time_low;
>  	clock_reg <<= 16;
> diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidparse
> index 9edb05e4e..0f521a760 100644
> --- a/tests/expected/uuid/uuidparse
> +++ b/tests/expected/uuid/uuidparse
> @@ -11,7 +11,7 @@ UUID                                  VARIANT   TYPE       TIME
>  00000000-0000-3000-8000-000000000000  DCE       name-based 
>  00000000-0000-4000-8000-000000000000  DCE       random     
>  00000000-0000-5000-8000-000000000000  DCE       sha1-based 
> -00000000-0000-6000-8000-000000000000  DCE       time-v6    60038-03-11 05:36:10,955161+00:00
> +00000000-0000-6000-8000-000000000000  DCE       time-v6    1970-01-01 00:00:00,000000+00:00

If it is an error, the output should be empty.

>  00000000-0000-0000-d000-000000000000  Microsoft            
>  00000000-0000-1000-d000-000000000000  Microsoft            
>  00000000-0000-2000-d000-000000000000  Microsoft            
> -- 
> 2.47.3
