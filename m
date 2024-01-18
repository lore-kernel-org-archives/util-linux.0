Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196ABA53
	for <util-linux@vger.kernel.org>; Thu, 18 Jan 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605344; cv=none; b=NJOuor9Ry0WED/em4sUWr/EJD3SX7S0bzbQkM/9tlXCCgP+xhbGrrCgYG2qdsjkDK9fzqYK2BHN/+a51DLeAt9sYPImZk6LPVBcg7DkXBkFKJXRkurnSgE64JbjAj/zMTHGsmpALRpuW5wSfFCnW+RShW0r3CbejxdyAK5MeTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605344; c=relaxed/simple;
	bh=L8SkkCPRGtUs4RM8PAkKuCwqNks2fBvnbZyM8DBr9Ug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DvemhOPG9a76JD4lFGx8b9QkJPxEzaTfiqLY0/xVWB30ZkWwqm2CLMwuujuBnJzWeSUaTWDbeRcyWBwkc7LYX6jba7RsZVWQQI9BnFtbdVlXTf5r3ZtXnCutiKmgwMwF6NshT87gpm7guXBG3DvNdurvO4ORmNyJKxts5onOU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=hi5poJEs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="hi5poJEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1705605332; bh=L8SkkCPRGtUs4RM8PAkKuCwqNks2fBvnbZyM8DBr9Ug=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hi5poJEsj3dv/54uBpEYtKUHE8WZJTH0ddFzRk9GL37sOQwv+Jr7L1BEWapqWrCfY
	 DH+Z+aZDoR25st/5l80Fh5bMF/kKe0BIpuGf2zNNsFNQqgzY2bQCKHqMizMfPYqGZQ
	 9VAmqBnMoI+3EwVDZls0gO3WruHUpxe2bwhSZnF8=
Date: Thu, 18 Jan 2024 20:15:29 +0100 (GMT+01:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Message-ID: <d74f50dc-3c9a-4fdb-9c63-45e093aed882@t-8ch.de>
In-Reply-To: <r3td5hqd23d4li67qtnkodkffgsduh6tehvek2kibz3yeizpck@tarta.nabijaczleweli.xyz>
References: <r3td5hqd23d4li67qtnkodkffgsduh6tehvek2kibz3yeizpck@tarta.nabijaczleweli.xyz>
Subject: Re: [PATCH] gpt-partnames: add "ChromeOS firmware" & doc link
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d74f50dc-3c9a-4fdb-9c63-45e093aed882@t-8ch.de>

Hi,

Jan 18, 2024 20:11:33 =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz=
>:

> I have a Chromebook, with fdisk -l of the internal flash being:

...

> diff '--color=3Dauto' -u -r util-linux-2.39.3.orig/include/pt-gpt-partnam=
es.h util-linux-2.39.3/include/pt-gpt-partnames.h
> --- util-linux-2.39.3.orig/include/pt-gpt-partnames.h=C2=A0=C2=A0 2023-11=
-30 11:26:09.675522060 +0100
> +++ util-linux-2.39.3/include/pt-gpt-partnames.h=C2=A0=C2=A0=C2=A0 2024-0=
1-18 19:00:19.208308527 +0100
> @@ -229,8 +229,10 @@
> DEF_GUID("49F48DAA-B10E-11DC-B99B-0019D1879648", N_("NetBSD RAID")),
>
> /* ChromeOS */
> +/* https://chromium.googlesource.com/chromiumos/docs/+/main/disk_format.=
md#partition-types */
> DEF_GUID("FE3A2A5D-4F32-41A7-B725-ACCC3285A309", N_("ChromeOS kernel")),
> DEF_GUID("3CB8E202-3B7E-47DD-8A3C-7FF2A13CFCEC", N_("ChromeOS root fs")),
> +DEF_GUID("CAB6E88E-ABF3-4102-A07A-D4BB9BE3C1D3", N_("ChromeOS firmware")=
),
> DEF_GUID("2E0A753D-9E48-43B0-8337-B15192CB1B5E", N_("ChromeOS reserved"))=
,
>
> /* MidnightBSD */

In a weird coincidence this was already added last week in https://github.c=
om/util-linux/util-linux/pull/2698


