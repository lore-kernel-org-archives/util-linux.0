Received: from mail.totaltradecircle.com (mail.totaltradecircle.com [217.61.112.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11FEEC2
	for <util-linux@vger.kernel.org>; Tue, 23 Jan 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.61.112.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001047; cv=none; b=lPhO1AiBXb1CuvSm99j3BlbzXcWZVbidRshAqNMA+OfbxLSOUVt5ZZXoxjQQsiDvU1Vhckjpnv5r8fM4DAClTZZ2EDT467a4GAiPKL5LB25QYVcxGehpWBq/QWM1oCatX8/dyj3LBdD6bz4mi8zQKaUfNc+Uk2V7yWqPY3tawUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001047; c=relaxed/simple;
	bh=Q+o3lnpDoF2X+Yfrmflkha+YTGaWlcOIaDF4AiyLnGA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=SXiHFl7hrjXE7rYBqUw3SEhKhMsbPHF0iQEfi6O4ZANjj9X/94sr5rmAgDdyjeR0RU1RJmTDRVhlQ0JIWwFVpHKAhX60IXrDbYK6mTvGOksk67KPXY0wsHm0Ytwk4OyPFKPmEflf1kFiHa/wRk87evvhtmVaBTFxirkCxqlos2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=totaltradecircle.com; spf=pass smtp.mailfrom=totaltradecircle.com; dkim=pass (2048-bit key) header.d=totaltradecircle.com header.i=@totaltradecircle.com header.b=jzXgO4l7; arc=none smtp.client-ip=217.61.112.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=totaltradecircle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=totaltradecircle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=totaltradecircle.com header.i=@totaltradecircle.com header.b="jzXgO4l7"
Received: by mail.totaltradecircle.com (Postfix, from userid 1002)
	id 54C9582872; Tue, 23 Jan 2024 10:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=totaltradecircle.com;
	s=mail; t=1706001034;
	bh=Q+o3lnpDoF2X+Yfrmflkha+YTGaWlcOIaDF4AiyLnGA=;
	h=Date:From:To:Subject:From;
	b=jzXgO4l7rNbaLrU04wWOkdupufx/w2FkskI7WsnpLRBavoHH9xlAJ6N6uX/nibtcf
	 UCGFCmPXXPCK2AaBDs1ngXMYvLV2lo2GYdnkvVfb9aigNnAUKZoJH1QFWttRbVSGZN
	 E/2OySnXrMVpdqvmhqpcDZhkZsdupalBJyDY9AusFmSXITh/FPfs6k3dGeFn1yGNGP
	 W80TdNJHb1oI7L2NctMrkbdhCGuTDa/gxlsEjbC/QZATkYlEQKmS+agoRu6TxJnp8/
	 PzHy9N0YTTfNC7m88kINb1scJwo3eMESnnc7364KS+Cc4BsM7d4GWy8mKmot6V4Tom
	 +LKuprsw+fctA==
Received: by mail.totaltradecircle.com for <util-linux@vger.kernel.org>; Tue, 23 Jan 2024 09:10:25 GMT
Message-ID: <20240123084500-0.1.2q.58rv.0.qazcjh1fps@totaltradecircle.com>
Date: Tue, 23 Jan 2024 09:10:25 GMT
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
