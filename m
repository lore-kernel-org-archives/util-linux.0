Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8BC216E25
	for <util-linux@vger.kernel.org>; Mon,  9 Dec 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740592; cv=none; b=BDMTzBHKIc6JYczD/h3yGw6y8X+kgv0UJiYftqBILNYTCYkT387n4VFNGwYlxbkHKUhJktSk7ucbtSifxgt30sqB25zlqQVOQtnSmW+tGs5q94ZratYhG1aeoNpJDAxfinzSdlnegs3OvVgxRyhDMu7Xu+CXyZZiUTnB8A/qbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740592; c=relaxed/simple;
	bh=U87xCoo4R1X37B2usVJb6PZY8bI8IM8+WfYWyaIIv9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRYMD5Z7WueapQbvj05WYbSVJf5Oz6e7+25WU6HIPCesCNOFjRtcvWyXSp6qAjvaoQvHXE4kojL5O14ttgLNDdAZXwZhl1t1YETCYDSAYvpESH6Czmy4kdA11qClZOW6PASoWpPl1bTibQsszJRSRYYsN2eudmvUHC662zFN5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=pDgC+rvg; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="pDgC+rvg"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <samuel.thibault@gnu.org>)
	id 1tKb7p-0000Mw-Mt; Mon, 09 Dec 2024 05:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
	Date; bh=fx7wuoUjWPxFi4bZcM6gN42b5SfP+BQqTm63hlPkCNg=; b=pDgC+rvgpEuGxzXVBWkX
	t3e2nRzYr3gts+15shm1h5DB67uMVebMBc4w950MBgV6kA1jGWzh2AJJxrun7t1w0VhtEFzcM2vgY
	0f39kLJmR1ICmKhj5dR7AjB+xN3PBgP7EzvJWcsxH4a2Ts2w8k7mZLOZwJg0E39laIQMB2QRLtKcs
	+klCLLuVXPiZiFZp/EgqvH2jRT6jbZnpiiaOcqAAvEFeFXGKlnH27Qs22YM6Q0yQh6iqv6uR37zri
	vItvsoL/X7jR1voFvo88ZgNrSpJxNgVBSlywZwDiPe5v4bFJmJwloee/sVIl2FOI2hpZoDGr6XWRe
	N8RSNWKadSkfQw==;
Date: Mon, 9 Dec 2024 11:36:22 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: Zhaoming Luo <zhmingluo@163.com>, util-linux@vger.kernel.org,
	bug-hurd@gnu.org
Subject: Re: [PATCH] hwclock: Support GNU Hurd
Message-ID: <Z1bIJjzgosmfF4xL@begin>
Mail-Followup-To: Karel Zak <kzak@redhat.com>,
	Zhaoming Luo <zhmingluo@163.com>, util-linux@vger.kernel.org,
	bug-hurd@gnu.org
References: <20241209025815.7299-1-zhmingluo@163.com>
 <kmz3eghhmo6rqlnenuwvcj3aa45elxajfdhwqiht52thxnb4qh@f2z34wslmajb>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kmz3eghhmo6rqlnenuwvcj3aa45elxajfdhwqiht52thxnb4qh@f2z34wslmajb>
Organization: I am not organized

Karel Zak, le lun. 09 déc. 2024 11:32:33 +0100, a ecrit:
> On Mon, Dec 09, 2024 at 10:58:15AM GMT, Zhaoming Luo wrote:
> >  	if (ctl->rtc_dev_name) {
> >  		rtc_dev_name = ctl->rtc_dev_name;
> > -		rtc_dev_fd = open(rtc_dev_name, O_RDONLY);
> > +		rtc_dev_fd = open(rtc_dev_name, O_RDWR);
> 
> Why do you need O_RDWR on HURD?

For setting the time, it makes sense to request WR?

> Maybe it would be better to add an
> #ifdef, as it is unnecessary for Linux.

I have to say I'm surprised that Linux doesn't require it for setting
the time.

Samuel
