Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF030C62F
	for <util-linux@vger.kernel.org>; Sat, 13 Dec 2025 23:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765669451; cv=none; b=UeI+US3aXbkUCP6xlFhou16NFcvfacMLliSDjXekGDRE327+OCaKoj9D5TQ1WdFQg01fn46NrlTovpjkk+vMiLXBadHDJv/j3rmEBrE16ESqzRrkiBjJ5hkiYw3t4fOWzmRIHTmwLncmCaaSfZIGrVuOfmj7DJ8mQiRFq2MwG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765669451; c=relaxed/simple;
	bh=EUwlgiFgF4swYS3glX4FN/Agg9ia//rFJCvC0/x+mvY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lER+KzuTdOrIGBdzrovJJxB6SbH+hByMvo3ekCdjoBLgDV5bIMsu9f+fK/kdxPF86WgOdEqlmmdvgwVBeI1SRwVZKzt89pgmGbmC9AngvS76a9vIdxEyaJT9P2nMsGirWgcKMaRtuRIbHIcxnSjRko1XWoaf5hIOF0rQzpdH6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=pQBmO3xv; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="pQBmO3xv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1765669005; bh=EUwlgiFgF4swYS3glX4FN/Agg9ia//rFJCvC0/x+mvY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pQBmO3xvIHSDYvTD0d8hlonTLR9pMwrbXPx6f5VGbysFoPhA2NhptHgPW1jrFi9ok
	 CPjDVupqwA623O19PriSidpF9HeIpfQBojbwKh5w5uQ6yv/XcCG7EIXyo2365FE+df
	 dIw6/7qgMQ/aOt7nrlEyAGcWx8AxtWDRcrAmwQJs=
Date: Sun, 14 Dec 2025 08:36:31 +0900 (GMT+09:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Message-ID: <d8549683-abb0-4099-838b-b1dcd50f0b81@t-8ch.de>
In-Reply-To: <20251213200410.31256-1-kiranrangoon0@gmail.com>
References: <20251213200410.31256-1-kiranrangoon0@gmail.com>
Subject: Re: [PATCH] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d8549683-abb0-4099-838b-b1dcd50f0b81@t-8ch.de>

Hey Kiran,

thanks for your patch!


Dec 14, 2025 05:04:23 Kiran Rangoon <kiranrangoon0@gmail.com>:

> gregorian_to_unix now returns -1 and sets errno=3DEOVERFLOW
> for timestamps before the Unix epoch. uuid_time_v1 and uuid_time_v6
> now use signed arithmetic to prevent unsigned wraparound.
>
> This fixes uuidparse displaying far-future dates for historical UUIDs.

Can you add an example for the issue here?

>
> Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
> ---
> libuuid/src/uuid_time.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)

Could you also add some tests?

>
> diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
> index c7516152b..b7fcc892d 100644
> --- a/libuuid/src/uuid_time.c
> +++ b/libuuid/src/uuid_time.c
> @@ -60,15 +60,22 @@
> /* prototype to make compiler happy */
> time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
>
> -static uint64_t gregorian_to_unix(uint64_t ts)
> +static int64_t gregorian_to_unix(uint64_t ts)
> {
> -=C2=A0=C2=A0 return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
> +=C2=A0=C2=A0=C2=A0 uint64_t offset =3D ((((uint64_t) 0x01B21DD2) << 32) =
+ 0x13814000);

In general, IMO we should just use a 64bit constant here instead of the cal=
culation.
(Not your fault obviously)

> +
> +=C2=A0=C2=A0=C2=A0 if (ts < offset) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errno =3D EOVERFLOW;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;

Instead of erroring out here, do you think it would be possible to
gracefully handle such negative values through changes in some other places=
?

> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return ts - offset;
> }
>
> static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
> {
> =C2=A0=C2=A0=C2=A0 uint32_t high;
> -=C2=A0=C2=A0 uint64_t clock_reg;
> +=C2=A0=C2=A0 int64_t clock_reg;
>
> =C2=A0=C2=A0=C2=A0 high =3D uuid->time_mid | ((uuid->time_hi_and_version =
& 0xFFF) << 16);
> =C2=A0=C2=A0=C2=A0 clock_reg =3D uuid->time_low | ((uint64_t) high << 32)=
;
> @@ -80,7 +87,7 @@ static void uuid_time_v1(const struct uuid *uuid, struc=
t timeval *tv)
>
> static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
> {
> -=C2=A0=C2=A0 uint64_t clock_reg;
> +=C2=A0=C2=A0 int64_t clock_reg;
>
> =C2=A0=C2=A0=C2=A0 clock_reg =3D uuid->time_low;
> =C2=A0=C2=A0=C2=A0 clock_reg <<=3D 16;
> --
> 2.47.3

