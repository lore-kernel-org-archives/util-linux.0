Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C41F868D
	for <util-linux@vger.kernel.org>; Wed, 18 Dec 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541564; cv=none; b=ZreilqZhtP9UFBOBa4qP/4Gi1AjObNdxsV6e4S1d5+Ju2S4owLjDRb/kylipGvKRrxpH4bkmHmnQdoHKpFk04jebBN9/i4PV/34qDETur27qBz+ztbFVc7n0ZdSlZp9lglEojQ8wIm6+vJKZHmQDEb407EKBmtHSEBXyWMpzQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541564; c=relaxed/simple;
	bh=NiGlhUvnFB6Y9jUwpcswBIdyF84NWdhs9UCLDu7EMIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl6S9Hn7Wl/Cpyk+jTiy86LtUcfbCVg9JzRsBUfv4rWKB8S7Fs155DTiRWJ9A9GRkfqC3sXBzn0/jw6Vhqe78vUQE+FQAr2z8PPO5Am5XxEuF3fK+Tv2+QDEoP1p28JxmUTvuOTCeFCrCOFf421cKqjSGuvkb0uuxLsxDEefE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=Zw6M6l1y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="Zw6M6l1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1734541555; bh=NiGlhUvnFB6Y9jUwpcswBIdyF84NWdhs9UCLDu7EMIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zw6M6l1yAJmeQHwo+UZmeKFTYn+jDdno/0sDSHFzst7KOXP79QBnE9N2u3L6f8tY7
	 IDpPvcJU93V5optnuKSHh7ztYtkKdKLTnIevflXBwnyzXuofJVmuvh0B19fI8pGsWh
	 /6eMIrLaZnwJnZ5zk0ugTHBEVuoIiNVKXOH5Zu3U=
Date: Wed, 18 Dec 2024 18:05:54 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Karel Zak <kzak@redhat.com>
Cc: Zdenek Kabelac <zdenek.kabelac@gmail.com>, 
	Michael Chang <mchang@suse.com>, Glass Su <glass.su@suse.com>, Heming Zhao <heming.zhao@suse.com>, 
	"linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>, grub-devel@gnu.org, util-linux@vger.kernel.org
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
Message-ID: <860960db-bb66-453c-a392-1495690bb2ff@t-8ch.de>
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
 <yjiu3c3e4aknayawhw7lw52kev6fvp4wm6n6wte4t27hx3fr4u__21682.4523567752$1734439545$gmane$org@cc5bu2ij2ia3>
 <dbc7728b-352b-4982-a171-d8f177388a19@gmail.com>
 <hdqz3hun3f5ftfwvimlopkmuujimtz5ilovkuajqesy6p4a7jd@7w6nkryhr2y7>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hdqz3hun3f5ftfwvimlopkmuujimtz5ilovkuajqesy6p4a7jd@7w6nkryhr2y7>

On 2024-12-18 15:44:45+0100, Karel Zak wrote:
> On Wed, Dec 18, 2024 at 11:12:59AM GMT, Zdenek Kabelac wrote:

[..]

> > And in the same way blkid should expose installed grub loader - currently
> > the partition with installed grub looks 'empty' with blkid....
> 
> The issue I see is that boot loaders can coexist with filesystems on
> the same device. This can lead to unexpected warnings when attempting
> to view the contents of the device using mkfs tools.

Isn't this specifically about the grub second stage on GPT systems
inside a dedicated partition?
There should be no valid coexistence with a filesystem.

So having a probe in blkid looks reasonable to me.

Not that it helps in the specific case mentioned above, where everybody
is using --force anyways.


Thomas
