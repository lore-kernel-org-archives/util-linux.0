Received: from mail02.ukr.de (mail02.ukr.de [193.175.194.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699071A28C
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004469; cv=none; b=a6nGdw4Hxqc92kCekJf217Kq5BR3WDSAtTKA49Z8GSjm6fRtr6dnbVF4Z3D5ao2m/1SF739yX7c5M+0x4LZu9CfsiWSmrNm0pbUPOCzPbSMZ9iqbyorFsfQ97mFSvriui6IZFYN2tHX7I+6BPlTa2qBcx3QWYIepMEURlyoLSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004469; c=relaxed/simple;
	bh=Rjh+5AkQKR+Lynfk2rH5q4K8PsJOupeqRWpRMx4j2Tc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvKvrFtql3h7d693Oa1SiVdzzTqXsQtICGQrXdgFtfvmTjfXPN7fySFiB1AFMpSLt08tGvqfE0oOsTmUCb4vRE+mp3Ry5DM9j8ggCPaSjGytrOpIx6ebPTGeOYgWxYFJrnmEH9/xG+kUplxJNwa2XiclvqerWJmhfNZkL1jxHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: bcYlmuh8RHCzO9+zBny7yQ==
X-CSE-MsgGUID: Dye5k3AfTp2Mx+2D8/ogYQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="1182718"
X-IronPort-AV: E=Sophos;i="6.12,165,1728943200"; 
   d="scan'208";a="1182718"
Received: from unknown (HELO ukr-excmb04.ukr.local) ([172.24.6.64])
  by dmz-infcsg02.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 09:19:54 +0100
Received: from ukr-excmb03.ukr.local (172.24.6.63) by ukr-excmb04.ukr.local
 (172.24.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Nov
 2024 09:19:54 +0100
Received: from ukr-excmb03.ukr.local ([fe80::1cb4:6e0c:6da4:a8a0]) by
 ukr-excmb03.ukr.local ([fe80::1cb4:6e0c:6da4:a8a0%4]) with mapi id
 15.01.2507.039; Tue, 19 Nov 2024 09:19:54 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: Krister Johansen <kjlx@templeofstupid.com>, Lennart Poettering
	<lennart@poettering.net>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, Karel Zak
	<kzak@redhat.com>, "systemd-devel@lists.freedesktop.org"
	<systemd-devel@lists.freedesktop.org>, David Reaver <me@davidreaver.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: RE: [EXT] Re: [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Thread-Topic: [EXT] Re: [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Thread-Index: AQHbOgprtyS8p8SbNkmh7F6ouMqr3bK9mjcAgACo6DA=
Date: Tue, 19 Nov 2024 08:19:54 +0000
Message-ID: <246892aea2ef4119bb2b0b248c720737@ukr.de>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <ZzvBgOP_skwId4ci@gardel-login> <20241118231352.GC1885@templeofstupid.com>
In-Reply-To: <20241118231352.GC1885@templeofstupid.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
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

> -----Original Message-----
> From: systemd-devel <systemd-devel-bounces@lists.freedesktop.org> On
> Behalf Of Krister Johansen
> Sent: Tuesday, November 19, 2024 12:14 AM
> To: Lennart Poettering <lennart@poettering.net>
> Cc: util-linux@vger.kernel.org; Karel Zak <kzak@redhat.com>; systemd-
> devel@lists.freedesktop.org; David Reaver <me@davidreaver.com>;
> Theodore Ts'o <tytso@mit.edu>
> Subject: [EXT] Re: [systemd-devel] [PATCH] libblkid: fix spurious ext
> superblock checksum mismatches
>=20
...=20
> I may have done a poor job of explaining this.  This is ext writing its
> own superblock from the kernel, but reads seeing an potentially
> inconsistent view of that write.  O_DIRECT causes us to seralize with
> the locks ext4 holds when it writes the superblock, which prevents the
> read from observing a partial update.
>=20
> It's not necessarily the partitioning tools causing this, but any
> filesystem level udpdate that modifies the contents of the superblock.

As I wrote before: I don't think the needless O_DIRECT fixes things some ot=
her code broke.


