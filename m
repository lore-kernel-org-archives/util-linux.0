Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BDB1B415F
	for <util-linux@vger.kernel.org>; Fri, 28 Mar 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158705; cv=none; b=rfHpM7BRN+F8GG6+ffbH/a2knqhLmyOOdT5L7p2sZAw13i2TdhbPEH9+OlkU5hQoPOitBeyV9uMv38X0n/N3wZ6XSIaRERFMw6SJ0ufVTwDLLzA2Ti+tlsF22qk8Otb8Jgm+rEXz/uNXjDZEo492yvu/dLEfLeA02GzknXSv5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158705; c=relaxed/simple;
	bh=4MDsllLV1Hc+e+K41WVgks2P6/UD4rWVd+TwY6JnW9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO3tRyjzNXs768zFpMmZwST/YSW6mXAxbH2LEf4HiiPuDyc/USbI4DstL8uQJbmtHxLFFiUYDfhLCgZ3tvLvXWJwF9Z4jB/09T+grX4YtVc0Z/jKAwxuxPyEOg5V7xJm6Z0XdyUKGi291OhkIDdLn8dVb2q+TReYrg5t3XyxYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BPKix9sZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BPKix9sZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0OauXICVRshnOsCcsTH4k/CrOcm+Ne+ATnxs29a1Epw=; b=BPKix9sZsytzLkXkrGgu+Fpj4e
	PvTlN0iQRJY47XXRV4K48N8cSbe88w4wiWv5hanTNcEebdTHtA9igrikO1i3nX+IQd02eZBYvyUo0
	+Bo7Rw566VePqlwgMSG7EJan0ElIUZflmTlcXe17tVHRD8Uy/FJkJf7uS3TOQpBrvBzmczykcV9oe
	+KznycVpz1z9aBhCiEojgPehLapBqM8moj0YlZHLqx9ve5QVNHLDDeZ68NEb8J/iM0eV0ln0D8RvT
	xMseIWGJDhEQfBNQgyLgnDwUrjfMaQubbVTU4ihFLof0Jw3vSpGOszNQlCd14f1CyvWaeIFLFDdKh
	J21EZOcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ty7Cv-0000000DAIa-2zns;
	Fri, 28 Mar 2025 10:45:01 +0000
Date: Fri, 28 Mar 2025 03:45:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Karel Zak <kzak@redhat.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH util-linux] fallocate: add FALLOC_FL_WRITE_ZEROES support
Message-ID: <Z-Z9rZzoXzXltc3e@infradead.org>
References: <20250318073218.3513262-1-yi.zhang@huaweicloud.com>
 <j7o7bftkbz4fg7rt6s76q5qumie3lncauloft77k2nvnlyzd7a@pecviw4axn5w>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j7o7bftkbz4fg7rt6s76q5qumie3lncauloft77k2nvnlyzd7a@pecviw4axn5w>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 27, 2025 at 11:15:46AM +0100, Karel Zak wrote:
> On Tue, Mar 18, 2025 at 03:32:18PM +0800, Zhang Yi wrote:
> >  sys-utils/fallocate.1.adoc | 11 +++++++++--
> >  sys-utils/fallocate.c      | 20 ++++++++++++++++----
> >  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> The patch will be merged later if it passes CI tests. Thanks!

Please old off a bit.  For now the kernel side is just proposed and
not actually reviwed or merged.

