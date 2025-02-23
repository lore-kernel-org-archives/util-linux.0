Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEB22D7B7
	for <util-linux@vger.kernel.org>; Sun, 23 Feb 2025 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341625; cv=none; b=Z/PhkYDJgBz3h10H3whM2ReQZTok9MgoLB9mhauJnwsBSnQi93/NDVNtjG0PSOGiJmoNBHj/79pjpUHo6hMlFs1grb0ODLosKFzty1UPDS486XmDX5TKIItLwYs34Si9xhzj1yVrZwdiYlQI/i0zuACCkXLTFoSPmwzpHMIlNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341625; c=relaxed/simple;
	bh=qNdUGowvVwFKYqPzsL+ZfHfSz7u0j3oV0i+jrS1a5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8Zz3456u3VRlVJ7UwvVP/Bf9aDIDf+b2X0U6Dy5tAa4yTrClGLPj1XBdv9BWL4ofSx50JQtY63I0Yj3hMBcZS1T6LVRsiYrRCH/5XatWgGfAKg6qmBmjKLrlb10oLTSNllfFWFfqN+/+KPssIBSNrJt4S3sM2Ng0k2Of2aOcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ffr+uDQh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ffr+uDQh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4fLkfqMPcDNJpFcngnf/YC1lHWAQo48CPwCUEmuplPM=; b=ffr+uDQh5/pEvm359AM0CzXBek
	UXmHlpMTGr4mmpcD1u/ZkRYZWhlwl0LGPOUef+1NvVrv7yCmSIb9klvNPJN+kXId6kUZXJUdFug+A
	X9tqYqjQSjOP+6mI/AttbN8xTmLYOubXYk9I1bnFGnprwcTUpCpP8NmRBAjETtSHx+RnREqrweJCU
	ISKY8tzJbmJLkKytQJabApObRLjFZXfjxVonIuwJRbs2Qhj8eD4VCfMFyMfgh2Mkcq2v94JBu1if2
	9ypcGjviOSDUnKCu3WPNVgcAmnVlmyJKfeKnrnKEok67RBgqnTqvPb5deN6sN6EO6RBFLM5u9oOeT
	UOSFdwSw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tmIM8-00HMBo-1W; Sun, 23 Feb 2025 20:13:40 +0000
Date: Sun, 23 Feb 2025 21:13:39 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: 1098694-quiet@bugs.debian.org
Cc: Florian Bach <Leseratte10@vodafone.de>, util-linux@vger.kernel.org
Subject: Re: Bug#1098694: Crash in agetty due to invalid strncmp call in
 Trixie
Message-ID: <b5ikwzm4qjyxazwnck736kqdihgjmyjbsfuikfwntaece7fmmu@oxxt7prt45jz>
References: <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <tzuam3pqfrm6g7t4hwwapmpxxux75bf4vxd42qb6iode2hqnnx@ve4h5lyd3yp6>
 <bee22700-d1e4-42a2-9fe6-9ba9d2e64538@vodafone.de>
 <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
 <4ewlrlhq7eskooeb5h7v4p5qv6r3nvm2ubmuo5546lo5yxsrta@pr2horn2sxog>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ewlrlhq7eskooeb5h7v4p5qv6r3nvm2ubmuo5546lo5yxsrta@pr2horn2sxog>
X-Debian-User: zeha

* Chris Hofstaedtler <zeha@debian.org> [250223 20:06]:
> > [..] After I sent this bug report yesterday, I also found out that
> > someone has reported what I believe is the same bug to
> > upstream a while ago ( https://github.com/util-linux/util-linux/issues/3304
> > ) but so far nobody has commented on that report.
> 
> Yeah, this seems like the same issue.

Below is a patch that works, but certainly feels dirty:


From: Chris Hofstaedtler <zeha@debian.org>
Date: Sun, 23 Feb 2025 20:10:05 +0100
Subject: agetty: restore op->tty if getting the tty name fails

Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
---
 term-utils/agetty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index a382313..e65c985 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -929,9 +929,11 @@ static void parse_args(int argc, char **argv, struct options *op)
 	/* resolve the tty path in case it was provided as stdin */
 	if (strcmp(op->tty, "-") == 0) {
 		op->tty_is_stdin = 1;
+		const char* tty_orig = op->tty;
 		int fd = get_terminal_name(NULL, &op->tty, NULL);
 		if (fd < 0) {
 			log_warn(_("could not get terminal name: %d"), fd);
+			op->tty = tty_orig;
 		}
 	}
 
