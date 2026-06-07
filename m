Received: from smtp-out2-03.simnet.is (smtp-out2-03.simnet.is [194.105.232.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32B4071F5
	for <util-linux@vger.kernel.org>; Sun,  7 Jun 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.105.232.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850737; cv=none; b=cIX0DJFQXGz0qAVlMmXzjjX2YeXa8/TnLcT51GKaidmOE7flaHLy5hXlHJLf9O3rLuskSVwFabwL39WUg+B30zxN5twrnPIX68JzPiVxubzdcJNlJv/xagND0nghAMipIMzEURF1hIHZ1JKLPxa6xy/WD6xu2+NxBnBgtbbR9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850737; c=relaxed/simple;
	bh=zDATFv0kbplxyIZ2t6fG1mOzgRSXvGCdSgz3V65fUM0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l+IJHMAfGFkTMDu6J084AgNTnY3sV2wndemtgTsyvQmkiBuVRxw6SCY/hBXMLnbulxw9YbkoLG4ccA6IeISR2kjV92v9cMb7CIHohuo1kw0ZsOwS8xb1ZzWnYahMkLoAyLcfMGkM/E2ERU65X3L2zfqJxEjV5PZ9751+aU4xU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simnet.is; spf=pass smtp.mailfrom=simnet.is; dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b=bMtauFY/; arc=none smtp.client-ip=194.105.232.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=simnet.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simnet.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simnet.is header.i=@simnet.is header.b="bMtauFY/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1780850734; x=1812386734;
  h=date:from:to:subject:message-id:mime-version;
  bh=hqhvER+ALEHc++aahVU8uIoawLjj3Pcst/eLa05hH/Y=;
  b=bMtauFY/9b4zYTgbHrnnoJHGBEPcntkAZpqYRlj2tFMvzvFLk+nWwoQW
   ViM1Mzc//nj0AR1gmjCcWTpHbk7DMKLExGj/dLogB/FUpkfdogwmfCDYB
   4f/p1LkcoIznKEvjIsVI5QacoCGEjSQyQ64MtQlXv3Z1474i50oNVi/6F
   Yfigu9EuqWvTNMf1HZtAHprhmb5rMRKHPy9sK3vQktrz6DnS+w76f2ToL
   0j9dx1CipuAg3ZK25a7s0uDFhhhGJu4Y8EHrg89054hsZpQiC2KVy6RS4
   TaKsTOYbilXE+ZtpYJ7xULVwqseuXk11iaQ8jAHEzqiPYNEIgzZJayKtw
   w==;
X-CSE-ConnectionGUID: ynOPw11ySBmDP7TjgjE/2A==
X-CSE-MsgGUID: rj5uX/RiRgmzXxvCNuUoNA==
Authentication-Results: smtp-out-03.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 1.9
X-IPAS-Result: =?us-ascii?q?A2G4BADHniVqd9Niq09agluCP7lcDwEBAQ9RBAEBkjwoO?=
 =?us-ascii?q?QUNAQIEAwIDAQEBAQEBAQEBAQELAQEGAQEBAQEBBgcCEAFDDjuGCVOHI4Ewh?=
 =?us-ascii?q?lW1CIE0gQHeQoFygU6FcIJpAYsuBoINgUqIQ4V3BIIigQyQW4FKHANZLAFVE?=
 =?us-ascii?q?xcLBwWBZgOBBm4yHYEjPhczWBsHBYFKgjOBAoUSIx8DOYEXgXyBKGdpFTE3F?=
 =?us-ascii?q?wMLbT03FBuRH4F1pGajL4QmoXUzl1MMkwyZBqQhhR+CAIF+LAcaCDCDI1IZD?=
 =?us-ascii?q?44tFsktgTgHAgcPApNyAQE?=
IronPort-PHdr: A9a23:TPiyfRRSNS2dUfYF7WmHPPNoQdpso5DLVj580XJGo6lLbrzm+In+e
 RSEo+5siVnEQcPa8KEMh+nXtvXmXmoNqdaEvWsZeZNBHxkClY0NngMmDcLEQU32JfLndWo7S
 cJFUlINwg==
IronPort-Data: A9a23:hIGShaKWxutsE9CAFE+RS5QlxSXFcZb7ZxGr2PjKsXjdYENS0GABx
 jQbXz+PafbcMDb3KtglPo7ioR8Dv56By4RiHAsd+CA2RRqmi+KcXo3BcR2Y0wB+jyHnZBg6h
 ynLQoSYdKjYdleF+FH1dOSn9SAivU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRWmthg
 vus5ZeDULOZ82QsaDxMtfrc8EoHUMna4Vv0gHRvO5ing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KXBI0
 sQHcWkcVTqGq9rp/LC0SMQr3O12eaEHPKtH0p1h5S/YFupjU5HGW7/N9c4dhGt2mMFVAbDff
 KL1axIwPVKZPEQJawdRUstn9AurriCXnzlwolCcv6w24mf71w101rXxdtvOEjCPbZwNzx/I/
 zqfpwwVBDkANoGC+X2/80ijg/3/jT3Qfp8vE5uRo6sCbFq7nDdNVExJDDNXu8KRl1K/X5dbK
 koJ6gIwoqUosk+mVN/wW1u/unHsg/IHc8RRCPF/+gCI0rDT8xfcXjRCUD9adJonr6faWADGy
 HeYmfTRGmU2oYa/TF6lqYuWojGffnI8eDpqiTA/cecT3zX0iKAI5i8jo/59EbWpy8/0HCnqx
 CCb6XBiwasSltJN1r7TEbH7b9CE+8ehou0dvF+/soeZAuVRPt/Ni2uAswWz0Bq4BNzFJmRtR
 VBd8yRk0AzxMX19vHbWHrlcQ+jBCwetKzDamlcnEpkvnwmQF4qYVdkIullWfR41WvvojBewM
 Sc/TysItccLZBNHrMZfP+qMNijd5fG9TYy6CKiEPoAmj1oYXFbvwRyCrHW4hwjF+HXAW4lmU
 XtHWa5A1UonNJk=
IronPort-HdrOrdr: A9a23:s24q8aGHRPGEy9C7pLqFuZHXdLJyesId70hD6mlbaTh0NvaVks
 ylgfIBvCWE8Ar5OUtQ6uxoXZPqfZqyz/NICLcqTNKftXbdyRCVxe1ZnOjfKkTbakrDH7dmpM
 FdmstFea3N5DpB/LTHCWCDer4dKeW8gcKVbY239QYdcegDUcFdBmxCZTpzfHcbeOBuP+tGKH
 L1jvA32AaISDA5RYCaAWQIRO/KopnutL+OW299OzcXrCakyROu9bLgFBCcmjAZTjNB4ZpKyx
 m5ryXJooqJ99G91xPG0GfXq7NRhdvv18tbCKW3+7EoAwSppS3tRIN9V6aEtDVwm+2k6E8Lvb
 D30msd1mpIgU84FwmO0H/QMnHbsQrGkEWN9WOl
X-Talos-CUID: 9a23:yDcCrW1hwKlvRb6MfCoxxrxfC8YCSmKElWbrCUqUMTlVSrKXZBjK0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AIbM23w6n1mPzLBlOHVrRWDpNxoxy4fmzOAc3kK8?=
 =?us-ascii?q?Jvtu0JTJbHSqgixKeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,192,1774310400"; 
   d="scan'208";a="109181010"
Received: from vist-zimproxy-04.vist.is ([79.171.98.211])
  by smtp-out-03.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 16:44:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-04.vist.is (Postfix) with ESMTP id 5E16D609931E
	for <util-linux@vger.kernel.org>; Sun,  7 Jun 2026 16:44:22 +0000 (UTC)
Received: from vist-zimproxy-04.vist.is ([127.0.0.1])
 by localhost (vist-zimproxy-04.vist.is [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FJHpQv1tWRqb for <util-linux@vger.kernel.org>;
 Sun,  7 Jun 2026 16:44:22 +0000 (UTC)
Received: from kassi.invalid.is (85-220-33-163.dsl.dynamic.simnet.is [85.220.33.163])
	by vist-zimproxy-04.vist.is (Postfix) with ESMTPSA id 4A3D3609931A
	for <util-linux@vger.kernel.org>; Sun,  7 Jun 2026 16:44:21 +0000 (UTC)
Date: Sun, 7 Jun 2026 16:44:09 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: util-linux@vger.kernel.org
Subject: [man page] undefined string 'Aq'
Message-ID: <aiWf2S5xi0RgPW1U@kassi.invalid.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  The string 'Aq' is used (in .TH) before it is defined.

troff:/tmp/gz.roff.nYWBZY:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid.3.gz

troff:/tmp/gz.roff.PqGqW4:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_clear.3.gz

troff:/tmp/gz.roff.eqNIm0:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_compare.3.gz

troff:/tmp/gz.roff.6CFl2a:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_copy.3.gz

troff:/tmp/gz.roff.RqKhwy:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_generate.3.gz

troff:/tmp/gz.roff.ihqSVv:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_is_null.3.gz

troff:/tmp/gz.roff.bcxMBY:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_parse.3.gz

troff:/tmp/gz.roff.ZzxtTw:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_time.3.gz

troff:/tmp/gz.roff.uf4Wul:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/uuid_unparse.3.gz

troff:/tmp/gz.roff.jUYDWe:10: warning: name 'Aq' not defined [-w mac]
/usr/share/man/man3/libblkid.3.gz

  See also the lintian output in the Debian distribution for the
"uuid-dev" package.

  The same defects can be in other man pages.
