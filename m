Received: from mail01.ukr.de (mail01.ukr.de [193.175.194.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815091A28C
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.194.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004205; cv=none; b=iGDk0Gi8IeP7Udr8CG4xjtIfkIYtcDcRYNIqSTO7TYhPQxRxZAdOUDdOrkRCuxlipYxnkXb+J0a+ZjJg4iwbW1sKF33jiPO/HRp59EOfXm1CoveOnroqCetsz7AnxnUlwkimaPw/pC5/1KsOY3zInxfl7f1veea6EGIZVoJd95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004205; c=relaxed/simple;
	bh=TP+qTHi+xLaKd69vs7SxOzlVqUtM1BQiv5cz2H+IZiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aUU78G8QAZL6myO3gJzM1KuPAlDauoK5Xeh/ys4dVLrT5a8Y3Jvqoog5kq36X+Z+zKcn0+O9L+bCM7m1cJE0PVlyz2gwytFyOURmNvSWlEJJkmk6RvSwSwQ4BdP/Q3YzVrHMmoWoAjoIF3gszWcA6R1xfBOqY7KmxNUgrsJvkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de; spf=pass smtp.mailfrom=ukr.de; arc=none smtp.client-ip=193.175.194.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ukr.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ukr.de
X-CSE-ConnectionGUID: fZw1HZgKTEGNhRlnGgd48w==
X-CSE-MsgGUID: gq/1lAU5QxyKeGBoC09unw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="1178057"
X-IronPort-AV: E=Sophos;i="6.12,165,1728943200"; 
   d="scan'208";a="1178057"
Received: from unknown (HELO ukr-excmb03.ukr.local) ([172.24.6.63])
  by dmz-infcsg01.ukr.dmz with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 09:15:29 +0100
Received: from ukr-excmb03.ukr.local (172.24.6.63) by ukr-excmb03.ukr.local
 (172.24.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Nov
 2024 09:15:29 +0100
Received: from ukr-excmb03.ukr.local ([fe80::1cb4:6e0c:6da4:a8a0]) by
 ukr-excmb03.ukr.local ([fe80::1cb4:6e0c:6da4:a8a0%4]) with mapi id
 15.01.2507.039; Tue, 19 Nov 2024 09:15:29 +0100
From: "Windl, Ulrich" <u.windl@ukr.de>
To: Krister Johansen <kjlx@templeofstupid.com>, "util-linux@vger.kernel.org"
	<util-linux@vger.kernel.org>
CC: Karel Zak <kzak@redhat.com>, "systemd-devel@lists.freedesktop.org"
	<systemd-devel@lists.freedesktop.org>, David Reaver <me@davidreaver.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: RE: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Thread-Topic: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Thread-Index: AQHbOf62N1rTufxXrkOKiFKYcnEHp7K+QXPA
Date: Tue, 19 Nov 2024 08:15:29 +0000
Message-ID: <7bc43689ca4249f18c60fa4b063822ea@ukr.de>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
In-Reply-To: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
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
> Sent: Monday, November 18, 2024 9:35 PM
> To: util-linux@vger.kernel.org
> Cc: Karel Zak <kzak@redhat.com>; systemd-devel@lists.freedesktop.org;
> David Reaver <me@davidreaver.com>; Theodore Ts'o <tytso@mit.edu>
> Subject: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext superbl=
ock
> checksum mismatches
>=20
> Reads of ext superblocks can race with updates.  If libblkid observes a
[Windl, Ulrich]=20

I really wonder:

Can one single block be inconsistent when read, considering that the block =
on disk is not inconsistent?
That would mean that the block buffer you are reading is being modified by =
another process.
AFAIK the basic UNIX semantic guarantee that a block is read atomically; if=
 it's not, something is severely broken, and I don't think that O_DIRECT fi=
xes that.

