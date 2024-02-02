Received: from mail.totaltradecircle.com (mail.totaltradecircle.com [217.61.112.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344B560BB3
	for <util-linux@vger.kernel.org>; Fri,  2 Feb 2024 09:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.61.112.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864736; cv=none; b=QXfM01NeV5XrPBRcvikYPmasu5lVNz+xu5R0A4V2FY/9u0Xbk/Z0ZewWDLw21mcO30fkPEm3lh8zZGmwqu6Q/HzLmCeElfxZrtf/nxPdO64N1sRa87cYJbOY0sR/tslPcS45W4W2tzJIE5UmnhnspfiXz8aPXAqNIpiObd7JNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864736; c=relaxed/simple;
	bh=Q+o3lnpDoF2X+Yfrmflkha+YTGaWlcOIaDF4AiyLnGA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=Q0hjx3KrhzCau171ylvW5oq6Mpq9UFLQOoYNCSh8Qy3+KR3Mzd3TvFKFUWksa/kK3SWcgrB3ASrhxGTse9iHAXAsaqUFnMvs6JWT5YrRZ7AvWjY9aFAgFe7rTEbPSdAV81bDnQiJs5/bVFwLMtD9wNhN9vi03q6cgTpBRoCcmxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=totaltradecircle.com; spf=pass smtp.mailfrom=totaltradecircle.com; dkim=pass (2048-bit key) header.d=totaltradecircle.com header.i=@totaltradecircle.com header.b=UkfTT3j4; arc=none smtp.client-ip=217.61.112.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=totaltradecircle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=totaltradecircle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=totaltradecircle.com header.i=@totaltradecircle.com header.b="UkfTT3j4"
Received: by mail.totaltradecircle.com (Postfix, from userid 1002)
	id 50FC382B7B; Fri,  2 Feb 2024 10:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=totaltradecircle.com;
	s=mail; t=1706864723;
	bh=Q+o3lnpDoF2X+Yfrmflkha+YTGaWlcOIaDF4AiyLnGA=;
	h=Date:From:To:Subject:From;
	b=UkfTT3j4tX1/IZ5tNAbvvKID9SJ5UhffEE+psSOVClnp4wnvyf/r0eT6SVezboFkg
	 CuKEpQntt8HGWXPU4oa7dh8jsjiyrUerEhQzaXkH6Fbeh8V6jrDeen7vKnBZ6P9CBD
	 tG3k0xiiN3zq3ZhMmlZfeXf2d2w793G0OdZ4Rac6EVM7zMDdUgrGEEarJoCeYsr4Ft
	 9gTqhc+sKJ4AeFXl4ofr9xL8DVzWusLstLxIfTw2viso9maTW6kpiPiMhhGxHY8/Bk
	 8oV2DsAmhN30jEKYS012N+bzBplCfCAb7F+FvWgsBYTTpY3QHM6Fb85lxdyfi6KIou
	 9uEtfwI7Bs6lA==
Received: by mail.totaltradecircle.com for <util-linux@vger.kernel.org>; Fri,  2 Feb 2024 09:05:16 GMT
Message-ID: <20240202084500-0.1.2y.58rv.0.6a74ykag3e@totaltradecircle.com>
Date: Fri,  2 Feb 2024 09:05:16 GMT
From: "Edmond Downton" <edmond.downton@totaltradecircle.com>
To: <util-linux@vger.kernel.org>
Subject: Details of the order
X-Mailer: mail.totaltradecircle.com
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We are a manufacturing company from Poland, and we have created unique pa=
ckaging solutions that are a novelty in the market and work perfectly not=
 only for ice cream, sweets, and other snacks but also for funnels, candl=
es, and lanterns.

This is a reusable product with a delicate structure, lightweight, and an=
 attractive appearance. It offers an excellent alternative to traditional=
 napkins that become unpleasantly sticky and soft when exposed to moistur=
e.

If you are interested in such a solution, please contact us, and we will =
be happy to provide more details.


Best regards
Edmond Downton
