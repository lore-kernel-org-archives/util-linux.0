Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BF1898FB
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883915; cv=none; b=CX2BdcqhcV828r9g30vVo2Xz6ICkUJykAMvDlmf+qZcc1kIQXAu/J6STUVQzUkflBJPs/0mtZ3s8eeGEWsC/Em/PlMK8NrOrGE2HcQB34x1/WFo6Akr9i52IZC9Lh1Q8sIH+L96tpY4M8CHi+U0GlthCz6EbKg/JVEgBFjC8shE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883915; c=relaxed/simple;
	bh=wLkSq8atAqWDTEXGIp+l8XZI088r9zMBtRHoscp/kFg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=eARsC3s83NLbyF0Mp26ULz/0o4NgEhupOb2vPe2gCNepFwPgBoyHlPMxIjhSPx2oFzTZFxa+7P4yFYDvZeO2J4CazP/Ppsge2wgEy8w8TWSPgjqxPiwAVCMxDUkwDQotfr1NZ9rqxV3KmGkDpaQlkAVm9i6Rt+IsTRdt+1/Eqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc; spf=pass smtp.mailfrom=jarry.cc; dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b=HIyOlejL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nNq6EM2X; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarry.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jarry.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jarry.cc header.i=@jarry.cc header.b="HIyOlejL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nNq6EM2X"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 799771380428;
	Thu, 17 Apr 2025 05:58:32 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 05:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744883912;
	 x=1744970312; bh=6RSgZx464pf2wj1ZU2MzSCeRGJTzrKL+zRy6tk2Q4Eg=; b=
	HIyOlejLEJAn7qR/Y0cF65RAkY+Ay5oDtkvJmvgrYs7qEU6Qe5p0vbpsHa8A6G+t
	2nPx9vZ1JeJ25inSkDC617Jw4hNWu7eNLcqyENKOe2xFcSC4OAcMYlGgAbM5P8HM
	pQGbE03rnsHZZj4rcdxs32wavZQEB+kauVkGX9Zr0iBRPOv8ukp8SVUQpmcLN2P2
	yl0Gun1SN5tDLZPwDADc0v40Hxo/PcMNpRlmuovWted2YfDoHRvjyPVRu8G0EV/R
	11Mm4suHMdPsvQNBVnwMyIreh9ucb3VbyHFylxTlbCP9OoizQeU3+DpqDuXRaD7u
	D5QHHPp22E/ZXn3kRycUzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744883912; x=1744970312; bh=6
	RSgZx464pf2wj1ZU2MzSCeRGJTzrKL+zRy6tk2Q4Eg=; b=nNq6EM2XR/QUrPcY8
	u9GnGofS5c41j/+rbnHbfYHun2qEzaLqX0vs1U/qcQKN+9HW856u4sT3Mkns9QnF
	fGIcsuzJK91M4auS0wBInlhVHO+j+AizOuPkNCJhcD1cLxBoaGD/v8A8XGXWB/xy
	vROwscL4ImXHCd6MSyDhdQc9DwABmfNDhRt+ftPHXUnHod4W0grnT1HgdJHhO0WR
	UokOKK7MCLtN8SuiaL+iseg6xFHCfARPIZJkVw+LzYYAxmm0sh20oSq0gh9cOSQH
	Nir60cFnzXf5CwI1tcO606McpS9JXT+X97QdalKjj7fOQzrVqu9s8lF3tDTV/nzz
	wsViA==
X-ME-Sender: <xms:yNAAaLAEQPHDKZmPznhjN2DuhLPVjYJGoU-FrX3dQ8Pw1bZZg-4oQA>
    <xme:yNAAaBg7rnay7Q_HhOwsHQ4HbeQZsGvEu7y5vdCnIWsUWjgn2GLwZDp_blzLfzN8k
    zZfH0_u5LseCugj544>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffuc
    dlfedtmdenucfjughrpefoggfgtgffkffuhffvfghfjgesthhqredtreerjeenucfhrhho
    mhepfdftohgsihhnucflrghrrhihfdcuoehrohgsihhnsehjrghrrhihrdgttgeqnecugg
    ftrfgrthhtvghrnhepheefleeuhfelkeevheegkeetvdejjedugfejtefgkefhueffueff
    uedvveehfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhhosghinhesjhgrrhhrhidrtggtpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnshgsvghrghesthgvlhhfohhrthdrnhhlpd
    hrtghpthhtohepuhhtihhlqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yNAAaGkRx1IXqfaF6exVO2UoK82_o6napLnmMQ_OzwpGHp16_evkwA>
    <xmx:yNAAaNwrFnjg7OR0FyLiI5EqIxkUZ27TRYIx5olpQzy9BeBZIV556A>
    <xmx:yNAAaAQZ7H97_YR-h5JY_KAvA4aiQCGgDzk9CQM-ORoHBNZ_tUW14w>
    <xmx:yNAAaAbblp5R8qnqINA-kN2ICQKy_ouie5odpeO9eBeVqXQ8OFhtwQ>
    <xmx:yNAAaNhd73b9pgbQXKl9Il3Hk8zfN9jZ9WT8JtojWAptGf6AMcUlcqQi>
Feedback-ID: ic641498e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45EFD2220073; Thu, 17 Apr 2025 05:58:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Apr 2025 11:58:31 +0200
Message-Id: <D98TQ2YGI9TT.29EIM96TKSRJO@ringo>
Subject: Re: [PATCH 01/10] bits: (man) normalize the markup and improve some
 layout
From: "Robin Jarry" <robin@jarry.cc>
To: "Benno Schulenberg" <bensberg@telfort.nl>, <util-linux@vger.kernel.org>
User-Agent: aerc/0.20.1-64-g7cb8e0e7ce24-dirty
References: <20250417094825.20870-1-bensberg@telfort.nl>
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>

Hi Beno,

Benno Schulenberg, Apr 17, 2025 at 11:48:
> The convention in man pages is: to put command arguments in lowercase
> and without angle brackets (these are for --help texts), and without
> unneeded abbreviations.  Literal values (as in some examples) should
> be in bold, not in italics.
>
> CC: Robin Jarry <robin@jarry.cc>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Reviewed-by: Robin Jarry <robin@jarry.cc>

Thanks for the cleanup!
