Received: from us.checkpoint.com (us.checkpoint.com [209.87.220.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2533F7
	for <util-linux@vger.kernel.org>; Thu,  8 Aug 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.87.220.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140450; cv=none; b=fjW6OZ4SSSzc9hgP9DFlYlkCGlmG4a8DEWgMVGnJTblVt9+A4aSj/LKAWZ1ln4SJpy6dhcFsDM/GBcYrOzl/PBBQOfj6uGE2u148ZbQhhJTMY0yi73IhKe2BinJHGi47PXqAn99kkBwoN826tVjpNyjx8fhr4xc07RJ1o6TZ5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140450; c=relaxed/simple;
	bh=0VyjbmRRJyZqF9MWURcAp/z6m8KqmP6nUB2ueKRunDM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XGLmI0z1dqmrUi2oz1cH9cRskfszYXdCi96qsF6VEMv7y76cA6x0BOSlUrW8NYDUfUfhe4Y92a6zK2w/5Kx+b7ufMc1WdqybGpN2oyRJaSLu1u09nRjq4NisaBMEVJ2VKaWbY30HxDKnP7a0BP3S/Rn/Co4Vk244OxKY7npAHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=checkpoint.com; spf=pass smtp.mailfrom=checkpoint.com; dkim=pass (1024-bit key) header.d=checkpoint.com header.i=@checkpoint.com header.b=DWmVOZwu; arc=none smtp.client-ip=209.87.220.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=checkpoint.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=checkpoint.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=checkpoint.com header.i=@checkpoint.com header.b="DWmVOZwu"
x-m-msg: CPCHECK
DKIM-Filter: OpenDKIM Filter v2.11.0 us.checkpoint.com 478I7S2S007902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=checkpoint.com;
	s=default; t=1723140448;
	bh=0VyjbmRRJyZqF9MWURcAp/z6m8KqmP6nUB2ueKRunDM=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=DWmVOZwu4h1Br/jl8L1LMIoQroPDaIl4/BmvB1puVGRk7T7I+QD4oYrq94vOdyF/3
	 d5VpzrOAQ/ktwN9HIZkXNkozhBceYh5uMfnLEZNqGeoOPNlXNvaKVnSkBxJOoD41B4
	 sEab5KGXAGfl1RL34mLBQTxpKclO4uas9gBtpzrg=
Received: from usp-sjc-ex03.ad.checkpoint.com (usp-sjc-ex03.ad.checkpoint.com [209.87.220.182])
	by us.checkpoint.com () with ESMTP id 478I7S2S007902
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Thu, 8 Aug 2024 11:07:28 -0700
Received: from usp-sjc-ex01.ad.checkpoint.com (209.87.220.181) by
 usp-sjc-ex03.ad.checkpoint.com (209.87.220.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 11:07:26 -0700
Received: from usp-sjc-ex01.ad.checkpoint.com ([209.87.220.181]) by
 usp-sjc-ex01.ad.checkpoint.com ([209.87.220.181]) with mapi id
 15.01.2507.039; Thu, 8 Aug 2024 11:07:26 -0700
From: Jeremy Dilatush <jdilatus@checkpoint.com>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: RE: util-linux bug: mkfs(8) has -V for -v
Thread-Topic: util-linux bug: mkfs(8) has -V for -v
Thread-Index: AdrpucAEdBN7+r7oQ4uMqf/YerltKAAA2KOg
Date: Thu, 8 Aug 2024 18:07:26 +0000
Message-ID: <0ca8b22dbbde43e0b65857877ec9a624@checkpoint.com>
References: <28f8d3ca8b3545e5af64e2a7699b4b03@checkpoint.com>
In-Reply-To: <28f8d3ca8b3545e5af64e2a7699b4b03@checkpoint.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> The manpage mkfs(8) lists "-V, --verbose" which should be "-v, --verbose"=
 (uncapitalized).
> Seen on as recent a version as 2.38.1 (on Raspberry Pi OS), also seen on =
2.23.2 (on CentOS 7).
> Not as trivial a fault as it might seem, since "-V" unlike "-v" causes mk=
fs to do nothing.

25% user error on my part: Looks like there are two bugs here and one is al=
ready fixed:
"mkfs -j -t ext4 -V Tempy" gives version on 2.23.2 but verbose on 2.38.1.
The manpage still probably should have "-v, --verbose".

--- Jeremy

