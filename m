Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF128399
	for <util-linux@vger.kernel.org>; Sat, 25 Jan 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737818405; cv=none; b=odvKVmEYIBNx1ru+goNF9YGGXZ7RK0L58eKtulPIQIqrIPWDq1dxS3heKHK3lAQc1e5oUhNOqEi++nPA9/4hFMSeWHJi2IKw+ma+AD9QFxbILgzXTWViwazEwPuQGyr3bWaKWy83a4NPL3jFTAUGbfNLqWbkknvS8ExFBRoLEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737818405; c=relaxed/simple;
	bh=+q/sAAUvgc9bWiqBwjTxJfSM3+wydGCHWzB+jYwgtNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epIwJSySC9VHRhCX2qVViug0tx0GTRWhG9I/46vu719+DaDSlAdNpm2J6V90olMG4vBrkw4l6YhJKI86zSDT69I7qybu4DslW78+cQgZ88/dGHk7Rni1hyuCRFf2fbg2nLy2qIVIXRtiVgg7v+FfQJGeHy5QS0duVDS65z3dKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa7W2uJu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa7W2uJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C993C4CED6;
	Sat, 25 Jan 2025 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737818404;
	bh=+q/sAAUvgc9bWiqBwjTxJfSM3+wydGCHWzB+jYwgtNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa7W2uJuOXe2RHxSvvj4mfgnD2eJO7C18s9Ap4jxZCj1SZG/MBs8SJJRuLyzrhCSH
	 6K29cdYOgrXE0l3Y0uNw8DeB2yzPYXJZnEF+a/eVo3oBF5jMo6JnOwTJhU+meHQTu9
	 bFwX9vaX9lgFsRkUER6RphxmwmU1w/GjibVZsAnZfmV7tMXYL0uZkpsZfB5q75+qCV
	 T8ZyJnUfXNpeLvSYW2ISqja+2iSeERYzPh9QWCGySa6vsOrIEl9cMtl5JQgNI6I222
	 iiRPrM35NfzlXi6D0BsEPWRNlNVy+F24PP9RI+9Y2GiNKuwGlrUDJBgPib2v20Alef
	 NpHHb/fTg4zMw==
Date: Sat, 25 Jan 2025 23:19:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: util-linux@vger.kernel.org, xiang@kernel.org,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH V2] blkid: allow up to 64k erofs block sizes
Message-ID: <Z5UBH6G7Af9QyqZx@debian>
References: <71d43b45-9d53-48a1-8751-7080e50937e9@redhat.com>
 <e0eb2d1f-48fd-4d2b-b087-20a87b396218@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0eb2d1f-48fd-4d2b-b087-20a87b396218@redhat.com>

On Fri, Jan 24, 2025 at 08:37:12AM -0600, Eric Sandeen wrote:
> Today, mkfs.erofs defaults to page size for block size, but blkid
> does not recognize this. Increase the limit to 64k.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
