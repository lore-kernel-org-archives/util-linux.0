Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830D317178
	for <util-linux@vger.kernel.org>; Sun,  1 Mar 2026 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772366756; cv=none; b=qL1Ff2v5JA+bc+6WgPqKFM1qf/WTOBRiqjoO8iDRBMxWFG8bbh2i7F7h7x1AaDUVTSZufAFvbxffeFSs/OGDmLqkakDKjgxbmFXK4WT7Zxa91lcdcbz9hYr2eUgpg8me1F9sGaEiSLHntrz2AfZUCB0wXfp8Q9ux+XT5S3zogoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772366756; c=relaxed/simple;
	bh=mCy8osXEer4+rFf5Y1kGPSORWaBESQiLFPACgLQaPZM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JWx9mKs9pswId8ycP04wtxs9xDQzBkwmOyBbIKlJct0NZUjxQLQyFwV9z/WbsPt5jm+kPKJ4FOuEWN+Hb135kqtZC4527yPfTuF+QfNcbjSZxjqwjTOU7Ph+Csng1KjGZ0pQnhoq1FjE2iUt6lRRduRBilsYdbQT0D7AnavHkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ist.utl.pt; spf=pass smtp.mailfrom=ist.utl.pt; dkim=pass (1024-bit key) header.d=ist.utl.pt header.i=@ist.utl.pt header.b=1WwCHwVS; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ist.utl.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ist.utl.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ist.utl.pt header.i=@ist.utl.pt header.b="1WwCHwVS"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 53A5F6000257;
	Sun,  1 Mar 2026 11:56:36 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id Bhb2XzmKEA00; Sun,  1 Mar 2026 11:56:34 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id A925C6000873;
	Sun,  1 Mar 2026 11:56:33 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ist.utl.pt; s=mail;
	t=1772366193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCy8osXEer4+rFf5Y1kGPSORWaBESQiLFPACgLQaPZM=;
	b=1WwCHwVShCtw4ywY8AIAL3kdA2bPjtoYWtSIjMLjdB8QZJKRiWawtJZV/ZwEYxZGB1Ksyt
	JEL9Bwh1Cv9g7VNqNVyK5hkkpx1o7ZKe35FML3C2B/D2Ow11dfFOkTJMPY9WvSsl0SRmg/
	PrNjnJhRAJ8DA41sF3wBOqGyrDwSTb0=
Received: from [IPv6:2001:818:dc66:5e00:f787:58b7:73fd:39be] (unknown [IPv6:2001:818:dc66:5e00:f787:58b7:73fd:39be])
	(Authenticated sender: ist162465)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 7ACBD360178;
	Sun,  1 Mar 2026 11:56:33 +0000 (WET)
Subject: Re: [PATCH] findfs: (man) improve the markup, the layout, and the
 wording
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20260228115245.9553-1-bensberg@telfort.nl>
 <10nup2p$o2$1@ciao.gmane.io>
 <1922449f-ac4f-4362-92ed-0176243e11ac@telfort.nl>
From: Nuno Silva <nunojsilva@ist.utl.pt>
Message-ID: <c03c2f75-6960-8010-b356-94f6a3404d20@ist.utl.pt>
Date: Sun, 1 Mar 2026 11:56:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1922449f-ac4f-4362-92ed-0176243e11ac@telfort.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 01/03/26 11:25, Benno Schulenberg wrote:
>=20
> Op 28-02-2026 om 14:03 schreef Nuno Silva:
>> On 2026-02-28, Benno Schulenberg wrote:
>>> Drop the angle brackets around placeholders -- those are used
>>> in --help output, but in man pages it is just italics.
>>
>> My apologies if I'm missing some convention from util-linux itself,
>=20
> Have a look at some other util-linux man pages.=C2=A0 They all use just=

> italics for placeholders (normally displayed as underline).
>=20
>> from a quick check, it looks to me that italics is used for such
>> placeholders in IEEE 1003.1.
>=20
> And italics is exactly what this patch uses for placeholders.=C2=A0 (No=
t
> angle brackets -- those are for --help texts.)

Oh, sorry - I now realize I misunderstood the original e-mail. It is=20
embarassing; I should have double-checked things, namely the syntax=20
(which I overlooked in part because I *still* need to configure Gnus -=20
where I usually read this list - not to eat some of the characters when=20
applying formatting...).

That'd have probably made the meaning obvious. Instead, not being=20
acquainted with the syntax, I wrongly intepreted the commit message as=20
you meaning angle brackets would be removed because they mean/generate=20
italic.


--=20
Apologies again,
Nuno Silva

