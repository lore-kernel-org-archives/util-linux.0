Received: from dsmtpq3-prd-nl2-vfz.edge.unified.services (dsmtpq3-prd-nl2-vfz.edge.unified.services [84.116.73.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB626ACC
	for <util-linux@vger.kernel.org>; Tue, 21 Apr 2026 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.116.73.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798081; cv=none; b=CvE+R8KiD1fxQHt+yRnu+OT0raNJGTNCIlGA12qbfN+/ViXFMVurBwVu7661obiHUqayUo48XPKpTCORm0rrJ1cVqp+fRtY34JV4CbZTgIcs53yEQk3HcoA+Y5KTokjTnrwhm1OHax/OPkln52PJieyQ1i0erJ9TR5W6ijDVc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798081; c=relaxed/simple;
	bh=lw2nTn/oX84kSwZPsZRUvgkbn/qp8AcYle25RlSU0WM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=gMNlXkibpl1+gw6DzgApxvx/TD/NGjjaZ+/sQobG6yyf/mDhHRpk/0Rw4IeKNjwZoav7mDBpgj6GTkGy+fWaFB1vMIoL45u8XYKfwaEe6yFDePYl/lzcSkrraYty5izK2AuSd2demCi+EWCot0DIsTV6Tre3DDzEed0h6eTZrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl; spf=none smtp.mailfrom=mrns.nl; dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b=W4QZNVGS; arc=none smtp.client-ip=84.116.73.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mrns.nl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mrns.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrns.nl header.i=@mrns.nl header.b="W4QZNVGS"
Received: from csmtpq2-prd-nl2-vfz.edge.unified.services ([84.116.73.110])
	by dsmtpq3-prd-nl2-vfz.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97)
	(envelope-from <dick@mrns.nl>)
	id 1wFFtV-00000006Ffq-2JEI
	for util-linux@vger.kernel.org;
	Tue, 21 Apr 2026 20:32:21 +0200
Received: from csmtp4-prd-nl1-vfz.nl1.unified.services ([100.107.80.23] helo=csmtp4-prd-nl1-vfz.edge.unified.services)
	by csmtpq2-prd-nl2-vfz.edge.unified.services with esmtp (Exim 4.97)
	(envelope-from <dick@mrns.nl>)
	id 1wFFtO-0000000HUMW-0LaS
	for util-linux@vger.kernel.org;
	Tue, 21 Apr 2026 20:32:14 +0200
Received: from routi.mrns.nl ([85.147.219.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
	(Client did not present a certificate)
	by csmtp4-prd-nl1-vfz.edge.unified.services with ESMTPSA
	id FFtNwsZ61nT9EFFtNwhmQD; Tue, 21 Apr 2026 20:32:14 +0200
X-Env-Mailfrom: dick@mrns.nl
X-Env-Rcptto: util-linux@vger.kernel.org
X-SourceIP: 85.147.219.207
X-CNFS-Analysis: v=2.4 cv=cPXQdFeN c=1 sm=1 tr=0 ts=69e7c2ae cx=a_exe
 a=QfPJp9Xx0fncKAcDTfo4/A==:117 a=QfPJp9Xx0fncKAcDTfo4/A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=LQrtYbNyCH8A:10 a=dnyXhxrFAAAA:8
 a=EU8yCZ3a01szK6Xjk-UA:9 a=QEXdDO2ut3YA:10 a=Jg-N2dyUoHYgGiKYQkJY:22
X-Authenticated-Sender: ieb1yoh3@ziggo.nl
Received: by routi.mrns.nl (sSMTP sendmail emulation); Tue, 21 Apr 2026 20:32:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrns.nl;
 i=@mrns.nl; q=dns/txt; s=mail; t=1776796333; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references :
 subject : from : to : date : message-id : from;
 bh=lw2nTn/oX84kSwZPsZRUvgkbn/qp8AcYle25RlSU0WM=;
 b=W4QZNVGSk29kFOurgi9g6J4ae+99CfYG4+2WNkj88hXz2nDAAPG9XQsskcEELDFJ40dNm
 KNhshnUsyacAEl1uLRad3P7PzBWH9Nm2etQjoS0WAg9/C2n5YixiG4lx8sLQa+SXMMFj4FP
 +XSrlDcEtEnhMDKWuFEGA+miDJq/t64=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260420180528.943663-1-stepnem@smrk.net>
References: <20260420180528.943663-1-stepnem@smrk.net>
Subject: Re: [PATCH] copyfilerange(man): fix swapped offsets in command example
From: Dick Marinus <dick@mrns.nl>
To: util-linux@vger.kernel.org, =?utf-8?b?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Date: Tue, 21 Apr 2026 20:32:13 +0200
Message-ID: <177679633333.3928851.10254342536502302818@routi.mrns.nl>
User-Agent: alot/0.12
X-CMAE-Envelope: MS4xfNEShY/ejA+3IbiooJYdrOXqNzX9NUEWGqkip242Uzc8w5c9W/iKICAw9VaPRrgOKXdexoQpVx7Db575ElbmbbQVPZCS22Q5fx9Cro7P/VRn/hKiw5R2
 tsUDcx1xz9rElTUITyoydzoPiMj49b8Ws26JRiTIlSWTjJLBEwZ6QDGrDXb2WjeOg0f1s9b8+bDE6DMFJv4/MVtmL+Znj+Ja7JFTcAYCF0IzcxfzzcMNc4WR

Thanks =C5=A0t=C4=9Bp=C3=A1n,

I mixed up, thanks for correcting this!

greetings,
Dick Marinus

Quoting =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (2026-04-20 20:05:28)
> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
> ---
>  misc-utils/copyfilerange.1.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/misc-utils/copyfilerange.1.adoc b/misc-utils/copyfilerange.1=
.adoc
> index 303a1a7b25e2..89b95e9516fa 100644
> --- a/misc-utils/copyfilerange.1.adoc
> +++ b/misc-utils/copyfilerange.1.adoc
> @@ -71,7 +71,7 @@
> =20
>  copyfilerange split-first-mb join ::
> =20
> -copyfilerange split-remainder join 1M::
> +copyfilerange split-remainder join :1M:
>  ....
> =20
>  =3D=3D SEE ALSO
>=20
> base-commit: 2f0a4512ea813b050172207c88ddfa9ace12d830
> --=20
> 2.53.0
>=20
>
