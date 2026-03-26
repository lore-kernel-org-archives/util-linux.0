Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3831195C;
	Thu, 26 Mar 2026 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533686; cv=none; b=LfrzxRyRd67Gxm3kOhuf3RqQgZc3RtX/9Dz/LUpW3KKQjJkMHzfigtccCWTOKwNn7umn5tSxteaD9SDtTexVHzXNH5TmRG74SmEFmEXetxkTeha+Hp3y5XktO4ASDf4kr/xvkGpmY8LFLuk5jZfFOaTT0Zr+z7byVJl7uZVGQVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533686; c=relaxed/simple;
	bh=O5z3AHfPjBLSFZMnZWCEIKY7WVKpRIQq0yGGRZaGP08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBSj9bpu63sSxma/ZZHsSTfXMf26r/MZZPpVDJ93850RVXcc+jJ5hUcoC+yf0QneRC2sRnwMvut/+iGKRPgvlnw/GPvkrZANwKZqWG5PZKcRdBlNdxdnlBwiD8qsvI9AzkWaFeUubNwp02A3ufJ+K02BKDraDiczr5DXtaUrZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Pl0w/9Ci; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Pl0w/9Ci"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NWE5Zqu/yl/tHooarU3f7zwcnwen19kQOaTvrYd75nQ=; b=Pl0w/9CiOvYbqUk/XUdoCmWJHt
	+TA8LNYBX1oKcYlCUoOL4uzZ7Qg+JMehMJJZiKumiUUryiYleQhmJUoGoDD/wKZuHTAMUwE97Lc1s
	/l0XrTKs+xgP6wmv9Td6341IizK2KHzC4cBRt6RNQDCWU4ucyvXdSimsRU3ilZRkvu1HVm5uQiVL5
	tK8FtD1qDJz+x1173/w7jmF3SExq/xN/yJcIDDBYvvTMZQgYteMF4waSokj7rXVIElJpZxm5OdMvf
	378UHA2ZMIwrWrGBzcMICn6rOqIOq7aq2Fg68M0qX08xKms306Z9seO6U1aB+28lyA4iO0WV4nQw1
	CF5viN5Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1w5lGx-009tuX-7Z; Thu, 26 Mar 2026 14:01:19 +0000
Date: Thu, 26 Mar 2026 15:01:16 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
Cc: Karel Zak <kzak@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, Helmut Grohne <helmut@subdivi.de>
Subject: Re: unshare regression in 2.42-rc1
Message-ID: <acU7uB76HwZlBu6B@zeha.at>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <ab_SfC1JDOhNmg6D@zeha.at>
 <SJ0P220MB05417CC33D6BA305A9CEE320E94AA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <SJ0P220MB05417CC33D6BA305A9CEE320E94AA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
X-Debian-User: zeha

Hi Christian,

* Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu> [260322 13:57]:
>Thank you for pointing out this regression.
>
>The problem is that if ul_getuserpw_str() cannot find any user with the provided
>UID or username, the unshare internal helper function get_user() will error out
>and stop argument parsing, even if a valid numeric value was provided. Previously,
>the code would fallback to simply converting the string to an unsigned int and use
>it for the uid_t, so I added that behavior back.
>
>I found this issue to be true for the --map-group option as well, so I went ahead and fixed
>both cases in this latest patch: https://github.com/util-linux/util-linux/pull/4134/changes/c74df906b67b2f9930662ca4e1ba04c21569d529
>
>Please let us know if this fixed the problem on your end.

With the patch applied, the debvm tests succeed once again.
So this seems good.

I see Karel has in the meantime merged a different approach. I'll 
recheck with 2.42-rc2.

Thank you,
Chris

