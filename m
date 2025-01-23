Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356341487ED
	for <util-linux@vger.kernel.org>; Thu, 23 Jan 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674561; cv=none; b=kPJt7yIZ//uSgnqevQkpLYLGORYb5HxeZ6sI+7Kz6mx4SYzD2bXVlwD04NzTHdrUYAstS8CuZHivEil3HvedWSK+Eim1EfFP2cH5otsMoJ9ZWtYMSB/lGT1BAKhZSylG5L8SlSyzqNX1SkZfzodbsrZZzq3K4kxXclsJCK2pRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674561; c=relaxed/simple;
	bh=cACo4cmNVDYLwdebUSinmPI9SnOm/hUQbZDoceU4fB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5xKiF2vH4xaKNX9b1/kPgC6eFZ0Qt0AgjzxHz3aof0rTD6UNNQPXvFIUB+bamYhws4YZ0mPgiW1cJlk67DZ20RYQmdbvLPnQEzi7HRHkeXjUtRLNF6sgn3a2z7WOrwncix60ot79HciXwVbMdvvii0/KSz/H03gHh9YKNK2taQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+Gr2dWv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+Gr2dWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D7C4CED3;
	Thu, 23 Jan 2025 23:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737674560;
	bh=cACo4cmNVDYLwdebUSinmPI9SnOm/hUQbZDoceU4fB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+Gr2dWvDgfpT8m+G0TNwixAGmH7SYmJEtRDkzSrzTDW1ATGcsJWA+PVF3D2aFfUv
	 u79X+6fghdLh1BC37/LciXo46H4sQJZ1rNIdqPOZATNuNUVFwOOaPpijoHd/arx0yW
	 TFllL6kYxHObWIp9MegRBDRyFllE9Lhy2XoJKTccRqMJwfAcGqq3u8kbaA3bZ8TlhH
	 yNy+3fli51VHaul2oLfReOJ8y6nsKOID9uQy3whCessyZFut86DlotFdYS7Sv6lzUQ
	 Mp743ZiOOaikb58csYfZQkpOurUbpvEG9VLiLxQL0la0iGOqJJIAT3/Y02kkO4mzCx
	 VXutMShQVTeaA==
Date: Fri, 24 Jan 2025 07:22:36 +0800
From: Gao Xiang <xiang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: util-linux@vger.kernel.org, xiang@kernel.org,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] blkid: allow up to 64k erofs block sizes
Message-ID: <Z5LPPNtOD3DqplCt@debian>
References: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>

Hi Eric,

On Thu, Jan 23, 2025 at 01:17:10PM -0600, Eric Sandeen wrote:
> Today, mkfs.erofs defaults to page size for block size, but blkid
> does not recognize this. Increase the limit to 64k.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> (There might be strange arches out there > 64k but I don't know if
> erofs really works with blocks that big, so for now let's just
> limit it to 64k?)
> 
> diff --git a/libblkid/src/superblocks/erofs.c b/libblkid/src/superblocks/erofs.c
> index 05822460b..89620db47 100644
> --- a/libblkid/src/superblocks/erofs.c
> +++ b/libblkid/src/superblocks/erofs.c
> @@ -73,8 +73,8 @@ static int probe_erofs(blkid_probe pr, const struct blkid_idmag *mag)
>  	if (!sb)
>  		return errno ? -errno : BLKID_PROBE_NONE;
>  
> -	/* EROFS is restricted to 4KiB block size */
> -	if (sb->blkszbits > 31 || (1U << sb->blkszbits) > 4096)
> +	/* block size must be between 512 and 64k */
> +	if (sb->blkszbits > 31 || (1U << sb->blkszbits) > 65536)

I think it should be

	if (sb->blkszbits < 9 || ..

?

Also (1U << sb->blkszbits) might be overflowed, so just use
sb->blkszbits > 16.

Otherwise it looks good to me.

Thanks,
Gao Xiang

>  		return BLKID_PROBE_NONE;
>  
>  	if (!erofs_verify_checksum(pr, mag, sb))
> 
