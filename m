Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24986 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757805Ab2DJKim (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 06:38:42 -0400
Date: Tue, 10 Apr 2012 12:38:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] lib: random utilities
Message-ID: <20120410103838.GK19784@x2.net.home>
References: <1333662724.2696.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333662724.2696.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 11:52:04PM +0200, Davidlohr Bueso wrote:
v> +/*
> + * Generate a stream of random nbytes into buf.
> + * Use /dev/urandom if possible, and if not,
> + * use glibc pseudo-random functions.
> + */
> +void random_get_bytes(void *buf, int nbytes)
> +{
> +	int i, n = nbytes, fd = random_get_fd();
> +	int lose_counter = 0;
> +	unsigned char *cp = (unsigned char *) buf;
> +
> +	if (fd >= 0) {
> +		while (n > 0) {
> +			i = read(fd, cp, n);
> +			if (i <= 0) {
> +				if (lose_counter++ > 16)
> +					break;
> +				continue;
> +			}
> +			n -= i;
> +			cp += i;
> +			lose_counter = 0;
> +		}
> +	}
> +
> +	/*
> +	 * We do this all the time, but this is the only source of
> +	 * randomness if /dev/random/urandom is out to lunch.
> +	 */
> +	for (cp = buf, i = 0; i < nbytes; i++)
> +		*cp++ ^= (rand() >> 7) & 0xFF;
> +
> +#ifdef DO_JRAND_MIX
> +	{
> +		unsigned short tmp_seed[3];
> +
> +		memcpy(tmp_seed, jrand_seed, sizeof(tmp_seed));
> +		jrand_seed[2] = jrand_seed[2] ^ syscall(__NR_gettid);
> +		for (cp = buf, i = 0; i < nbytes; i++)
> +			*cp++ ^= (jrand48(tmp_seed) >> 7) & 0xFF;
> +		memcpy(jrand_seed, tmp_seed,
> +		       sizeof(jrand_seed)-sizeof(unsigned short));
> +	}
> +#endif

    close(fd);
> +
> +	return;
> +}

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
